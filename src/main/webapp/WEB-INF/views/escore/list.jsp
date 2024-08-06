<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* { padding: 0; margin: 0; }
*, *::after, *::before { box-sizing: border-box; }

body {
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	font-size: 14px;
	color: #222;
}

a { color: #222; text-decoration: none; cursor: pointer; }
a:active, a:hover { color: #f28011; text-decoration: underline; }

/* form-control */
.btn {
	color: #333;
	border: 1px solid #999;
	background-color: #fff;
	padding: 5px 10px;
	border-radius: 4px;
	font-weight: 500;
	cursor:pointer;
	font-size: 14px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.btn:active, .btn:focus, .btn:hover {
	background-color: #f8f9fa;
	color:#333;
}
.btn[disabled], fieldset[disabled] .btn {
	pointer-events: none;
	cursor: default;
	opacity: .65;
}

.form-control {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 5px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.form-control[readonly] { background-color:#f8f9fa; }

textarea.form-control { height: 170px; resize : none; }

.form-select {
	border: 1px solid #999; border-radius: 4px; background-color: #fff;
	padding: 4px 5px; 
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	vertical-align: baseline;
}
.form-select[readonly] { background-color:#f8f9fa; }

textarea:focus, input:focus { outline: none; }
input[type=checkbox], input[type=radio] { vertical-align: middle; }

/* table */
.table { width: 100%; border-spacing: 0; border-collapse: collapse; }
.table th, .table td { padding-top: 10px; padding-bottom: 10px; }

.table-border thead > tr { border-top: 2px solid #212529; border-bottom: 1px solid #ced4da; }
.table-border tbody > tr { border-bottom: 1px solid #ced4da; }
.table-border tfoot > tr { border-bottom: 1px solid #ced4da; }
.td-border td { border: 1px solid #ced4da; }

/* container */
.container { width: 750px; margin: 30px auto; }

.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.table-list thead > tr { background: #f8f9fa; }
.table-list td, .table-list th { border: 1px solid #ced4da; }
.table-list td { text-align: center; }

/* paginate */
.page-navigation { clear: both; padding: 20px 0; text-align: center; }

.paginate {
	text-align: center;
	white-space: nowrap;
	font-size: 14px;	
}
.paginate a {
	border: 1px solid #ccc;
	color: #000;
	font-weight: 600;
	text-decoration: none;
	padding: 3px 7px;
	margin-left: 3px;
	vertical-align: middle;
}
.paginate a:hover, .paginate a:active {
	color: #6771ff;
}
.paginate span {
	border: 1px solid #e28d8d;
	color: #cb3536;
	font-weight: 600;
	padding: 3px 7px;
	margin-left: 3px;
	vertical-align: middle;
}
.paginate :first-child {
	margin-left: 0;
}
</style>

<script type="text/javascript">
function searchList() {
	let f=document.searchForm;
	f.submit();
}

function deleteScore(hak) {
	let url="${pageContext.request.contextPath}/escore/delete?hak="+hak+"&page=${page}";
	if(confirm("자료를 삭제 하시겠습니까?")) {
		location.href=url;
	}
}

function updateScore(hak) {
	let url="${pageContext.request.contextPath}/escore/update?hak="+hak+"&page=${page}";
	location.href=url;
}

function printScore() {
	let url="${pageContext.request.contextPath}/escore/print";
	window.open(url, "score", "width=800, height=500, left=50, top=50");
}
</script>

</head>
<body>

<div class="container">
	<div class="title">
	    <h3><span>|</span> 성적처리</h3>
	</div>
	
	<table class="table">
		<tr>
			<td align="left" width="50%">
				${dataCount}개(${page}/${total_page} 페이지)
			</td>
			<td align="right">
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/escore/excel';" class="btn">EXCEL</button>
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/escore/pdf';" class="btn">PDF</button>
				<button type="button" class="btn" onclick="printScore();">Print</button>
			</td>
		</tr>
	</table>

	<table class="table table-list">
		<thead>
			<tr>
				<th width="70">학번</th>
				<th width="110">이름</th>
				<th width="110">생년월일</th>
				<th width="60">국어</th>
				<th width="60">영어</th>
				<th width="60">수학</th>
				<th width="60">총점</th>
				<th width="60">평균</th>
				<th>변경</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach var="dto" items="${list}">
				<tr>
					<td>${dto.hak}</td>
					<td>${dto.name}</td>
					<td>${dto.birth}</td>
					<td>${dto.kor}</td>
					<td>${dto.eng}</td>
					<td>${dto.mat}</td>
					<td>${dto.tot}</td>
					<td>${dto.ave}</td>
					<td>
						<a href="javascript:updateScore('${dto.hak}')">수정</a> | 
						<a href="javascript:deleteScore('${dto.hak}')">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="page-navigation">
		${dataCount==0?"등록된 게시물이 없습니다.":paging}
	</div>
	
	<table class="table">
		<tr>
			<td width="100">
				<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/escore/list';">새로고침</button>
			</td>
			<td align="center">
				<form name="searchForm" action="${pageContext.request.contextPath}/escore/list" method="post">
					<select name="schType" class="form-select">
						<option value="hak" ${schType=="hak"?"selected":""}>학번</option>
						<option value="name" ${schType=="name"?"selected":""}>이름</option>
						<option value="birth" ${schType=="birth"?"selected":""}>생년월일</option>
					</select>
					<input type="text" name="kwd" value="${kwd}" class="form-control">
					<button type="button" class="btn" onclick="searchList();">검색</button>
				</form>
			</td>
			<td align="right" width="100">
				<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/escore/insert';">등록하기</button>
			</td>
		</tr>
	</table>	
</div>

</body>
</html>