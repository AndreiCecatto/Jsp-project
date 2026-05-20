package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Usuario;
import service.DashboardService;
import service.ProdutoService;
import util.SessaoUtil;

import java.io.IOException;

/*
 * Controller do dashboard.
 * Protege a tela com sessao, busca dados no service e encaminha para a JSP.
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final DashboardService dashboardService = new DashboardService();
    private final ProdutoService produtoService = new ProdutoService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessaoUtil.redirecionarSeNaoLogado(req, resp)) {
            return;
        }

        Usuario usuario = SessaoUtil.getUsuarioLogado(req);

        try {
            req.setAttribute("usuario", usuario);
            req.setAttribute("resumo", dashboardService.buscarResumo());
            req.setAttribute("produtosRecentes", produtoService.listarRecentes());
            req.setAttribute("produtosEstoqueBaixo", produtoService.listarEstoqueBaixo());
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Nao foi possivel carregar o dashboard.");
        }

        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/dashboard.jsp");
        rd.forward(req, resp);
    }
}
