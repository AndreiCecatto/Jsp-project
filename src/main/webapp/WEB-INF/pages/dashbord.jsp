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
    <title>TaskFlow - Dashboard</title>
</head>
<body>
<c:set var="activePage" value="dashboard" scope="request" />
<c:set var="workflowClass" value="passed" />
<c:set var="workflowIcon" value="bi-check-circle-fill" />
<c:set var="workflowText" value="Passing" />
<c:if test="${resumo.pendentes > 0}">
    <c:set var="workflowClass" value="running" />
    <c:set var="workflowIcon" value="bi-dot" />
    <c:set var="workflowText" value="In progress" />
</c:if>
<c:if test="${resumo.atrasadas > 0}">
    <c:set var="workflowClass" value="failed" />
    <c:set var="workflowIcon" value="bi-x-circle-fill" />
    <c:set var="workflowText" value="Failed" />
</c:if>
<c:set var="pendentesWidth" value="0" />
<c:set var="concluidasWidth" value="0" />
<c:set var="atrasadasWidth" value="0" />
<c:if test="${resumo.total > 0}">
    <c:set var="pendentesWidth" value="${resumo.pendentes * 100 / resumo.total}" />
    <c:set var="concluidasWidth" value="${resumo.concluidas * 100 / resumo.total}" />
    <c:set var="atrasadasWidth" value="${resumo.atrasadas * 100 / resumo.total}" />
</c:if>

<div class="layout-wrapper">
    <%@ include file="/WEB-INF/includes/navbar.jsp" %>

    <div class="app-shell">
        <%@ include file="/WEB-INF/includes/sidebar.jsp" %>

        <main class="app-main">
            <section class="dashboard-hero">
                <div>
                    <span class="page-kicker"><i class="bi bi-git"></i> andre/taskflow</span>
                    <h1>Actions</h1>
                    <p>Veja o progresso das tarefas como se fossem builds: pendencias, conclusoes e alertas em um unico fluxo.</p>
                </div>

                <div class="hero-actions">
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/tarefas?acao=novo">
                        <i class="bi bi-plus-lg me-1"></i>New issue
                    </a>
                    <a class="btn btn-ghost" href="${pageContext.request.contextPath}/tarefas">
                        <i class="bi bi-record-circle me-1"></i>Issues
                    </a>
                </div>
            </section>

            <c:if test="${not empty erro}">
                <div class="alert alert-danger">${erro}</div>
            </c:if>

            <section class="summary-grid">
                <article class="summary-card">
                    <div class="summary-icon total"><i class="bi bi-stack"></i></div>
                    <span>Total checks</span>
                    <strong>${resumo.total}</strong>
                </article>

                <article class="summary-card">
                    <div class="summary-icon pending"><i class="bi bi-hourglass-split"></i></div>
                    <span>Queued</span>
                    <strong>${resumo.pendentes}</strong>
                </article>

                <article class="summary-card">
                    <div class="summary-icon done"><i class="bi bi-check2-circle"></i></div>
                    <span>Passed</span>
                    <strong>${resumo.concluidas}</strong>
                </article>

                <article class="summary-card">
                    <div class="summary-icon late"><i class="bi bi-exclamation-triangle"></i></div>
                    <span>Failed</span>
                    <strong>${resumo.atrasadas}</strong>
                </article>
            </section>

            <section class="content-panel workflow-panel">
                <div class="panel-header">
                    <div>
                        <h2><i class="bi bi-play-circle"></i> taskflow/build</h2>
                        <p>Resumo do workflow atual baseado no status das suas tarefas.</p>
                    </div>
                    <span class="workflow-status ${workflowClass}">
                        <i class="bi ${workflowIcon}"></i>
                        ${workflowText}
                    </span>
                </div>

                <div class="build-steps">
                    <c:set var="completedStepClass" value="neutral" />
                    <c:if test="${resumo.concluidas > 0}">
                        <c:set var="completedStepClass" value="passed" />
                    </c:if>

                    <c:set var="queueStepClass" value="passed" />
                    <c:if test="${resumo.pendentes > 0}">
                        <c:set var="queueStepClass" value="running" />
                    </c:if>

                    <c:set var="deadlineStepClass" value="passed" />
                    <c:if test="${resumo.atrasadas > 0}">
                        <c:set var="deadlineStepClass" value="failed" />
                    </c:if>

                    <div class="build-step ${completedStepClass}">
                        <span class="build-step-icon"><i class="bi bi-check2"></i></span>
                        <div>
                            <strong>Build completed</strong>
                            <small>${resumo.concluidas} tarefa(s) concluidas sem bloqueios.</small>
                        </div>
                    </div>
                    <div class="build-step ${queueStepClass}">
                        <span class="build-step-icon"><i class="bi bi-arrow-repeat"></i></span>
                        <div>
                            <strong>Queue running</strong>
                            <small>${resumo.pendentes} tarefa(s) aguardando execucao.</small>
                        </div>
                    </div>
                    <div class="build-step ${deadlineStepClass}">
                        <span class="build-step-icon"><i class="bi bi-shield-check"></i></span>
                        <div>
                            <strong>Deadline checks</strong>
                            <small>${resumo.atrasadas} tarefa(s) com prazo estourado.</small>
                        </div>
                    </div>
                </div>
            </section>

            <section class="dashboard-grid">
                <div class="content-panel">
                    <div class="panel-header">
                        <div>
                            <h2>Recent issues</h2>
                            <p>Ultimas tarefas cadastradas no repositorio.</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/tarefas">Ver todas</a>
                    </div>

                    <div class="table-responsive">
                        <table class="table task-table align-middle mb-0">
                            <thead>
                            <tr>
                                <th>Titulo</th>
                                <th>Prioridade</th>
                                <th>Status</th>
                                <th>Prazo</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="tarefa" items="${tarefasRecentes}">
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
                                </tr>
                            </c:forEach>

                            <c:if test="${empty tarefasRecentes}">
                                <tr>
                                    <td colspan="4" class="empty-state">Nenhuma tarefa cadastrada ainda.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <aside class="content-panel insight-panel">
                    <div class="panel-header">
                        <div>
                            <h2>Build progress</h2>
                            <p>Distribuicao atual das tarefas.</p>
                        </div>
                    </div>

                    <div class="progress-list">
                        <div class="progress-item">
                            <div>
                                <span>Queued</span>
                                <strong>${resumo.pendentes}</strong>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-warning" style="width: ${pendentesWidth}%"></div>
                            </div>
                        </div>

                        <div class="progress-item">
                            <div>
                                <span>Passed</span>
                                <strong>${resumo.concluidas}</strong>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-success" style="width: ${concluidasWidth}%"></div>
                            </div>
                        </div>

                        <div class="progress-item">
                            <div>
                                <span>Failed</span>
                                <strong>${resumo.atrasadas}</strong>
                            </div>
                            <div class="progress">
                                <div class="progress-bar bg-danger" style="width: ${atrasadasWidth}%"></div>
                            </div>
                        </div>
                    </div>

                    <div class="mini-callout">
                        <i class="bi bi-lightning-charge"></i>
                        <div>
                            <strong>Pipeline hint</strong>
                            <span>Priorize checks vermelhos antes de iniciar novas tarefas.</span>
                        </div>
                    </div>
                </aside>
            </section>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
