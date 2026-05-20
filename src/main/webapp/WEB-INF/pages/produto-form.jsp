<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<c:set var="activePage" value="produtos" />

<%-- Formulario de produto. Controller recebe multipart e o Service valida os campos. --%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>StockHub - Produto</title>
</head>
<body>
<div class="app-shell">
    <jsp:include page="../includes/sidebar.jsp" />
    <div class="app-content">
        <jsp:include page="../includes/navbar.jsp" />

        <main class="page-wrap">
            <section class="page-header">
                <div class="page-title">
                    <h1>${produto.id > 0 ? 'Editar produto' : 'Cadastrar produto'}</h1>
                    <p>Dados do item, preço, quantidade e categoria.</p>
                </div>
                <a class="btn btn-soft" href="${pageContext.request.contextPath}/produtos">
                    <i class="bi bi-arrow-left"></i> Voltar
                </a>
            </section>

            <c:if test="${not empty erro}">
                <div class="alert alert-danger">${erro}</div>
            </c:if>

            <form class="record-form" method="post" action="${pageContext.request.contextPath}/produtos" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${produto.id}">
                <input type="hidden" name="imagemAtual" value="${produto.imagem}">

                <div class="form-layout">
                    <section class="form-panel">
                        <div class="form-section">
                            <div class="section-title"><i class="bi bi-card-text"></i> Informações</div>
                            <div class="field-grid">
                                <div class="field-wide">
                                    <label class="form-label" for="nome">Nome do produto</label>
                                    <input id="nome" class="form-control" type="text" name="nome" value="${produto.nome}" placeholder="Ex: Mouse sem fio" required>
                                </div>
                                <div class="field-wide">
                                    <label class="form-label" for="descricao">Descrição</label>
                                    <textarea id="descricao" class="form-control" name="descricao" rows="5" placeholder="Detalhes do produto">${produto.descricao}</textarea>
                                </div>
                                <div class="field-wide">
                                    <label class="form-label" for="categoriaId">Categoria</label>
                                    <select id="categoriaId" class="form-select" name="categoriaId" required>
                                        <option value="">Selecione uma categoria</option>
                                        <c:forEach var="categoria" items="${categorias}">
                                            <option value="${categoria.id}" ${produto.categoriaId == categoria.id ? 'selected' : ''}>${categoria.nome}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-section">
                            <div class="section-title"><i class="bi bi-boxes"></i> Estoque e preço</div>
                            <div class="field-grid three">
                                <div>
                                    <label class="form-label" for="preco">Preço</label>
                                    <input id="preco" class="form-control" type="number" step="0.01" min="0" name="preco" value="${produto.preco}" required>
                                </div>
                                <div>
                                    <label class="form-label" for="quantidade">Quantidade</label>
                                    <input id="quantidade" class="form-control" type="number" min="0" name="quantidade" value="${produto.quantidade}" required>
                                </div>
                                <div>
                                    <label class="form-label" for="estoqueMinimo">Estoque mínimo</label>
                                    <input id="estoqueMinimo" class="form-control" type="number" min="0" name="estoqueMinimo" value="${produto.estoqueMinimo}" required>
                                </div>
                            </div>
                        </div>
                    </section>

                    <aside class="media-panel">
                        <h2><i class="bi bi-image"></i> Imagem</h2>
                        <c:choose>
                            <c:when test="${not empty produto.imagem}">
                                <img class="image-preview" src="${pageContext.request.contextPath}/${produto.imagem}" alt="${produto.nome}">
                            </c:when>
                            <c:otherwise>
                                <div class="image-placeholder"><i class="bi bi-box-seam"></i></div>
                            </c:otherwise>
                        </c:choose>
                        <label class="form-label" for="imagem">Arquivo</label>
                        <input id="imagem" class="form-control" type="file" name="imagem" accept="image/*">
                    </aside>
                </div>

                <div class="form-actions">
                    <a class="btn btn-soft" href="${pageContext.request.contextPath}/produtos">Cancelar</a>
                    <button class="btn btn-primary" type="submit">
                        <i class="bi bi-check2-circle"></i> Salvar produto
                    </button>
                </div>
            </form>
        </main>
    </div>
</div>
</body>
</html>
