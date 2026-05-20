<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<c:set var="activePage" value="categorias" />

<%-- Listagem de categorias com contagem real de produtos vinculados. --%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>StockHub - Categorias</title>
</head>
<body>
<div class="app-shell">
    <jsp:include page="../includes/sidebar.jsp" />
    <div class="app-content">
        <jsp:include page="../includes/navbar.jsp" />

        <main class="page-wrap">
            <section class="page-header">
                <div class="page-title">
                    <h1>Categorias</h1>
                    <p>Grupos usados para organizar o estoque.</p>
                </div>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/categorias?acao=novo">
                    <i class="bi bi-folder-plus"></i> Nova categoria
                </a>
            </section>

            <form class="filter-bar compact" method="get" action="${pageContext.request.contextPath}/categorias">
                <input class="form-control" type="search" name="busca" value="${busca}" placeholder="Buscar por nome">
                <button class="btn btn-soft" type="submit"><i class="bi bi-search"></i> Buscar</button>
            </form>

            <c:if test="${not empty erro}">
                <div class="alert alert-danger">${erro}</div>
            </c:if>
            public
            <section class="catalog-grid">
                <c:forEach var="categoria" items="${categorias}">
                    <article class="category-card">
                        <c:choose>
                            <c:when test="${not empty categoria.imagem}">
                                <img class="category-media" src="${pageContext.request.contextPath}/${categoria.imagem}" alt="${categoria.nome}">
                            </c:when>
                            <c:otherwise>
                                <div class="image-placeholder"><i class="bi bi-tags"></i></div>
                            </c:otherwise>
                        </c:choose>

                        <div class="catalog-body">
                            <h3>${categoria.nome}</h3>
                            <p class="catalog-description">${categoria.descricao}</p>
                            <div class="catalog-meta">
                                <span class="chip"><i class="bi bi-boxes"></i> ${categoria.totalProdutos} produtos</span>
                            </div>
                            <div class="actions">
                                <a class="btn btn-soft btn-sm" href="${pageContext.request.contextPath}/categorias?acao=editar&id=${categoria.id}">
                                    <i class="bi bi-pencil"></i> Editar
                                </a>
                                <a class="btn btn-danger-soft btn-sm" href="${pageContext.request.contextPath}/categorias?acao=excluir&id=${categoria.id}" onclick="return confirm('Excluir esta categoria?')">
                                    <i class="bi bi-trash"></i> Excluir
                                </a>
                            </div>
                        </div>
                    </article>
                </c:forEach>
            </section>

            <c:if test="${empty categorias}">
                <div class="empty-state">Nenhuma categoria encontrada.</div>
            </c:if>
        </main>
    </div>
</div>
</body>
</html>
