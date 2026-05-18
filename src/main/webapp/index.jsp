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
    <title>TaskFlow - Login</title>
</head>

<body class="auth-page">
<button class="theme-toggle auth-theme-toggle" type="button" data-theme-toggle title="Trocar tema" aria-label="Trocar tema">
    <i class="bi bi-sun-fill theme-icon-light"></i>
    <i class="bi bi-moon-stars-fill theme-icon-dark"></i>
</button>

<main class="auth-layout">
    <section class="auth-intro">
        <span class="page-kicker">TaskFlow</span>
        <h1>Controle suas tarefas com clareza.</h1>
        <p>Um painel moderno para acompanhar prioridades, prazos e progresso do seu trabalho em um unico lugar.</p>
    </section>

    <section class="auth-card-wrap">
        <div class="login-container">
            <h1><i class="bi bi-kanban"></i></h1>
            <h2>Entrar no TaskFlow</h2>

            <form action="login" method="post">
                <div class="mb-3">
                    <label class="form-label">E-mail</label>
                    <input type="email" class="form-control" placeholder="admin@taskflow.com" name="email" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Senha</label>
                    <input type="password" class="form-control" placeholder="Sua senha" name="senha" required>
                </div>

                <button type="submit" class="btn btn-login">Entrar</button>

                <p class="text-center mt-3 mb-0">
                    <a class="auth-link" href="usuario">Criar conta</a>
                </p>
            </form>

            <c:if test="${not empty erro}">
                <div class="error-message">
                    <strong>Erro:</strong> ${erro}
                </div>
            </c:if>
        </div>
    </section>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/theme.js"></script>
</body>
</html>
