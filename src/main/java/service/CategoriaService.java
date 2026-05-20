package service;

import dao.CategoriaDAO;
import model.Categoria;

import java.sql.SQLException;
import java.util.ArrayList;

// Service responsavel por validar categorias antes de chamar o DAO.
public class CategoriaService {

    private final CategoriaDAO categoriaDAO = new CategoriaDAO();

    public void salvar(Categoria categoria) throws Exception {
        validar(categoria);

        if (categoria.getId() > 0) {
            categoriaDAO.atualizar(categoria);
        } else {
            categoriaDAO.inserir(categoria);
        }
    }

    public void excluir(int id) throws SQLException {
        categoriaDAO.excluir(id);
    }

    public Categoria buscarPorId(int id) throws SQLException {
        return categoriaDAO.buscarPorId(id);
    }

    public ArrayList<Categoria> listar(String busca) throws SQLException {
        if (busca != null && !busca.isBlank()) {
            return categoriaDAO.buscarPorNome(busca);
        }
        return categoriaDAO.listar();
    }

    private void validar(Categoria categoria) throws Exception {
        if (categoria.getNome() == null || categoria.getNome().trim().isEmpty()) {
            throw new Exception("O nome da categoria e obrigatorio.");
        }
    }
}
