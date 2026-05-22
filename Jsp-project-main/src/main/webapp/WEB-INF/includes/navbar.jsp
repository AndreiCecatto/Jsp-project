<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- Barra superior compartilhada pelas telas internas. --%>
<header class="topbar">
    <div class="topbar-title">
        <i class="bi bi-shop-window"></i>
        <strong>Painel de estoque</strong>
        <span class="text-muted-soft">/ StockHub</span>
    </div>
    <div class="d-flex align-items-center gap-2 flex-wrap">
        <span class="user-pill">
            <i class="bi bi-person-circle"></i>
            ${usuarioLogado.nome}
        </span>
        <a class="btn btn-soft btn-sm" href="${pageContext.request.contextPath}/logout">
            <i class="bi bi-box-arrow-right"></i> Sair
        </a>
    </div>
</header>
