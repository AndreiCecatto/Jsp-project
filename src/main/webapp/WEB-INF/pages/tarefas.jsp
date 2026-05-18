<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>

<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <title>TaskFlow - Tarefas</title>
</head>
<body>
<c:set var="activePage" value="tarefas" scope="request" />

<div class="layout-wrapper">
    <%@ include file="/WEB-INF/includes/navbar.jsp" %>

    <div class="app-shell">
        <%@ include file="/WEB-INF/includes/sidebar.jsp" %>

        <main class="app-main">
            <section class="page-heading">
                <div>
                    <span class="page-kicker">Central de tarefas</span>
                    <h1>Tarefas</h1>
                    <p>Gerencie sua lista, acompanhe prioridades e mantenha os prazos organizados.</p>
                </div>

                <a class="btn btn-primary" href="${pageContext.request.contextPath}/tarefas?acao=novo">
                    <i class="bi bi-plus-lg me-1"></i>Nova tarefa
                </a>
            </section>

            <c:if test="${not empty erro}">
                <div class="alert alert-danger">${erro}</div>
            </c:if>

            <section class="content-panel filter-panel">
                <form class="row g-3 align-items-end" action="${pageContext.request.contextPath}/tarefas" method="get">
                    <div class="col-md-4">
                        <label class="form-label">Status</label>
                        <select class="form-select" name="status">
                            <option value="">Todos</option>
                            <option value="Pendente" <c:if test="${statusFiltro == 'Pendente'}">selected</c:if>>Pendente</option>
                            <option value="Em andamento" <c:if test="${statusFiltro == 'Em andamento'}">selected</c:if>>Em andamento</option>
                            <option value="Concluida" <c:if test="${statusFiltro == 'Concluida'}">selected</c:if>>Concluida</option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Prioridade</label>
                        <select class="form-select" name="prioridade">
                            <option value="">Todas</option>
                            <option value="Alta" <c:if test="${prioridadeFiltro == 'Alta'}">selected</c:if>>Alta</option>
                            <option value="Media" <c:if test="${prioridadeFiltro == 'Media'}">selected</c:if>>Media</option>
                            <option value="Baixa" <c:if test="${prioridadeFiltro == 'Baixa'}">selected</c:if>>Baixa</option>
                        </select>
                    </div>

                    <div class="col-md-4 d-flex gap-2">
                        <button class="btn btn-primary flex-fill" type="submit">
                            <i class="bi bi-funnel me-1"></i>Filtrar
                        </button>
                        <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/tarefas">Limpar</a>
                    </div>
                </form>
            </section>

            <section class="content-panel">
                <div class="panel-header">
                    <div>
                        <h2>Lista de tarefas</h2>
                        <p>Use os filtros acima para encontrar o que precisa.</p>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table task-table align-middle mb-0">
                        <thead>
                        <tr>
                            <th>Titulo</th>
                            <th>Prioridade</th>
                            <th>Status</th>
                            <th>Prazo</th>
                            <th class="text-end">Acoes</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="tarefa" items="${tarefas}">
                            <c:set var="priorityClass" value="priority-Baixa" />
                            <c:if test="${tarefa.prioridade == 'Alta'}">
                                <c:set var="priorityClass" value="priority-Alta" />
                            </c:if>
                            <c:if test="${tarefa.prioridade == 'Media'}">
                                <c:set var="priorityClass" value="priority-Media" />
                            </c:if>
                            <tr>
                                <td>
                                    <strong>${tarefa.titulo}</strong>
                                    <span>${tarefa.descricao}</span>
                                </td>
                                <td><span class="badge ${priorityClass}">${tarefa.prioridade}</span></td>
                                <td><span class="badge status-badge">${tarefa.status}</span></td>
                                <td>${tarefa.dataPrazo}</td>
                                <td class="text-end">
                                    <a class="btn btn-sm btn-outline-light" href="${pageContext.request.contextPath}/tarefas?acao=editar&id=${tarefa.id}">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/tarefas?acao=excluir&id=${tarefa.id}"
                                       onclick="return confirm('Deseja excluir esta tarefa?')">
                                        <i class="bi bi-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty tarefas}">
                            <tr>
                                <td colspan="5" class="empty-state">Nenhuma tarefa encontrada para os filtros selecionados.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
