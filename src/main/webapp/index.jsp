<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>

<%-- Login publico. As telas internas continuam protegidas por SessaoUtil. --%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <title>StockHub - Login</title>
</head>
<body class="auth-page">
<main class="auth-card">
    <span class="brand-logo"><i class="bi bi-box-seam"></i></span>
    <h1>StockHub</h1>
    <p>Acesse o painel da loja.</p>

    <form action="login" method="post" class="mt-4">
        <div class="mb-3">
            <label class="form-label" for="email">E-mail</label>
            <input id="email" type="email" class="form-control" name="email" placeholder="teste@teste" required>
        </div>
        <div class="mb-3">
            <label class="form-label" for="senha">Senha</label>
            <input id="senha" type="password" class="form-control" name="senha" placeholder="123" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">
            <i class="bi bi-door-open"></i> Entrar
        </button>
    </form>

    <c:if test="${not empty erro}">
        <div class="alert alert-danger mt-3 mb-0">${erro}</div>
    </c:if>
</main>
</body>
</html>
