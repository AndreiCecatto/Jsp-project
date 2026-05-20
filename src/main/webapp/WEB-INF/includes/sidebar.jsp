<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Navegacao principal do StockHub. Cada link aponta para uma rota Servlet real. --%>
<aside class="app-sidebar">
    <div class="sidebar-brand">
        <span class="brand-logo"><i class="bi bi-box-seam"></i></span>
        <div>
            <strong>StockHub</strong>
            <small>Loja pequena</small>
        </div>
    </div>

    <div class="sidebar-label">Estoque</div>
    <a class="sidebar-link ${activePage == 'dashboard' ? 'active' : ''}" href="${pageContext.request.contextPath}/dashboard">
        <i class="bi bi-speedometer2"></i> Visão geral
    </a>
    <a class="sidebar-link ${activePage == 'produtos' ? 'active' : ''}" href="${pageContext.request.contextPath}/produtos">
        <i class="bi bi-grid-3x3-gap"></i> Produtos
    </a>
    <a class="sidebar-link ${activePage == 'categorias' ? 'active' : ''}" href="${pageContext.request.contextPath}/categorias">
        <i class="bi bi-tags"></i> Categorias
    </a>
    <a class="sidebar-link ${activePage == 'estoqueBaixo' ? 'active' : ''}" href="${pageContext.request.contextPath}/estoque-baixo">
        <i class="bi bi-exclamation-triangle"></i> Estoque baixo
    </a>

    <div class="sidebar-label">Cadastro</div>
    <a class="sidebar-link" href="${pageContext.request.contextPath}/produtos?acao=novo">
        <i class="bi bi-plus-square"></i> Produto
    </a>
    <a class="sidebar-link" href="${pageContext.request.contextPath}/categorias?acao=novo">
        <i class="bi bi-folder-plus"></i> Categoria
    </a>
</aside>
