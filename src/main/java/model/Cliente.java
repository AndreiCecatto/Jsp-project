package model;

import java.time.LocalDate;

public class Cliente {

    private int codigo;
    private String nome;
    private LocalDate dataNascimento;
    private String telefone;
    private String estado;
    private String cidade;
    private String email;


    public Cliente(){

    }

    public Cliente(String nome,LocalDate dataNascimento,String telefone,String estado, String cidade, String email) {
        this.nome = nome;
        this.dataNascimento = dataNascimento;
        this.telefone = telefone;
        this.estado = estado;
        this.cidade = cidade;
        this.email = email;

    }

    public Cliente(int codigo,String nome,LocalDate dataNascimento,String telefone,String estado, String cidade, String email) {
        this.codigo = codigo;
        this.nome = nome;
        this.dataNascimento = dataNascimento;
        this.telefone = telefone;
        this.estado = estado;
        this.cidade = cidade;
        this.email = email;
    }



    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public LocalDate getDataNascimento() {
        return dataNascimento;
    }

    public void setDataNascimento(LocalDate dataNascimento) {
        this.dataNascimento = dataNascimento;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
