package dao;

import model.ResumoTarefas;
import model.Tarefa;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/*
 * DAO e a unica camada que conversa diretamente com PostgreSQL.
 * Controllers e Services nao montam SQL: eles chamam metodos claros daqui.
 */
public class TarefaDAO {

    public boolean inserir(Tarefa tarefa) throws SQLException {
        String sql = "INSERT INTO tarefa(titulo, descricao, prioridade, status, data_prazo, usuario_id) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            preencherParametrosTarefa(stmt, tarefa);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean atualizar(Tarefa tarefa) throws SQLException {
        String sql = "UPDATE tarefa " +
                "SET titulo = ?, descricao = ?, prioridade = ?, status = ?, data_prazo = ? " +
                "WHERE id = ? AND usuario_id = ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setString(1, tarefa.getTitulo());
            stmt.setString(2, tarefa.getDescricao());
            stmt.setString(3, tarefa.getPrioridade());
            stmt.setString(4, tarefa.getStatus());
            stmt.setDate(5, Date.valueOf(tarefa.getDataPrazo()));
            stmt.setInt(6, tarefa.getId());
            stmt.setInt(7, tarefa.getUsuarioId());

            return stmt.executeUpdate() > 0;
        }
    }

    public boolean excluir(int id, int usuarioId) throws SQLException {
        String sql = "DELETE FROM tarefa WHERE id = ? AND usuario_id = ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.setInt(2, usuarioId);
            return stmt.executeUpdate() > 0;
        }
    }

    public Tarefa buscarPorId(int id, int usuarioId) throws SQLException {
        String sql = "SELECT id, titulo, descricao, prioridade, status, data_prazo, usuario_id " +
                "FROM tarefa WHERE id = ? AND usuario_id = ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.setInt(2, usuarioId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return montarTarefa(rs);
                }
            }
        }

        return null;
    }

    public ArrayList<Tarefa> listar(int usuarioId, String status, String prioridade) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT id, titulo, descricao, prioridade, status, data_prazo, usuario_id " +
                "FROM tarefa WHERE usuario_id = ?");

        if (status != null && !status.isBlank()) {
            sql.append(" AND status = ?");
        }

        if (prioridade != null && !prioridade.isBlank()) {
            sql.append(" AND prioridade = ?");
        }

        sql.append(" ORDER BY data_prazo ASC, id DESC");

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql.toString())) {

            int indice = 1;
            stmt.setInt(indice++, usuarioId);

            if (status != null && !status.isBlank()) {
                stmt.setString(indice++, status);
            }

            if (prioridade != null && !prioridade.isBlank()) {
                stmt.setString(indice, prioridade);
            }

            return executarLista(stmt);
        }
    }

    public ArrayList<Tarefa> listarRecentes(int usuarioId, int limite) throws SQLException {
        String sql = "SELECT id, titulo, descricao, prioridade, status, data_prazo, usuario_id " +
                "FROM tarefa WHERE usuario_id = ? ORDER BY id DESC LIMIT ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setInt(1, usuarioId);
            stmt.setInt(2, limite);

            return executarLista(stmt);
        }
    }

    public ResumoTarefas buscarResumo(int usuarioId) throws SQLException {
        String sql = "SELECT " +
                "COUNT(*) AS total, " +
                "COUNT(*) FILTER (WHERE status = 'Pendente') AS pendentes, " +
                "COUNT(*) FILTER (WHERE status = 'Concluida') AS concluidas, " +
                "COUNT(*) FILTER (WHERE data_prazo < CURRENT_DATE AND status <> 'Concluida') AS atrasadas " +
                "FROM tarefa WHERE usuario_id = ?";

        try (Connection conexao = ConectaDBPostgres.getConexao();
             PreparedStatement stmt = conexao.prepareStatement(sql)) {

            stmt.setInt(1, usuarioId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ResumoTarefas resumo = new ResumoTarefas();
                    resumo.setTotal(rs.getInt("total"));
                    resumo.setPendentes(rs.getInt("pendentes"));
                    resumo.setConcluidas(rs.getInt("concluidas"));
                    resumo.setAtrasadas(rs.getInt("atrasadas"));
                    return resumo;
                }
            }
        }

        return new ResumoTarefas();
    }

    private void preencherParametrosTarefa(PreparedStatement stmt, Tarefa tarefa) throws SQLException {
        stmt.setString(1, tarefa.getTitulo());
        stmt.setString(2, tarefa.getDescricao());
        stmt.setString(3, tarefa.getPrioridade());
        stmt.setString(4, tarefa.getStatus());
        stmt.setDate(5, Date.valueOf(tarefa.getDataPrazo()));
        stmt.setInt(6, tarefa.getUsuarioId());
    }

    private ArrayList<Tarefa> executarLista(PreparedStatement stmt) throws SQLException {
        ArrayList<Tarefa> tarefas = new ArrayList<>();

        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                tarefas.add(montarTarefa(rs));
            }
        }

        return tarefas;
    }

    private Tarefa montarTarefa(ResultSet rs) throws SQLException {
        Tarefa tarefa = new Tarefa();
        tarefa.setId(rs.getInt("id"));
        tarefa.setTitulo(rs.getString("titulo"));
        tarefa.setDescricao(rs.getString("descricao"));
        tarefa.setPrioridade(rs.getString("prioridade"));
        tarefa.setStatus(rs.getString("status"));
        tarefa.setDataPrazo(rs.getDate("data_prazo").toLocalDate());
        tarefa.setUsuarioId(rs.getInt("usuario_id"));
        return tarefa;
    }
}
