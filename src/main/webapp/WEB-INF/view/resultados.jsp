<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Resultados Jogos</title>
</head>
<body>

	<div>
		<jsp:include page="menu.jsp" />
		<br />
	</div>
	<form action="resultados" method="post">
		<div>	
				<c:if test="${not empty listaDatas }">
				<div align="center">
					<table style="margin: 1px solid black">
						<c:forEach items="${listaDatas }" var="datas">
								<td><button	type="submit" value="${datas.data }" id="buttonData" name="buttonData"><c:out value="${datas.data }" /></button></td>
						</c:forEach>
					</table>
				</div>
				</c:if>
		</div>
		
		<div>	
				<c:if test="${not empty listaJogos }">
				<div align="center">
					<table style="margin: 1px solid black">
						<thead>
						<tr>
							<th style="border: 1px solid black">Time A</th>
							<th style="border: 1px solid black">Gols</th>
							<th style="border: 1px solid black">Gols</th>
							<th style="border: 1px solid black">Time B</th>
						</tr>
					</thead>
						<c:forEach items="${listaJogos }" var="j">
							<tr>
								<td style="border: 1px solid black"><c:out value="${j.timeA }" /></td>
								<td style="border: 1px solid black"><input type="number" id="golsTimeA" name="golsTimeA" placeholder="${j.golsTimeA }" ></td>
								<td style="border: 1px solid black"><input type="number" id="golsTimeB" name="golsTimeB" placeholder="${j.golsTimeB }" ></td>
								<td style="border: 1px solid black"><c:out value="${j.timeB }" /></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				</c:if>
		</div>
	</form>
	<div>
		<c:if test="${not empty erro }">
			<H2 style="color: red"><c:out value="${erro }" /></H2>
		</c:if>
	</div>
	
</body>
</body>
</html>