package service;


import dao.UsuarioDAO;
import model.Usuario;

import java.sql.SQLException;
import java.util.ArrayList;


public class UsuarioService {

    public ArrayList<Usuario> getUsuarios() throws SQLException {
        return new UsuarioDAO().getUsuarios();
    }

    public boolean inserir(Usuario u) throws SQLException {
        return new UsuarioDAO().inserir(u);
    }
}
