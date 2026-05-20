package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Produto;
import service.CategoriaService;
import service.ProdutoService;
import util.SessaoUtil;
import util.UploadUtil;

import java.io.IOException;
import java.math.BigDecimal;

// Controller do CRUD de produtos. Recebe requisicoes e delega regras ao service.
@MultipartConfig
@WebServlet("/produtos")
public class ProdutoServlet extends HttpServlet {

    private final ProdutoService produtoService = new ProdutoService();
    private final CategoriaService categoriaService = new CategoriaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessaoUtil.redirecionarSeNaoLogado(req, resp)) {
            return;
        }

        String acao = req.getParameter("acao");

        try {
            if ("novo".equals(acao)) {
                abrirFormulario(req, resp, new Produto());
                return;
            }
            if ("editar".equals(acao)) {
                Produto produto = produtoService.buscarPorId(Integer.parseInt(req.getParameter("id")));
                abrirFormulario(req, resp, produto);
                return;
            }
            if ("excluir".equals(acao)) {
                produtoService.excluir(Integer.parseInt(req.getParameter("id")));
                resp.sendRedirect(req.getContextPath() + "/produtos");
                return;
            }

            Integer categoriaId = null;
            if (req.getParameter("categoriaId") != null && !req.getParameter("categoriaId").isBlank()) {
                categoriaId = Integer.parseInt(req.getParameter("categoriaId"));
            }

            req.setAttribute("produtos", produtoService.listar(req.getParameter("busca"), categoriaId));
            req.setAttribute("categorias", categoriaService.listar(null));
            req.setAttribute("busca", req.getParameter("busca"));
            req.setAttribute("categoriaId", categoriaId);
            req.getRequestDispatcher("WEB-INF/pages/produtos.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Nao foi possivel processar os produtos.");
            req.getRequestDispatcher("WEB-INF/pages/produtos.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessaoUtil.redirecionarSeNaoLogado(req, resp)) {
            return;
        }

        req.setCharacterEncoding("UTF-8");

        try {
            Produto produto = montarProduto(req);
            String novaImagem = UploadUtil.salvarImagem(req, "imagem", "produtos");
            produto.setImagem(UploadUtil.manterImagemAtualSeNaoEnviarNova(novaImagem, req.getParameter("imagemAtual")));

            produtoService.salvar(produto);
            resp.sendRedirect(req.getContextPath() + "/produtos");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", e.getMessage());
            req.setAttribute("produto", montarProdutoSeguro(req));
            try {
                req.setAttribute("categorias", categoriaService.listar(null));
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            req.getRequestDispatcher("WEB-INF/pages/produto-form.jsp").forward(req, resp);
        }
    }

    private void abrirFormulario(HttpServletRequest req, HttpServletResponse resp, Produto produto) throws Exception {
        req.setAttribute("produto", produto);
        req.setAttribute("categorias", categoriaService.listar(null));
        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/produto-form.jsp");
        rd.forward(req, resp);
    }

    private Produto montarProduto(HttpServletRequest req) {
        Produto produto = new Produto();
        String id = req.getParameter("id");
        if (id != null && !id.isBlank()) {
            produto.setId(Integer.parseInt(id));
        }
        produto.setNome(req.getParameter("nome"));
        produto.setDescricao(req.getParameter("descricao"));
        produto.setPreco(new BigDecimal(req.getParameter("preco")));
        produto.setQuantidade(Integer.parseInt(req.getParameter("quantidade")));
        produto.setEstoqueMinimo(Integer.parseInt(req.getParameter("estoqueMinimo")));
        produto.setCategoriaId(Integer.parseInt(req.getParameter("categoriaId")));
        return produto;
    }

    private Produto montarProdutoSeguro(HttpServletRequest req) {
        try {
            return montarProduto(req);
        } catch (Exception e) {
            return new Produto();
        }
    }
}
