<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Tabela Grupos</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
		<br />
	</div>
	<div>
		<form action="tabela_grupos" method="post">
			<table>
			<tr>
				<td colspan="1"><button type="submit" value="A" id="buttonA" name="button" >Grupo A</button></td>
				<td colspan="1"><button type="submit" value="B" id="buttonB" name="button" >Grupo B</button></td>
				<td colspan="1"><button type="submit" value="C" id="buttonC" name="button" >Grupo C</button></td>
				<td colspan="1"><button type="submit" value="D" id="buttonD" name="button" >Grupo D</button></td>
			</tr>			
			</table>
			<br /><br />
			
			<c:if test="${not empty listaTabelaGrupos }">
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
				<c:forEach items="${listaTabelaGrupos }" var="tg">
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
		</form>
	</div>
	<div>
		<c:if test="${not empty erro }">
			<H2 style="color: red"><c:out value="${erro }" /></H2>
		</c:if>
	</div>
</body>
</html>