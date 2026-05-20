package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Usuario;
import service.LoginService;

import java.io.IOException;

/*
 * Controller de login.
 * Autentica com o LoginService e guarda o usuario em sessao para proteger o StockHub.
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final LoginService loginService = new LoginService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String senha = req.getParameter("senha");

        Usuario usuarioAutenticado = loginService.autenticar(email, senha);

        if (usuarioAutenticado != null) {
            HttpSession session = req.getSession();
            session.setAttribute("usuarioLogado", usuarioAutenticado);
            resp.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
        req.setAttribute("erro", "USUARIO OU SENHA INCORRETOS");
        rd.forward(req, resp);
    }
}
