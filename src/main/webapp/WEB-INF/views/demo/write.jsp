<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

	<h3> 선언적 트랜잭션 : XML 스키마 이용 </h3>
	
	<form action= "<c:url value='/demo/write'/>" method = "post">
		<p> 아이디 : <input type="text" name="id"> </p>
		<p> 이름 : <input type="text" name="name"> </p>
		<p> 생년월일 : <input type="text" name="birth"> </p>
		<p> 전화번호 : <input type="text" name="tel"> </p>
		<p>
			<button type="submit"> 등록하기 </button>
		</p>
	</form>

</body>
</html>