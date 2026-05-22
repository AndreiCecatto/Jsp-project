<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<c:set var="activePage" value="dashboard" />

<%-- Dashboard do StockHub. Todos os numeros exibidos sao calculados a partir do PostgreSQL. --%>
<!DOCTYPE html>
<html lang="pt-BR"> 
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>StockHub - Visão geral</title>
</head>
<body>
<div class="app-shell">
    <jsp:include page="../includes/sidebar.jsp" />
    <div class="app-content">
        <jsp:include page="../includes/navbar.jsp" />

        <main class="page-wrap">
            <section class="page-header">
                <div class="page-title">
                    <h1>Visão geral</h1>
                    <p>Estoque, alertas e cadastros recentes.</p>
                </div>
                <div class="d-flex gap-2 flex-wrap">
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/produtos?acao=novo">
                        <i class="bi bi-plus-square"></i> Novo produto
                    </a>
                    <a class="btn btn-soft" href="${pageContext.request.contextPath}/categorias?acao=novo">
                        <i class="bi bi-folder-plus"></i> Nova categoria
                    </a>
                </div>
            </section>

            <c:if test="${not empty erro}">
                <div class="alert alert-danger">${erro}</div>
            </c:if>

            <section class="metric-grid">
                <article class="metric-card accent-blue">
                    <header><span>Produtos</span><i class="bi bi-box"></i></header>
                    <strong>${resumo.totalProdutos}</strong>
                    <small>itens cadastrados</small>
                </article>
                <article class="metric-card accent-purple">
                    <header><span>Categorias</span><i class="bi bi-tags"></i></header>
                    <strong>${resumo.totalCategorias}</strong>
                    <small>grupos ativos</small>
                </article>
                <article class="metric-card accent-red">
                    <header><span>Estoque baixo</span><i class="bi bi-exclamation-triangle"></i></header>
                    <strong>${resumo.produtosEstoqueBaixo}</strong>
                    <small>produtos em alerta</small>
                </article>
                <article class="metric-card accent-green">
                    <header><span>Unidades</span><i class="bi bi-stack"></i></header>
                    <strong>${resumo.quantidadeTotalItens}</strong>
                    <small>quantidade total</small>
                </article>
                <article class="metric-card accent-amber">
                    <header><span>Valor</span><i class="bi bi-cash-coin"></i></header>
                    <strong>R$ ${resumo.valorTotalEstoque}</strong>
                    <small>preço x quantidade</small>
                </article>
            </section>

            <section class="dashboard-layout">
                <div>
                    <section class="workspace-panel">
                        <div class="panel-heading">
                            <h2><i class="bi bi-clock-history"></i> Produtos recentes</h2>
                            <a class="btn btn-soft btn-sm" href="${pageContext.request.contextPath}/produtos">Abrir catálogo</a>
                        </div>
                        <div class="panel-body">
                            <div class="inventory-list">
                                <c:forEach var="produto" items="${produtosRecentes}">
                                    <article class="inventory-row">
                                        <span class="thumb-placeholder"><i class="bi bi-box-seam"></i></span>
                                        <div>
                                            <span class="row-title">${produto.nome}</span>
                                            <span class="row-subtitle">${produto.categoriaNome}</span>
                                        </div>
                                        <div class="row-meta">
                                            <span class="chip">R$ ${produto.preco}</span>
                                            <span class="chip ${produto.estoqueBaixo ? 'chip-alert' : 'chip-ok'}">${produto.quantidade} un.</span>
                                        </div>
                                    </article>
                                </c:forEach>
                            </div>
                            <c:if test="${empty produtosRecentes}">
                                <div class="empty-state">Nenhum produto cadastrado.</div>
                            </c:if>
                        </div>
                    </section>
                </div>

                <div>
                    <section class="workspace-panel">
                        <div class="panel-heading">
                            <h2><i class="bi bi-lightning-charge"></i> Ações rápidas</h2>
                        </div>
                        <div class="panel-body">
                            <div class="quick-actions">
                                <a class="quick-action" href="${pageContext.request.contextPath}/produtos?acao=novo">
                                    <i class="bi bi-plus-square"></i>
                                    <span><strong>Produto</strong><small>Cadastrar item</small></span>
                                </a>
                                <a class="quick-action" href="${pageContext.request.contextPath}/categorias?acao=novo">
                                    <i class="bi bi-folder-plus"></i>
                                    <span><strong>Categoria</strong><small>Criar grupo</small></span>
                                </a>
                            </div>
                        </div>
                    </section>

                    <section class="workspace-panel">
                        <div class="panel-heading">
                            <h2><i class="bi bi-exclamation-circle"></i> Estoque baixo</h2>
                            <a class="btn btn-soft btn-sm" href="${pageContext.request.contextPath}/estoque-baixo">Ver lista</a>
                        </div>
                        <div class="panel-body">
                            <div class="inventory-list">
                                <c:forEach var="produto" items="${produtosEstoqueBaixo}">
                                    <article class="inventory-row">
                                        <span class="thumb-placeholder"><i class="bi bi-exclamation-triangle"></i></span>
                                        <div>
                                            <span class="row-title">${produto.nome}</span>
                                            <span class="row-subtitle">${produto.categoriaNome}</span>
                                        </div>
                                        <div class="row-meta">
                                            <span class="chip chip-alert">${produto.quantidade}/${produto.estoqueMinimo}</span>
                                        </div>
                                    </article>
                                </c:forEach>
                            </div>
                            <c:if test="${empty produtosEstoqueBaixo}">
                                <div class="empty-state">Nenhum alerta de estoque.</div>
                            </c:if>
                        </div>
                    </section>
                </div>
            </section>
        </main>
    </div>
</div>
</body>
</html>
