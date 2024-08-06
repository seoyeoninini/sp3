<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="header-top">
	<h1 class="logo"><a href="${pageContext.request.contextPath}/">SPRING<span>.</span></a></h1>

	<div>
		<a href="${pageContext.request.contextPath}/">로그인</a>
			&nbsp;|&nbsp;
		<a href="${pageContext.request.contextPath}/">회원가입</a>
				&nbsp;|&nbsp;
		<a href="${pageContext.request.contextPath}/admin" title="관리자">관리자</a>
	</div>
</div>

<div class="menu">
	<nav>
		<span><a href="#">방명록</a></span>
		<span><a href="#">게시판</a></span>
		<span><a href="${pageContext.request.contextPath}/qna/list">질문과 답변</a></span>
		<span><a href="${pageContext.request.contextPath}/notice/list">공지사항</a></span>
		<span><a href="#">일정관리</a></span>
	</nav>
	<h3>
		<a href="#"><i class="fas fa-bars"></i></a>
	</h3>	
</div>
