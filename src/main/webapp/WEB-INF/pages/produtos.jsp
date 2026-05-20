<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<c:set var="activePage" value="produtos" />

<%-- Catalogo de produtos. Busca e filtro chamam consultas reais no ProdutoDAO. --%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>StockHub - Produtos</title>
</head>
<body>
<div class="app-shell">
    <jsp:include page="../includes/sidebar.jsp" />
    <div class="app-content">
        <jsp:include page="../includes/navbar.jsp" />

        <main class="page-wrap">
            <section class="page-header">
                <div class="page-title">
                    <h1>Produtos</h1>
                    <p>Catálogo do estoque da loja.</p>
                </div>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/produtos?acao=novo">
                    <i class="bi bi-plus-square"></i> Novo produto
                </a>
            </section>

            <form class="filter-bar" method="get" action="${pageContext.request.contextPath}/produtos">
                <input class="form-control" type="search" name="busca" value="${busca}" placeholder="Buscar por nome">
                <select class="form-select" name="categoriaId">
                    <option value="">Todas as categorias</option>
                    <c:forEach var="categoria" items="${categorias}">
                        <option value="${categoria.id}" ${categoriaId == categoria.id ? 'selected' : ''}>${categoria.nome}</option>
                    </c:forEach>
                </select>
                <button class="btn btn-soft" type="submit"><i class="bi bi-search"></i> Buscar</button>
            </form>

            <c:if test="${not empty erro}">
                <div class="alert alert-danger">${erro}</div>
            </c:if>

            <section class="catalog-grid">
                <c:forEach var="produto" items="${produtos}">
                    <article class="product-card">
                        <c:choose>
                            <c:when test="${not empty produto.imagem}">
                                <img class="product-media" src="${pageContext.request.contextPath}/${produto.imagem}" alt="${produto.nome}">
                            </c:when>
                            <c:otherwise>
                                <div class="image-placeholder"><i class="bi bi-box-seam"></i></div>
                            </c:otherwise>
                        </c:choose>

                        <div class="catalog-body">
                            <h3>${produto.nome}</h3>
                            <span class="product-price">R$ ${produto.preco}</span>
                            <p class="catalog-description">${produto.descricao}</p>

                            <div class="catalog-meta">
                                <span class="chip"><i class="bi bi-tag"></i> ${produto.categoriaNome}</span>
                                <span class="chip ${produto.estoqueBaixo ? 'chip-alert' : 'chip-ok'}">
                                    <i class="bi bi-box"></i> ${produto.quantidade} un.
                                </span>
                            </div>

                            <div class="actions">
                                <a class="btn btn-soft btn-sm" href="${pageContext.request.contextPath}/produtos?acao=editar&id=${produto.id}">
                                    <i class="bi bi-pencil"></i> Editar
                                </a>
                                <a class="btn btn-danger-soft btn-sm" href="${pageContext.request.contextPath}/produtos?acao=excluir&id=${produto.id}" onclick="return confirm('Excluir este produto?')">
                                    <i class="bi bi-trash"></i> Excluir
                                </a>
                            </div>
                        </div>
                    </article>
                </c:forEach>
            </section>

            <c:if test="${empty produtos}">
                <div class="empty-state">Nenhum produto encontrado.</div>
            </c:if>
        </main>
    </div>
</div>
</body>
</html>
