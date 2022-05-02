<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css" />'>
<title>Quartas de Final</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
		<br />
	</div>
	<div id="centro" align="center">	
			<c:if test="${not empty listaQuartas }">
			<table border="1">
				<thead>
					<tr>
						<th>Time A</th>
						<th></th>
						<th>Time B</th>
					</tr>
				</thead>
				<c:forEach items="${listaQuartas }" var="q">
						<tr>
							<td><c:out value="${q.timeA }" /></td>
							<td><h2 align="center"> X </h2></td>
							<td><c:out value="${q.timeB }" /></td>
						</tr>	
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