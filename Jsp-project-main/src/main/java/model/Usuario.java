package model;

// Model que representa o usuario do sistema usado no login e na sessao.
public class Usuario {

    private int codigo;
    private String nome;
    private String senha;
    private String email;
    private boolean ativo;

    public Usuario(){

    }

    public Usuario(String nome, String senha, String email, boolean ativo) {
        this.nome = nome;
        this.senha = senha;
        this.email = email;
        this.ativo = ativo;
    }

    public Usuario(int codigo, String nome, String senha, String email, boolean ativo) {
        this.codigo = codigo;
        this.nome = nome;
        this.senha = senha;
        this.email = email;
        this.ativo = ativo;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public int getId() {
        return codigo;
    }

    public void setId(int id) {
        this.codigo = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isAtivo() {
        return ativo;
    }

    public void setAtivo(boolean ativo) {
        this.ativo = ativo;
    }
}
