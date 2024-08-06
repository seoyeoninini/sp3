<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><tiles:insertAttribute name="title"/></title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" type="text/css">
	
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.4.2/css/all.css">
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>	
</head>

<body>

<header class="header">
    <tiles:insertAttribute name="header"/>
</header>
	
<main class="container">
    <tiles:insertAttribute name="body"/>
</main>

<footer class="footer">
    <tiles:insertAttribute name="footer"/>
</footer>

</body>
</html>