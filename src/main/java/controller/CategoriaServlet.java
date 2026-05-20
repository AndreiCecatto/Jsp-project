package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Categoria;
import service.CategoriaService;
import util.SessaoUtil;
import util.UploadUtil;

import java.io.IOException;

// Controller do CRUD de categorias do estoque.
@MultipartConfig
@WebServlet("/categorias")
public class CategoriaServlet extends HttpServlet {

    private final CategoriaService categoriaService = new CategoriaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessaoUtil.redirecionarSeNaoLogado(req, resp)) {
            return;
        }

        String acao = req.getParameter("acao");

        try {
            if ("novo".equals(acao)) {
                abrirFormulario(req, resp, new Categoria());
                return;
            }
            if ("editar".equals(acao)) {
                Categoria categoria = categoriaService.buscarPorId(Integer.parseInt(req.getParameter("id")));
                abrirFormulario(req, resp, categoria);
                return;
            }
            if ("excluir".equals(acao)) {
                categoriaService.excluir(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/categorias");
                return;
            }

            req.setAttribute("categorias", categoriaService.listar(req.getParameter("busca")));
            req.setAttribute("busca", req.getParameter("busca"));
            req.getRequestDispatcher("WEB-INF/pages/categorias.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Nao foi possivel processar as categorias. Verifique se nao existem produtos vinculados antes de excluir.");
            try {
                req.setAttribute("categorias", categoriaService.listar(null));
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            req.getRequestDispatcher("WEB-INF/pages/categorias.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessaoUtil.redirecionarSeNaoLogado(req, resp)) {
            return;
        }

        req.setCharacterEncoding("UTF-8");

        try {
            Categoria categoria = montarCategoria(req);
            String novaImagem = UploadUtil.salvarImagem(req, "imagem", "categorias");
            categoria.setImagem(UploadUtil.manterImagemAtualSeNaoEnviarNova(novaImagem, req.getParameter("imagemAtual")));

            categoriaService.salvar(categoria);
            resp.sendRedirect(req.getContextPath() + "/categorias");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", e.getMessage());
            req.setAttribute("categoria", montarCategoriaSeguro(req));
            req.getRequestDispatcher("WEB-INF/pages/categoria-form.jsp").forward(req, resp);
        }
    }

    private void abrirFormulario(HttpServletRequest req, HttpServletResponse resp, Categoria categoria) throws Exception {
        req.setAttribute("categoria", categoria);
        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/categoria-form.jsp");
        rd.forward(req, resp);
    }

    private Categoria montarCategoria(HttpServletRequest req) {
        Categoria categoria = new Categoria();
        String id = req.getParameter("id");
        if (id != null && !id.isBlank()) {
            categoria.setId(Integer.parseInt(id));
        }
        categoria.setNome(req.getParameter("nome"));
        categoria.setDescricao(req.getParameter("descricao"));
        return categoria;
    }

    private Categoria montarCategoriaSeguro(HttpServletRequest req) {
        try {
            return montarCategoria(req);
        } catch (Exception e) {
            return new Categoria();
        }
    }
}
