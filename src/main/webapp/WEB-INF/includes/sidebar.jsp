<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dashboardActive" value="" />
<c:set var="tarefasActive" value="" />
<c:set var="novaTarefaActive" value="" />
<c:set var="clientesActive" value="" />
<c:if test="${activePage == 'dashboard'}">
    <c:set var="dashboardActive" value="active" />
</c:if>
<c:if test="${activePage == 'tarefas'}">
    <c:set var="tarefasActive" value="active" />
</c:if>
<c:if test="${activePage == 'novaTarefa'}">
    <c:set var="novaTarefaActive" value="active" />
</c:if>
<c:if test="${activePage == 'clientes'}">
    <c:set var="clientesActive" value="active" />
</c:if>

<aside class="app-sidebar">
    <div class="app-sidebar-brand">
        <span class="app-logo"><i class="bi bi-git"></i></span>
        <div>
            <h5 class="app-sidebar-title">andre/taskflow</h5>
            <small>Private workspace</small>
        </div>
    </div>

    <ul class="nav flex-column app-sidebar-nav">
        <li class="sidebar-label">Repository</li>
        <li class="nav-item">
            <a class="nav-link ${dashboardActive}" href="${pageContext.request.contextPath}/dashboard">
                <i class="bi bi-play-circle"></i>Actions
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${tarefasActive}" href="${pageContext.request.contextPath}/tarefas">
                <i class="bi bi-record-circle"></i>Issues
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${novaTarefaActive}" href="${pageContext.request.contextPath}/tarefas?acao=novo">
                <i class="bi bi-plus-circle"></i>New issue
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${clientesActive}" href="${pageContext.request.contextPath}/cliente">
                <i class="bi bi-people"></i>Customers
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <span>Latest workflow</span>
        <strong><i class="bi bi-check-circle-fill"></i> taskflow/build</strong>
    </div>
</aside>
