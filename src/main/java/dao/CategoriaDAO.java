package dao;

import model.Categoria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

// DAO responsavel por todas as consultas SQL da entidade Categoria.
public class CategoriaDAO {

    public boolean inserir(Categoria categoria) throws SQLException {
        String sql = "INSERT INTO categoria(nome, descricao, imagem) VALUES (?, ?, ?)";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            preencherParametros(stmt, categoria);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean atualizar(Categoria categoria) throws SQLException {
        String sql = "UPDATE categoria SET nome = ?, descricao = ?, imagem = ? WHERE id = ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            preencherParametros(stmt, categoria);
            stmt.setInt(4, categoria.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean excluir(int id) throws SQLException {
        String sql = "DELETE FROM categoria WHERE id = ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public Categoria buscarPorId(int id) throws SQLException {
        String sql = "SELECT id, nome, descricao, imagem FROM categoria WHERE id = ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return montarCategoria(rs);
                }
            }
        }

        return null;
    }

    public ArrayList<Categoria> listar() throws SQLException {
        String sql = "SELECT c.id, c.nome, c.descricao, c.imagem, COUNT(p.id) AS total_produtos " +
                "FROM categoria c LEFT JOIN produto p ON p.categoria_id = c.id " +
                "GROUP BY c.id, c.nome, c.descricao, c.imagem ORDER BY c.nome";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             Statement stmt = conexao.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            ArrayList<Categoria> categorias = new ArrayList<>();
            while (rs.next()) {
                Categoria categoria = montarCategoria(rs);
                categoria.setTotalProdutos(rs.getInt("total_produtos"));
                categorias.add(categoria);
            }
            return categorias;
        }
    }

    public ArrayList<Categoria> buscarPorNome(String nome) throws SQLException {
        String sql = "SELECT c.id, c.nome, c.descricao, c.imagem, COUNT(p.id) AS total_produtos " +
                "FROM categoria c LEFT JOIN produto p ON p.categoria_id = c.id " +
                "WHERE LOWER(c.nome) LIKE LOWER(?) " +
                "GROUP BY c.id, c.nome, c.descricao, c.imagem ORDER BY c.nome";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setString(1, "%" + nome + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                ArrayList<Categoria> categorias = new ArrayList<>();
                while (rs.next()) {
                    Categoria categoria = montarCategoria(rs);
                    categoria.setTotalProdutos(rs.getInt("total_produtos"));
                    categorias.add(categoria);
                }
                return categorias;
            }
        }
    }

    private void preencherParametros(PreparedStatement stmt, Categoria categoria) throws SQLException {
        stmt.setString(1, categoria.getNome());
        stmt.setString(2, categoria.getDescricao());
        stmt.setString(3, categoria.getImagem());
    }

    private Categoria montarCategoria(ResultSet rs) throws SQLException {
        Categoria categoria = new Categoria();
        categoria.setId(rs.getInt("id"));
        categoria.setNome(rs.getString("nome"));
        categoria.setDescricao(rs.getString("descricao"));
        categoria.setImagem(rs.getString("imagem"));
        return categoria;
    }
}
