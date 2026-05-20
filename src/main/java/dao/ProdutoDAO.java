package dao;

import model.Produto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

// DAO responsavel por persistir e consultar produtos no PostgreSQL.
public class ProdutoDAO {

    public boolean inserir(Produto produto) throws SQLException {
        String sql = "INSERT INTO produto(nome, descricao, preco, quantidade, estoque_minimo, imagem, categoria_id) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            preencherParametros(stmt, produto);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean atualizar(Produto produto) throws SQLException {
        String sql = "UPDATE produto SET nome = ?, descricao = ?, preco = ?, quantidade = ?, " +
                "estoque_minimo = ?, imagem = ?, categoria_id = ? WHERE id = ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            preencherParametros(stmt, produto);
            stmt.setInt(8, produto.getId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean excluir(int id) throws SQLException {
        String sql = "DELETE FROM produto WHERE id = ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    public Produto buscarPorId(int id) throws SQLException {
        String sql = sqlBase() + " WHERE p.id = ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return montarProduto(rs);
                }
            }
        }

        return null;
    }

    public ArrayList<Produto> listar(String busca, Integer categoriaId) throws SQLException {
        StringBuilder sql = new StringBuilder(sqlBase() + " WHERE 1 = 1");

        if (busca != null && !busca.isBlank()) {
            sql.append(" AND LOWER(p.nome) LIKE LOWER(?)");
        }

        if (categoriaId != null && categoriaId > 0) {
            sql.append(" AND p.categoria_id = ?");
        }

        sql.append(" ORDER BY p.id DESC");

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql.toString())) {

            int indice = 1;
            if (busca != null && !busca.isBlank()) {
                stmt.setString(indice++, "%" + busca + "%");
            }
            if (categoriaId != null && categoriaId > 0) {
                stmt.setInt(indice, categoriaId);
            }

            return executarLista(stmt);
        }
    }

    public ArrayList<Produto> listarRecentes(int limite) throws SQLException {
        String sql = sqlBase() + " ORDER BY p.id DESC LIMIT ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            stmt.setInt(1, limite);
            return executarLista(stmt);
        }
    }

    public ArrayList<Produto> listarEstoqueBaixo() throws SQLException {
        String sql = sqlBase() + " WHERE p.quantidade <= p.estoque_minimo ORDER BY p.quantidade ASC, p.nome";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {
            return executarLista(stmt);
        }
    }

    private String sqlBase() {
        return "SELECT p.id, p.nome, p.descricao, p.preco, p.quantidade, p.estoque_minimo, " +
                "p.imagem, p.categoria_id, c.nome AS categoria_nome " +
                "FROM produto p INNER JOIN categoria c ON c.id = p.categoria_id";
    }

    private void preencherParametros(PreparedStatement stmt, Produto produto) throws SQLException {
        stmt.setString(1, produto.getNome());
        stmt.setString(2, produto.getDescricao());
        stmt.setBigDecimal(3, produto.getPreco());
        stmt.setInt(4, produto.getQuantidade());
        stmt.setInt(5, produto.getEstoqueMinimo());
        stmt.setString(6, produto.getImagem());
        stmt.setInt(7, produto.getCategoriaId());
    }

    private ArrayList<Produto> executarLista(PreparedStatement stmt) throws SQLException {
        ArrayList<Produto> produtos = new ArrayList<>();
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                produtos.add(montarProduto(rs));
            }
        }
        return produtos;
    }

    private Produto montarProduto(ResultSet rs) throws SQLException {
        Produto produto = new Produto();
        produto.setId(rs.getInt("id"));
        produto.setNome(rs.getString("nome"));
        produto.setDescricao(rs.getString("descricao"));
        produto.setPreco(rs.getBigDecimal("preco"));
        produto.setQuantidade(rs.getInt("quantidade"));
        produto.setEstoqueMinimo(rs.getInt("estoque_minimo"));
        produto.setImagem(rs.getString("imagem"));
        produto.setCategoriaId(rs.getInt("categoria_id"));
        produto.setCategoriaNome(rs.getString("categoria_nome"));
        return produto;
    }
}
