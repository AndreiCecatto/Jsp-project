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
    <title>TaskFlow - Formulario de tarefa</title>
</head>
<body>
<c:set var="activePage" value="novaTarefa" scope="request" />
<c:set var="formTitle" value="Nova tarefa" />
<c:if test="${not empty tarefa.id && tarefa.id != 0}">
    <c:set var="formTitle" value="Editar tarefa" />
</c:if>

<div class="layout-wrapper">
    <%@ include file="/WEB-INF/includes/navbar.jsp" %>

    <div class="app-shell">
        <%@ include file="/WEB-INF/includes/sidebar.jsp" %>

        <main class="app-main">
            <section class="page-heading github-page-heading">
                <div>
                    <span class="page-kicker">Issues / Tasks</span>
                    <h1>${formTitle}</h1>
                    <p>Registre uma tarefa com titulo claro, prazo, prioridade e status atual.</p>
                </div>

                <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/tarefas">
                    <i class="bi bi-arrow-left me-1"></i>Voltar
                </a>
            </section>

            <div class="github-form-layout">
                <section class="content-panel github-form-card">
                    <div class="panel-header border-bottom pb-3">
                        <div>
                            <h2>Detalhes da tarefa</h2>
                            <p>Campos principais usados no dashboard e nos filtros.</p>
                        </div>
                    </div>

                    <c:if test="${not empty erro}">
                        <div class="alert alert-danger">${erro}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/tarefas" method="post">
                        <input type="hidden" name="id" value="${tarefa.id}">

                        <div class="github-field">
                            <label class="form-label" for="titulo">Titulo</label>
                            <input class="form-control" type="text" id="titulo" name="titulo"
                                   placeholder="Ex: Revisar backlog da semana"
                                   value="${tarefa.titulo}" required>
                            <small>Use um titulo curto e direto, como em uma issue.</small>
                        </div>

                        <div class="github-field">
                            <label class="form-label" for="descricao">Descricao</label>
                            <textarea class="form-control" id="descricao" name="descricao" rows="7"
                                      placeholder="Descreva o contexto, objetivo e observacoes importantes.">${tarefa.descricao}</textarea>
                        </div>

                        <div class="github-meta-grid">
                            <div class="github-field">
                                <label class="form-label" for="prioridade">Prioridade</label>
                                <select class="form-select" id="prioridade" name="prioridade" required>
                                    <option value="Alta" <c:if test="${tarefa.prioridade == 'Alta'}">selected</c:if>>Alta</option>
                                    <option value="Media" <c:if test="${empty tarefa.prioridade || tarefa.prioridade == 'Media'}">selected</c:if>>Media</option>
                                    <option value="Baixa" <c:if test="${tarefa.prioridade == 'Baixa'}">selected</c:if>>Baixa</option>
                                </select>
                            </div>

                            <div class="github-field">
                                <label class="form-label" for="status">Status</label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="Pendente" <c:if test="${empty tarefa.status || tarefa.status == 'Pendente'}">selected</c:if>>Pendente</option>
                                    <option value="Em andamento" <c:if test="${tarefa.status == 'Em andamento'}">selected</c:if>>Em andamento</option>
                                    <option value="Concluida" <c:if test="${tarefa.status == 'Concluida'}">selected</c:if>>Concluida</option>
                                </select>
                            </div>

                            <div class="github-field">
                                <label class="form-label" for="dataPrazo">Prazo</label>
                                <input class="form-control" type="date" id="dataPrazo" name="dataPrazo"
                                       value="${tarefa.dataPrazo}" required>
                            </div>
                        </div>

                        <div class="github-form-actions">
                            <a class="btn btn-outline-light" href="${pageContext.request.contextPath}/tarefas">Cancelar</a>
                            <button class="btn btn-primary" type="submit">
                                <i class="bi bi-check2 me-1"></i>Salvar tarefa
                            </button>
                        </div>
                    </form>
                </section>

                <aside class="content-panel github-help-card">
                    <h2>Como preencher</h2>
                    <div class="help-item">
                        <i class="bi bi-type"></i>
                        <div>
                            <strong>Titulo</strong>
                            <span>Deixe claro o resultado esperado.</span>
                        </div>
                    </div>
                    <div class="help-item">
                        <i class="bi bi-flag"></i>
                        <div>
                            <strong>Prioridade</strong>
                            <span>Use Alta apenas para tarefas urgentes.</span>
                        </div>
                    </div>
                    <div class="help-item">
                        <i class="bi bi-calendar3"></i>
                        <div>
                            <strong>Prazo</strong>
                            <span>Tarefas vencidas aparecem como atrasadas.</span>
                        </div>
                    </div>
                </aside>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
