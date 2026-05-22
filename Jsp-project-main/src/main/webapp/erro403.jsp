<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<%-- Pagina simples para quando alguem tenta acessar diretamente arquivos protegidos em WEB-INF. --%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <title>StockHub - Acesso protegido</title>
</head>
<body class="auth-page">
<main class="auth-card text-center">
    <span class="brand-logo"><i class="bi bi-shield-lock"></i></span>
    <h1>Acesso protegido</h1>
    <p>Entre pelo login do StockHub para acessar as telas internas do sistema.</p>
    <a class="btn btn-primary w-100 mt-3" href="${pageContext.request.contextPath}/index.jsp">
        <i class="bi bi-door-open"></i> Ir para o login
    </a>
</main>
</body>
</html>
