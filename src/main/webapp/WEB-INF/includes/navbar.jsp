<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dashboardActive" value="" />
<c:set var="tarefasActive" value="" />
<c:if test="${activePage == 'dashboard'}">
    <c:set var="dashboardActive" value="active" />
</c:if>
<c:if test="${activePage == 'tarefas'}">
    <c:set var="tarefasActive" value="active" />
</c:if>

<nav class="navbar navbar-expand-lg sticky-top app-navbar">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard">
            <span class="brand-mark"><i class="bi bi-git"></i></span>
            <span>TaskFlow</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Alternar navegacao">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link ${dashboardActive}" href="${pageContext.request.contextPath}/dashboard">
                        <i class="bi bi-activity"></i> Actions
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${tarefasActive}" href="${pageContext.request.contextPath}/tarefas">
                        <i class="bi bi-record-circle"></i> Issues
                    </a>
                </li>
            </ul>

            <div class="navbar-user d-flex align-items-center gap-3">
                <button class="theme-toggle" type="button" data-theme-toggle title="Trocar tema" aria-label="Trocar tema">
                    <i class="bi bi-sun-fill theme-icon-light"></i>
                    <i class="bi bi-moon-stars-fill theme-icon-dark"></i>
                </button>
                <div class="user-chip">
                    <span class="user-avatar"><i class="bi bi-person"></i></span>
                    <span>${usuarioLogado.nome}</span>
                </div>
                <a class="btn btn-sm btn-soft" href="${pageContext.request.contextPath}/logout" title="Sair">
                    <i class="bi bi-box-arrow-right"></i>
                </a>
            </div>
        </div>
    </div>
</nav>

<script src="${pageContext.request.contextPath}/js/theme.js"></script>
