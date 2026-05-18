<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>

<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">

    <title>Cadastro de cliente</title>
</head>
<body>
    <c:set var="activePage" value="clientes" scope="request" />

    <div class="layout-wrapper">
        <%@ include file="/WEB-INF/includes/navbar.jsp" %>

        <div class="app-shell">
            <%@ include file="/WEB-INF/includes/sidebar.jsp" %>

            <main class="app-main">
                    <section class="page-heading">
                        <div>
                            <span class="page-kicker"><i class="bi bi-people"></i> Customers</span>
                            <h1>Clientes</h1>
                            <p>Cadastre e acompanhe clientes no mesmo visual do workspace.</p>
                        </div>
                    </section>

                    <div class="cliente-container">
                        <div class="panel-header">
                            <div>
                                <h2>Novo cliente</h2>
                                <p>Informe os dados principais para registrar um cliente.</p>
                            </div>
                        </div>

                        <form action="cliente" method="post">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="nome" class="form-label">Nome</label>
                                    <input type="text" class="form-control" placeholder="Nome do cliente" name="nome"
                                        id="nome" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="dataNascimento" class="form-label">Data de Nascimento</label>
                                    <input type="date" class="form-control" name="datanascimento"
                                        id="dataNascimento" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="telefone" class="form-label">Telefone</label>
                                    <input type="text" class="form-control" placeholder="Telefone do cliente" name="telefone"
                                        id="telefone" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="estado" class="form-label">Estado</label>
                                    <input type="text" class="form-control" placeholder="Ex: Rio Grande do Sul" name="estado"
                                        id="estado" required>
                                </div>

                                <div class="col-md-6">
                                    <label for="cidade" class="form-label">Cidade</label>
                                    <input type="text" class="form-control" placeholder="Santa Maria" name="cidade"
                                        id="cidade">
                                </div>

                                <div class="col-md-6">
                                    <label for="email" class="form-label">E-mail</label>
                                    <input type="email" class="form-control" placeholder="fulano@gmail.com" name="email"
                                        id="email">
                                </div>
                            </div>

                            <button type="submit" name="cadastrar" class="btn btn-primary mt-4">
                                <i class="bi bi-check2 me-1"></i>Cadastrar
                            </button>
                        </form>

                        <c:if test="${not empty erro}">
                            <div class="error-message">
                                <strong>Erro:</strong> ${erro}
                            </div>
                        </c:if>
                    </div>

                    <section class="clientes-lista">
                        <div class="d-flex flex-column flex-md-row align-items-md-center justify-content-between gap-2 mb-3">
                            <h2>Clientes cadastrados</h2>
                            <span class="badge status-badge">${listaClientes.size()} cliente(s)</span>
                        </div>

                        <div class="table-responsive">
                            <table class="table task-table align-middle mb-0">
                                <thead>
                                <tr>
                                    <th>Nome</th>
                                    <th>Data de Nascimento</th>
                                    <th>Telefone</th>
                                    <th>Estado</th>
                                    <th>Cidade</th>
                                    <th>E-mail</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="clientes" items="${listaClientes}">
                                    <tr>
                                        <td>${clientes.nome}</td>
                                        <td>${clientes.dataNascimento}</td>
                                        <td>${clientes.telefone}</td>
                                        <td>${clientes.estado}</td>
                                        <td>${clientes.cidade}</td>
                                        <td>${clientes.email}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                        </div>
                    </section>
                </main>
        </div>
    </div>
            
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtkeAr9qsrk4YJ6efKU3RJMdpJVlRbVlF5w5UEawJiAaO8GKHZTZ0SZjfQXX7" crossorigin="anonymous"></script>
</body>
</html>
