<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<c:set var="activePage" value="categorias" />

<%-- Formulario de categoria. --%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>StockHub - Categoria</title>
</head>
<body>
<div class="app-shell">
    <jsp:include page="../includes/sidebar.jsp" />
    <div class="app-content">
        <jsp:include page="../includes/navbar.jsp" />

        <main class="page-wrap">
            <section class="page-header">
                <div class="page-title">
                    <h1>${categoria.id > 0 ? 'Editar categoria' : 'Cadastrar categoria'}</h1>
                    <p>Grupo usado para organizar produtos no catálogo.</p>
                </div>
                <a class="btn btn-soft" href="${pageContext.request.contextPath}/categorias">
                    <i class="bi bi-arrow-left"></i> Voltar
                </a>
            </section>

            <c:if test="${not empty erro}">
                <div class="alert alert-danger">${erro}</div>
            </c:if>

            <form class="record-form" method="post" action="${pageContext.request.contextPath}/categorias">
                <input type="hidden" name="id" value="${categoria.id}">

                <div class="form-layout">
                    <section class="form-panel">
                        <div class="form-section">
                            <div class="section-title"><i class="bi bi-tag"></i> Dados da categoria</div>
                            <div class="field-grid">
                                <div class="field-wide">
                                    <label class="form-label" for="nome">Nome da categoria</label>
                                    <input id="nome" class="form-control" type="text" name="nome" value="${categoria.nome}" placeholder="Ex: Eletrônicos" required>
                                </div>
                                <div class="field-wide">
                                    <label class="form-label" for="descricao">Descrição</label>
                                    <textarea id="descricao" class="form-control" name="descricao" rows="6" placeholder="Resumo do tipo de produto desta categoria">${categoria.descricao}</textarea>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>

                <div class="form-actions">
                    <a class="btn btn-soft" href="${pageContext.request.contextPath}/categorias">Cancelar</a>
                    <button class="btn btn-primary" type="submit">
                        <i class="bi bi-check2-circle"></i> Salvar categoria
                    </button>
                </div>
            </form>
        </main>
    </div>
</div>
</body>
</html>
