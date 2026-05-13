<nav class="navbar navbar-expand-lg bg-dark navbar-dark py-3 sticky-top app-navbar">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/cliente">Sistema de Pedidos</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Alternar navegacao">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/cliente">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'clientes' ? 'active' : ''}" href="${pageContext.request.contextPath}/cliente">Clientes</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${activePage == 'pedidos' ? 'active' : ''}" href="#">Pedidos</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
