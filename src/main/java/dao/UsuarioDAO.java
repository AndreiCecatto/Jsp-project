package dao;


import model.Usuario;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class UsuarioDAO {

    private static Connection conexao;
    private static Statement stmt;
    private static ResultSet rs;

    public UsuarioDAO() throws SQLException {
        conexao =  ConectaDBPostgres.getConexao();
        stmt = conexao.createStatement();
    }

    public Usuario autenticar(String email, String senha) throws SQLException{

            String sql = "SELECT * FROM USUARIO " + "WHERE email = '"+email+"' " + "AND senha = '"+senha+"'";
            System.out.println("sql - login: "+sql);
            rs =  stmt.executeQuery(sql);

            while (rs.next())
            {
                Usuario usuario = new Usuario();
                usuario.setCodigo(rs.getInt("codigo"));
                usuario.setNome(rs.getString("nome"));
                usuario.setEmail(rs.getString("email"));
                usuario.setAtivo(rs.getBoolean("ativo"));
                return usuario;
            }
        return null;
    }

    public boolean inserir(Usuario u) throws SQLException{

        //  Connection conexao = ConectaBDPostgres.getConexao();
        //  Statement stmt = conexao.createStatement();
        String sql = "INSERT INTO usuario(nome, email, senha, ativo) " +
                "VALUES('"+u.getNome()+"','"
                +u.getEmail()+"','"+u.getSenha()+"',"+u.isAtivo()+")";

        System.out.println("SQL --> "+sql);
        stmt.execute(sql);

        return  true;
    }

    public boolean excluir(Usuario u)throws SQLException{

        //  Connection conexao = ConectaBDPostgres.getConexao();
        //  Statement stmt = conexao.createStatement();
        String sql = "DELETE FROM usuario WHERE codigo="+u.getCodigo();
        stmt.execute(sql);

        return true;
    }

    public boolean atualizar(Usuario u) throws SQLException{

        String sql = "UPDATE usuario " +
                "SET nome='"+u.getNome()+"',"+
                " email='"+u.getEmail()+"'," +
                " senha='"+u.getSenha()+"'," +
                " ativo="+u.isAtivo()+" WHERE codigo="+u.getCodigo();

        stmt.execute(sql);

        return true;
    }

    public ArrayList<Usuario> getUsuariosPorNome(String nome) throws SQLException{
        ArrayList<Usuario> usuarios = new ArrayList<>();

        ResultSet rs = stmt.executeQuery(
                "Select * from usuario where nome LIKE '%"+nome+"%' ");
        while (rs.next()){
            Usuario usuario = new Usuario();
            usuario.setCodigo(rs.getInt("codigo"));
            usuario.setNome(rs.getString("nome"));
            usuario.setEmail(rs.getString("email"));
            usuario.setSenha(rs.getString("senha"));
            usuario.setAtivo(rs.getBoolean("ativo"));

            usuarios.add(usuario);
        }

        return usuarios;
    }

    public ArrayList<Usuario> getUsuarios()throws SQLException{

        ArrayList<Usuario> usuarios = new ArrayList<>();

        //  Connection conexao = ConectaBDPostgres.getConexao();
        //  Statement stmt = conexao.createStatement();
        ResultSet rs = stmt.executeQuery("Select * from usuario");
        while (rs.next()){
            Usuario usuario = new Usuario();
            usuario.setCodigo(rs.getInt("codigo"));
            usuario.setNome(rs.getString("nome"));
            usuario.setEmail(rs.getString("email"));
            usuario.setSenha(rs.getString("senha"));
            usuario.setAtivo(rs.getBoolean("ativo"));

            usuarios.add(usuario);
        }

        return usuarios;
    }

}

