package model;

import java.time.LocalDate;

/*
 * Model representa uma linha da tabela tarefa.
 * Ele nao acessa banco, nao valida tela e nao controla requisicao.
 * Sua funcao no MVC e transportar dados entre Controller, Service, DAO e JSP.
 */
public class Tarefa {

    private int id;
    private String titulo;
    private String descricao;
    private String prioridade;
    private String status;
    private LocalDate dataPrazo;
    private int usuarioId;

    public Tarefa() {
    }

    public Tarefa(String titulo, String descricao, String prioridade, String status, LocalDate dataPrazo, int usuarioId) {
        this.titulo = titulo;
        this.descricao = descricao;
        this.prioridade = prioridade;
        this.status = status;
        this.dataPrazo = dataPrazo;
        this.usuarioId = usuarioId;
    }

    public Tarefa(int id, String titulo, String descricao, String prioridade, String status, LocalDate dataPrazo, int usuarioId) {
        this.id = id;
        this.titulo = titulo;
        this.descricao = descricao;
        this.prioridade = prioridade;
        this.status = status;
        this.dataPrazo = dataPrazo;
        this.usuarioId = usuarioId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getPrioridade() {
        return prioridade;
    }

    public void setPrioridade(String prioridade) {
        this.prioridade = prioridade;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getDataPrazo() {
        return dataPrazo;
    }

    public void setDataPrazo(LocalDate dataPrazo) {
        this.dataPrazo = dataPrazo;
    }

    public int getUsuarioId() {
        return usuarioId;
    }

    public void setUsuarioId(int usuarioId) {
        this.usuarioId = usuarioId;
    }
}
