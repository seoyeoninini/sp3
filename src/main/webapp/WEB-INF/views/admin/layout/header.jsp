<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="header-top">
	<h1 class="logo"><a href="${pageContext.request.contextPath}/admin">Admin<span>.</span></a></h1>
	<div>
		<a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
			&nbsp;|&nbsp;
		<a href="${pageContext.request.contextPath}/">나가기</a>
	</div>
</div>

<div class="menu">
	<nav>
		<span><a href="#">회원관리</a></span>
		<span><a href="#">게시판관리</a></span>
		<span><a href="#">이벤트관리</a></span>
		<span><a href="#">일정관리</a></span>
		<span><a href="#">환경설정</a></span>
	</nav>
	<h3>
		<a href="#"><i class="fas fa-bars"></i></a>
	</h3>	
</div>
