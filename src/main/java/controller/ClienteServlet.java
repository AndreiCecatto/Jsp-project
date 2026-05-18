package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Cliente;
import model.Usuario;
import service.ClienteService;
import service.UsuarioService;


import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

@WebServlet("/cliente")
public class ClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nome = req.getParameter("nome");
        String dataStr = req.getParameter("datanascimento");
        String telefone = req.getParameter("telefone");
        String estado = req.getParameter("estado");
        String cidade = req.getParameter("cidade");
        String email = req.getParameter("email");

        try {
                LocalDate dataNascimento = LocalDate.parse(dataStr);
                Cliente cliente = new Cliente(nome, dataNascimento, telefone, estado, cidade, email);

                boolean returno = new ClienteService().inserir(cliente);
                if (returno) {
                    doGet(req, resp);
                }else{
                    req.setAttribute("erro","PROBLEMAS AO SALVAR O CLIENTE");
                }
            }
        catch (SQLException e){
                req.setAttribute("erro","ALGO ACONTECEU, ENTRE EM CONTATO COM O SUPORTE");
        }

        RequestDispatcher rd
                = req.getRequestDispatcher("WEB-INF/pages/cliente.jsp");
        rd.forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/cliente.jsp");

        try{
            ArrayList<Cliente> listaClientes = new ClienteService().getClientes();
            req.setAttribute("listaClientes",listaClientes);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro","ALGO ACONTECEU, ENTRE EM CONTATO COM O SUPORTE");
        }

        rd.forward(req, resp);
    }
}
