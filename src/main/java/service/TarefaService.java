package service;

import dao.TarefaDAO;
import model.ResumoTarefas;
import model.Tarefa;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

/*
 * Service concentra regras de negocio.
 * O controller recebe parametros HTTP, o service valida regra, e o DAO grava no PostgreSQL.
 */
public class TarefaService {

    public static final String STATUS_PENDENTE = "Pendente";
    public static final String STATUS_ANDAMENTO = "Em andamento";
    public static final String STATUS_CONCLUIDA = "Concluida";

    public static final String PRIORIDADE_ALTA = "Alta";
    public static final String PRIORIDADE_MEDIA = "Media";
    public static final String PRIORIDADE_BAIXA = "Baixa";

    public ArrayList<Tarefa> listar(int usuarioId, String status, String prioridade) throws SQLException {
        return new TarefaDAO().listar(usuarioId, normalizarFiltro(status), normalizarFiltro(prioridade));
    }

    public ArrayList<Tarefa> listarRecentes(int usuarioId) throws SQLException {
        return new TarefaDAO().listarRecentes(usuarioId, 6);
    }

    public ResumoTarefas buscarResumo(int usuarioId) throws SQLException {
        return new TarefaDAO().buscarResumo(usuarioId);
    }

    public Tarefa buscarPorId(int id, int usuarioId) throws SQLException {
        return new TarefaDAO().buscarPorId(id, usuarioId);
    }

    public boolean salvar(Tarefa tarefa) throws SQLException {
        validar(tarefa);

        if (tarefa.getId() > 0) {
            return new TarefaDAO().atualizar(tarefa);
        }

        return new TarefaDAO().inserir(tarefa);
    }

    public boolean excluir(int id, int usuarioId) throws SQLException {
        return new TarefaDAO().excluir(id, usuarioId);
    }

    private void validar(Tarefa tarefa) {
        if (tarefa.getTitulo() == null || tarefa.getTitulo().isBlank()) {
            throw new IllegalArgumentException("Informe o titulo da tarefa.");
        }

        if (!prioridadeValida(tarefa.getPrioridade())) {
            throw new IllegalArgumentException("Prioridade invalida.");
        }

        if (!statusValido(tarefa.getStatus())) {
            throw new IllegalArgumentException("Status invalido.");
        }

        if (tarefa.getDataPrazo() == null) {
            throw new IllegalArgumentException("Informe a data de prazo.");
        }

        if (tarefa.getUsuarioId() <= 0) {
            throw new IllegalArgumentException("Usuario da tarefa nao identificado.");
        }
    }

    private boolean prioridadeValida(String prioridade) {
        return PRIORIDADE_ALTA.equals(prioridade)
                || PRIORIDADE_MEDIA.equals(prioridade)
                || PRIORIDADE_BAIXA.equals(prioridade);
    }

    private boolean statusValido(String status) {
        return STATUS_PENDENTE.equals(status)
                || STATUS_ANDAMENTO.equals(status)
                || STATUS_CONCLUIDA.equals(status);
    }

    private String normalizarFiltro(String valor) {
        if (valor == null || valor.isBlank()) {
            return null;
        }

        return valor;
    }
}
