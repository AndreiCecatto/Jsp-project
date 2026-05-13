<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>

<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">

    <title>Login</title>
</head>

<body class="auth-page">
    <div class="d-flex justify-content-center align-items-center vh-100">
        <main class="page-container container">

            <div class="login-container mx-auto">
                <h1>
                    <img src="https://img.icons8.com/?size=100&id=26211&format=png&color=FFFFFF" alt="icon">
                </h1>

                <h2>Insira seus dados para acessar o sistema</h2>

                <form action="login" method="post">
                    <div class="row g-3">

                        <div class="col-12">
                            <label class="form-label">E-mail</label>
                            <input type="email" class="form-control" placeholder="Seu email" name="email" required>
                        </div>

                        <div class="col-12">
                            <label class="form-label">Senha</label>
                            <input type="password" class="form-control" placeholder="Sua senha" name="senha" required>
                        </div>
                        <p class="text-center text-decoration-underline">Esqueceu sua senha?</p>

                    </div>

                    <input type="submit" value="LOGAR" class="btn btn-login mt-1">
                    <p class="text-center text-decoration-underline"><a href="usuario">Criar conta</a></p>

                </form>

                <c:if test="${not empty erro}">
                    <div class="error-message">
                        <strong>Erro:</strong> ${erro}
                    </div>
                </c:if>
            </div>

        </main>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
