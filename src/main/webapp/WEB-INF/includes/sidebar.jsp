<aside class="app-sidebar bg-dark text-white">
    <h5 class="app-sidebar-title">Menu</h5>

    <ul class="nav flex-column app-sidebar-nav">
        <li class="nav-item">
            <a class="nav-link ${activePage == 'clientes' ? 'active' : ''}" href="${pageContext.request.contextPath}/cliente">Clientes</a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${activePage == 'pedidos' ? 'active' : ''}" href="#">Pedidos</a>
        </li>
    </ul>
</aside>
