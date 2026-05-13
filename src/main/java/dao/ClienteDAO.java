package dao;

import model.Cliente;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class ClienteDAO {

    private static Connection conexao;
    private static Statement stmt;
    private static ResultSet rs;

    public ClienteDAO() throws SQLException {
        conexao =  ConectaDBPostgres.getConexao();
        stmt = conexao.createStatement();
    }

    public boolean inserir(Cliente c) throws SQLException{

        //  Connection conexao = ConectaBDPostgres.getConexao();
        //  Statement stmt = conexao.createStatement();
        String sql = "INSERT INTO cliente(nome,dtanascimento, telefone ,estado,cidade,email ) " +
                "VALUES('"+c.getNome()+"','"
                +c.getDataNascimento()+"','"+c.getTelefone()+"','"+c.getEstado()+"','"+c.getCidade()+"','"+c.getEmail()+"')";

        System.out.println("SQL --> "+sql);
        stmt.execute(sql);

        return  true;
    }

    public boolean excluir(Cliente c)throws SQLException{

        //  Connection conexao = ConectaBDPostgres.getConexao();
        //  Statement stmt = conexao.createStatement();
        String sql = "DELETE FROM usuario WHERE codigo="+c.getCodigo();
        stmt.execute(sql);

        return true;
    }

    public boolean atualizar(Cliente c) throws SQLException{

        String sql = "UPDATE usuario " +
                "SET nome='"+c.getNome()+"',"+
                " dtanascimento='"+c.getDataNascimento()+"'," +
                " telefone='"+c.getTelefone()+"'," +
                " estado="+c.getEstado()+"',"+
                " cidade='"+c.getCidade()+"',"+
                " email='"+c.getEmail()+" WHERE codigo="+c.getCodigo();

        stmt.execute(sql);

        return true;
    }

    public ArrayList<Cliente> getClientesPorNome(String nome) throws SQLException{
        ArrayList<Cliente> clientes = new ArrayList<>();

        ResultSet rs = stmt.executeQuery(
                "Select * from cliente where nome LIKE '%"+nome+"%' ");
        while (rs.next()){
            Cliente cliente = new Cliente();
            cliente.setCodigo(rs.getInt("codigo"));
            cliente.setNome(rs.getString("nome"));
            cliente.setEmail(rs.getString("email"));


            clientes.add(cliente);
        }

        return clientes;
    }

    public ArrayList<Cliente> getClientes()throws SQLException{

        ArrayList<Cliente> clientes = new ArrayList<>();

        //  Connection conexao = ConectaBDPostgres.getConexao();
        //  Statement stmt = conexao.createStatement();
        ResultSet rs = stmt.executeQuery("Select * from cliente");
        while (rs.next())
        {
            Cliente cliente = new Cliente();
            cliente.setCodigo(rs.getInt("codigo"));
            cliente.setNome(rs.getString("nome"));
            cliente.setDataNascimento(rs.getDate("dtanascimento").toLocalDate());
            cliente.setTelefone(rs.getString("telefone"));
            cliente.setEstado(rs.getString("estado"));
            cliente.setCidade(rs.getString("cidade"));
            cliente.setEmail(rs.getString("email"));

            clientes.add(cliente);
        }

        return clientes;
    }
}