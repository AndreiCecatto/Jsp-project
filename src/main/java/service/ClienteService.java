package service;

import dao.ClienteDAO;
import dao.UsuarioDAO;
import model.Cliente;

import java.sql.SQLException;
import java.util.ArrayList;

public class ClienteService {

    public ArrayList<Cliente> getClientes()throws SQLException {
        return new ClienteDAO().getClientes();
    }

    public boolean inserir(Cliente c) throws SQLException {
        return new ClienteDAO().inserir(c);
    }
}
