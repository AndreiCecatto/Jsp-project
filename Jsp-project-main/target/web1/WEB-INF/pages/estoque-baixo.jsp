<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<c:set var="activePage" value="estoqueBaixo" />

<%-- Tela de alerta de estoque. A regra vem da consulta quantidade <= estoque_minimo. --%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>StockHub - Estoque baixo</title>
</head>
<body>
<div class="app-shell">
    <jsp:include page="../includes/sidebar.jsp" />
    <div class="app-content">
        <jsp:include page="../includes/navbar.jsp" />

        <main class="page-wrap">
            <section class="page-header">
                <div class="page-title">
                    <h1>Estoque baixo</h1>
                    <p>Itens com quantidade menor ou igual ao mínimo.</p>
                </div>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/produtos?acao=novo">
                    <i class="bi bi-plus-square"></i> Novo produto
                </a>
            </section>

            <c:if test="${not empty erro}">
                <div class="alert alert-danger">${erro}</div>
            </c:if>

            <section class="workspace-panel">
                <div class="panel-heading">
                    <h2><i class="bi bi-exclamation-triangle"></i> Alertas</h2>
                    <a class="btn btn-soft btn-sm" href="${pageContext.request.contextPath}/produtos">Abrir catálogo</a>
                </div>
                <div class="table-responsive">
                    <table class="table table-dark-custom align-middle">
                        <thead>
                        <tr>
                            <th>Produto</th>
                            <th>Categoria</th>
                            <th>Preço</th>
                            <th>Quantidade</th>
                            <th>Mínimo</th>
                            <th>Ações</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="produto" items="${produtos}">
                            <tr>
                                <td>
                                    <strong>${produto.nome}</strong>
                                    <span class="row-subtitle">${produto.descricao}</span>
                                </td>
                                <td>${produto.categoriaNome}</td>
                                <td>R$ ${produto.preco}</td>
                                <td><span class="chip chip-alert">${produto.quantidade} un.</span></td>
                                <td>${produto.estoqueMinimo}</td>
                                <td>
                                    <a class="btn btn-soft btn-sm" href="${pageContext.request.contextPath}/produtos?acao=editar&id=${produto.id}">
                                        <i class="bi bi-pencil"></i> Editar
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty produtos}">
                            <tr>
                                <td colspan="6">
                                    <div class="empty-state">Nenhum produto com estoque baixo.</div>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
    </div>
</div>
</body>
</html>
