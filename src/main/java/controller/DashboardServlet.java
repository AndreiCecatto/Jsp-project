package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Usuario;
import service.TarefaService;
import util.SessaoUtil;

import java.io.IOException;

/*
 * Controller do dashboard.
 * Protege a tela com sessao, busca dados no service e encaminha para a JSP.
 */
@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final TarefaService tarefaService = new TarefaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessaoUtil.redirecionarSeNaoLogado(req, resp)) {
            return;
        }

        Usuario usuario = SessaoUtil.getUsuarioLogado(req);

        try {
            req.setAttribute("usuario", usuario);
            req.setAttribute("resumo", tarefaService.buscarResumo(usuario.getCodigo()));
            req.setAttribute("tarefasRecentes", tarefaService.listarRecentes(usuario.getCodigo()));
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Nao foi possivel carregar o dashboard.");
        }

        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/dashbord.jsp");
        rd.forward(req, resp);
    }
}
