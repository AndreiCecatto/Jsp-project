<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>


<html>
<head>
    <title>Cadastro de Usuários</title>
</head>
<body>
<h1>CADASTRAR USUÁRIOS</h1>

<form action="usuario" method="post">
    <label for="nome">
        <b>Nome</b>
    </label>
    <input type="text" placeholder="nome do usuário", name="nome"
    id="nome" required>
    </br>
    <label for="email">
        <b>E-mail</b>
    </label>
    <input type="email" placeholder="email do usuário", name="email"
           id="email" required>
    </br>
    <label for="senha">
        <b>senha</b>
    </label>
    <input type="password" placeholder="senha do usuário", name="senha"
           id="senha" required>
    </br>
    <input type="submit" value="cadastrar" name="cadastrar">
</form>

<c:if test="${not empty erro}">
    <h2>${erro}</h2>
</c:if>

<h2>tabela ....</h2>

<table>
    <th>Nome</th>
    <th>e-mail</th>
    <th>ativo</th>
    <c:forEach var="usuario" items="${listausuarios}">
        <tr>
            <td>${usuario.nome}</td>
            <td>${usuario.email}</td>
            <td>${usuario.ativo}</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
