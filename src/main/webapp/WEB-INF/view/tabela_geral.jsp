<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css" />'>
<title>Tabela Geral</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
		<br />
	</div>
	<div id="centro" align="center">	
			<c:if test="${not empty listaTabelaGeral }">
			<table border="1">
				<thead>
					<tr>
						<th>Nome Time</th>
						<th>Jogos Disputados</th>
						<th>Vitorias</th>
						<th>Empates</th>
						<th>Derrotas</th>
						<th>Gols Marcados</th>
						<th>Gols Sofridos</th>
						<th>Saldo de gols</th>
						<th>Pontos</th>
					</tr>
				</thead>
				<c:forEach items="${listaTabelaGeral }" var="tg">
					<c:if test="${tg.rebaixamento == true }">
						<tr style="background-color:#f28482">
							<td ><c:out value="${tg.nome }" /></td>
							<td ><c:out value="${tg.jogosDisputados }" /></td>
							<td ><c:out value="${tg.vitorias }" /></td>
							<td ><c:out value="${tg.empates }" /></td>
							<td ><c:out value="${tg.derrotas }" /></td>
							<td ><c:out value="${tg.golsMarcados }" /></td>
							<td ><c:out value="${tg.golsSofridos }" /></td>
							<td ><c:out value="${tg.saldoGols }" /></td>
							<td ><c:out value="${tg.pontos }" /></td>
						</tr>
					</c:if>
					<c:if test="${tg.rebaixamento == false }">
						<tr>
							<td><c:out value="${tg.nome }" /></td>
							<td><c:out value="${tg.jogosDisputados }" /></td>
							<td><c:out value="${tg.vitorias }" /></td>
							<td><c:out value="${tg.empates }" /></td>
							<td><c:out value="${tg.derrotas }" /></td>
							<td><c:out value="${tg.golsMarcados }" /></td>
							<td><c:out value="${tg.golsSofridos }" /></td>
							<td><c:out value="${tg.saldoGols }" /></td>
							<td><c:out value="${tg.pontos }" /></td>
						</tr>
					</c:if>
				
				</c:forEach>
			</table>
			</c:if>
	</div>
	<div>
		<c:if test="${not empty erro }">
			<H2 style="color: red"><c:out value="${erro }" /></H2>
		</c:if>
	</div>
</body>
</html>