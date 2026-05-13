package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Usuario;
import service.UsuarioService;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

 @WebServlet("usuario")
public class UsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nome = req.getParameter("nome");
        String email = req.getParameter("email");
        String senha = req.getParameter("senha");

        System.out.println(nome +" - "+email+" - "+senha);
        Usuario u = new Usuario(nome, senha, email, true);


        try {
            boolean returno = new UsuarioService().inserir(u);
           if(returno){
               doGet(req, resp);
           }else{
               req.setAttribute("retorno","PROBLEMAS AO SALVAR O USUÁRIO");
           }
        } catch (SQLException e) {
            req.setAttribute("erro","ALGO ACONTECEU, ENTRE EM CONTATO COM O SUPORTE");
        }

        RequestDispatcher rd
                = req.getRequestDispatcher("WEB-INF/pages/usuarios.jsp");
            rd.forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/usuarios.jsp");
    
        try{
            ArrayList<Usuario> listaUsuarios =
                    new UsuarioService().getUsuarios();
            req.setAttribute("listausuarios",listaUsuarios);

        } catch (Exception e) {
            e.printStackTrace();
           req.setAttribute("erro","ALGO ACONTECEU, ENTRE EM CONTATO COM O SUPORTE");
        }

        rd.forward(req, resp);
    }
}
