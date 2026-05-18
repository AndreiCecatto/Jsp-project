package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Tarefa;
import model.Usuario;
import service.TarefaService;
import util.SessaoUtil;

import java.io.IOException;
import java.time.LocalDate;

/*
 * Controller das tarefas.
 * Recebe as rotas /tarefas, decide a acao e delega regra de negocio para TarefaService.
 */
@WebServlet("/tarefas")
public class TarefaServlet extends HttpServlet {

    private final TarefaService tarefaService = new TarefaService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessaoUtil.redirecionarSeNaoLogado(req, resp)) {
            return;
        }

        req.setCharacterEncoding("UTF-8");
        String acao = req.getParameter("acao");

        if ("novo".equals(acao)) {
            abrirFormulario(req, resp, null);
            return;
        }

        if ("editar".equals(acao)) {
            carregarParaEdicao(req, resp);
            return;
        }

        if ("excluir".equals(acao)) {
            excluir(req, resp);
            return;
        }

        listar(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (SessaoUtil.redirecionarSeNaoLogado(req, resp)) {
            return;
        }

        req.setCharacterEncoding("UTF-8");
        Usuario usuario = SessaoUtil.getUsuarioLogado(req);

        try {
            Tarefa tarefa = montarTarefaDaRequisicao(req, usuario.getCodigo());
            tarefaService.salvar(tarefa);
            resp.sendRedirect(req.getContextPath() + "/tarefas");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", e.getMessage());
            abrirFormulario(req, resp, montarTarefaDaRequisicaoSemDataObrigatoria(req, usuario.getCodigo()));
        }
    }

    private void listar(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Usuario usuario = SessaoUtil.getUsuarioLogado(req);
        String status = req.getParameter("status");
        String prioridade = req.getParameter("prioridade");

        try {
            req.setAttribute("tarefas", tarefaService.listar(usuario.getCodigo(), status, prioridade));
            req.setAttribute("statusFiltro", status);
            req.setAttribute("prioridadeFiltro", prioridade);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("erro", "Nao foi possivel listar as tarefas.");
        }

        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/tarefas.jsp");
        rd.forward(req, resp);
    }

    private void abrirFormulario(HttpServletRequest req, HttpServletResponse resp, Tarefa tarefa) throws ServletException, IOException {
        if (tarefa != null) {
            req.setAttribute("tarefa", tarefa);
        }

        RequestDispatcher rd = req.getRequestDispatcher("WEB-INF/pages/tarefa-form.jsp");
        rd.forward(req, resp);
    }

    private void carregarParaEdicao(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Usuario usuario = SessaoUtil.getUsuarioLogado(req);

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Tarefa tarefa = tarefaService.buscarPorId(id, usuario.getCodigo());

            if (tarefa == null) {
                resp.sendRedirect(req.getContextPath() + "/tarefas");
                return;
            }

            abrirFormulario(req, resp, tarefa);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/tarefas");
        }
    }

    private void excluir(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Usuario usuario = SessaoUtil.getUsuarioLogado(req);

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            tarefaService.excluir(id, usuario.getCodigo());
        } catch (Exception e) {
            e.printStackTrace();
        }

        resp.sendRedirect(req.getContextPath() + "/tarefas");
    }

    private Tarefa montarTarefaDaRequisicao(HttpServletRequest req, int usuarioId) {
        Tarefa tarefa = montarTarefaDaRequisicaoSemDataObrigatoria(req, usuarioId);
        tarefa.setDataPrazo(LocalDate.parse(req.getParameter("dataPrazo")));
        return tarefa;
    }

    private Tarefa montarTarefaDaRequisicaoSemDataObrigatoria(HttpServletRequest req, int usuarioId) {
        Tarefa tarefa = new Tarefa();

        String id = req.getParameter("id");
        if (id != null && !id.isBlank()) {
            tarefa.setId(Integer.parseInt(id));
        }

        tarefa.setTitulo(req.getParameter("titulo"));
        tarefa.setDescricao(req.getParameter("descricao"));
        tarefa.setPrioridade(req.getParameter("prioridade"));
        tarefa.setStatus(req.getParameter("status"));
        tarefa.setUsuarioId(usuarioId);

        String dataPrazo = req.getParameter("dataPrazo");
        if (dataPrazo != null && !dataPrazo.isBlank()) {
            try {
                tarefa.setDataPrazo(LocalDate.parse(dataPrazo));
            } catch (Exception ignored) {
                tarefa.setDataPrazo(null);
            }
        }

        return tarefa;
    }
}
