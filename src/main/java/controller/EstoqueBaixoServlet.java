package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.ProdutoService;
import util.SessaoUtil;

import java.io.IOException;

// Controller da tela que lista produtos com quantidade menor ou igual ao minimo.
@WebServlet("/estoque-baixo")
public class EstoqueBaixoServlet extends HttpServlet {

    private final ProdutoService produtoService = new ProdutoService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessaoUtil.redirecionarSeNaoLogado(req, resp)) {
            return;
        }

        try {
            req.setAttribute("produtos", produtoService.listarEstoqueBaixo());
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Nao foi possivel carregar os produtos com estoque baixo.");
        }

        req.getRequestDispatcher("WEB-INF/pages/estoque-baixo.jsp").forward(req, resp);
    }
}
