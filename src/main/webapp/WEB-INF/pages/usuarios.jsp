<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>

<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
    <title>TaskFlow - Criar conta</title>
</head>
<body class="auth-page register-page">
<button class="theme-toggle auth-theme-toggle" type="button" data-theme-toggle title="Trocar tema" aria-label="Trocar tema">
    <i class="bi bi-sun-fill theme-icon-light"></i>
    <i class="bi bi-moon-stars-fill theme-icon-dark"></i>
</button>

<main class="auth-layout">
    <section class="auth-intro">
        <span class="page-kicker">Comece agora</span>
        <h1>Crie sua area de trabalho no TaskFlow.</h1>
        <p>Cadastre seu usuario para acessar o dashboard, organizar tarefas e acompanhar prazos em tempo real.</p>
    </section>

    <section class="auth-card-wrap">
        <div class="login-container register-card">
            <a class="auth-back" href="${pageContext.request.contextPath}/index.jsp">
                <i class="bi bi-arrow-left"></i> Voltar ao login
            </a>

            <h1><i class="bi bi-person-plus"></i></h1>
            <h2>Criar conta</h2>

            <form action="usuario" method="post">
                <div class="mb-3">
                    <label class="form-label" for="nome">Nome</label>
                    <input class="form-control" type="text" placeholder="Seu nome completo" name="nome" id="nome" required>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="email">E-mail</label>
                    <input class="form-control" type="email" placeholder="voce@email.com" name="email" id="email" required>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="senha">Senha</label>
                    <input class="form-control" type="password" placeholder="Crie uma senha" name="senha" id="senha" required>
                </div>

                <button class="btn btn-login" type="submit" name="cadastrar">Cadastrar</button>
            </form>

            <c:if test="${not empty erro}">
                <div class="error-message">
                    <strong>Erro:</strong> ${erro}
                </div>
            </c:if>

            <c:if test="${not empty listausuarios}">
                <div class="registered-users">
                    <h3>Usuarios cadastrados</h3>
                    <div class="mini-user-list">
                        <c:forEach var="usuario" items="${listausuarios}">
                            <div class="mini-user">
                                <span><i class="bi bi-person"></i></span>
                                <div>
                                    <strong>${usuario.nome}</strong>
                                    <small>${usuario.email}</small>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/theme.js"></script>
</body>
</html>
