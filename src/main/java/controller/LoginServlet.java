package controller;



import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Usuario;
import service.LoginService;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("login")
public class LoginServlet extends HttpServlet {

    private LoginService loginService = new LoginService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Chamou o GET");

        PrintWriter out	=	resp.getWriter();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Chamou o Post");

        String email = req.getParameter("email");
        String senha = req.getParameter("senha");

        System.out.println("Email: "+email);
        System.out.println("Senha: "+senha);

        Usuario usuarioAutenticado = loginService.autenticar(email, senha);

        if(usuarioAutenticado != null){
            RequestDispatcher rd =
                    req.getRequestDispatcher("WEB-INF/pages/dashbord.jsp");
            req.setAttribute("usuario",usuarioAutenticado);

            rd.forward(req, resp);
        }else{
            RequestDispatcher rd =
                    req.getRequestDispatcher("index.jsp");

            req.setAttribute("erro","USUÁRIO OU SENHA INCORRETOS");
            rd.forward(req, resp);
        }


    }
}
