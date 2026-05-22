package service;

import dao.ProdutoDAO;
import model.Produto;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;

// Service responsavel por validar produtos e aplicar regras simples de estoque.
public class ProdutoService {

    private final ProdutoDAO produtoDAO = new ProdutoDAO();

    public void salvar(Produto produto) throws Exception {
        validar(produto);

        if (produto.getId() > 0) {
            produtoDAO.atualizar(produto);
        } else {
            produtoDAO.inserir(produto);
        }
    }

    public void excluir(int id) throws SQLException {
        produtoDAO.excluir(id);
    }

    public Produto buscarPorId(int id) throws SQLException {
        return produtoDAO.buscarPorId(id);
    }

    public ArrayList<Produto> listar(String busca, Integer categoriaId) throws SQLException {
        return produtoDAO.listar(busca, categoriaId);
    }

    public ArrayList<Produto> listarRecentes() throws SQLException {
        return produtoDAO.listarRecentes(6);
    }

    public ArrayList<Produto> listarEstoqueBaixo() throws SQLException {
        return produtoDAO.listarEstoqueBaixo();
    }

    private void validar(Produto produto) throws Exception {
        if (produto.getNome() == null || produto.getNome().trim().isEmpty()) {
            throw new Exception("O nome do produto e obrigatorio.");
        }
        if (produto.getPreco() == null || produto.getPreco().compareTo(BigDecimal.ZERO) < 0) {
            throw new Exception("O preco deve ser maior ou igual a zero.");
        }
        if (produto.getQuantidade() < 0) {
            throw new Exception("A quantidade deve ser maior ou igual a zero.");
        }
        if (produto.getEstoqueMinimo() < 0) {
            throw new Exception("O estoque minimo deve ser maior ou igual a zero.");
        }
        if (produto.getCategoriaId() <= 0) {
            throw new Exception("Selecione uma categoria para o produto.");
        }
    }
}
