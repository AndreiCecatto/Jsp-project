package dao;

import model.ResumoEstoque;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// DAO com consultas agregadas usadas pelo dashboard do StockHub.
public class DashboardDAO {

    public ResumoEstoque buscarResumo() throws SQLException {
        String sql = "SELECT " +
                "(SELECT COUNT(*) FROM produto) AS total_produtos, " +
                "(SELECT COUNT(*) FROM categoria) AS total_categorias, " +
                "(SELECT COUNT(*) FROM produto WHERE quantidade <= estoque_minimo) AS estoque_baixo, " +
                "(SELECT COALESCE(SUM(quantidade), 0) FROM produto) AS total_itens, " +
                "(SELECT COALESCE(SUM(preco * quantidade), 0) FROM produto) AS valor_total";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             Statement stmt = conexao.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            ResumoEstoque resumo = new ResumoEstoque();
            if (rs.next()) {
                resumo.setTotalProdutos(rs.getInt("total_produtos"));
                resumo.setTotalCategorias(rs.getInt("total_categorias"));
                resumo.setProdutosEstoqueBaixo(rs.getInt("estoque_baixo"));
                resumo.setQuantidadeTotalItens(rs.getInt("total_itens"));
                resumo.setValorTotalEstoque(rs.getBigDecimal("valor_total"));
            }
            return resumo;
        }
    }
}
