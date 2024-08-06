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
.container { width: 500px; margin: 30px auto; }

.title { width:100%; font-size: 16px; font-weight: bold; padding: 13px 0; }

.table-form td { padding: 7px 0; }
.table-form tr:first-child { border-top: 2px solid #212529; }
.table-form tr > td:first-child { text-align: center; background: #f8f9fa; width: 100px; }
.table-form tr > td:nth-child(2) { padding-left: 10px; }
.table-form input[type=text], .table-form input[type=date] { width: 96%; }

.info-box { padding: 10px 0; text-align: center; color: blue; }
</style>

<script type="text/javascript">
function isValidDateFormat(data) {
    let regexp = /[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}/;
    if(! regexp.test(data))
        return false;

    regexp=/(\.)|(\-)|(\/)/g;
    data=data.replace(regexp, "");
    
	let y=parseInt(data.substr(0, 4));
    let m=parseInt(data.substr(4, 2));
    if(m<1||m>12) {
    	return false;
    }
    let d=parseInt(data.substr(6));
    let lastDay = (new Date(y, m, 0)).getDate();
    if(d<1||d>lastDay) {
    	return false;
    }
		
	return true;     
}

function isValidScoreFormat(data) {
    let regexp = /^(\d+)$/;
    if(! regexp.test(data)) {
        return false;
    }
	let s = parseInt(data);
	return s>=0 && s<=100 ? true : false;
}

function check() {
	const f=document.scoreForm;
	
	if(! f.hak.value.trim()) {
        alert("필수 입력 사항 입니다. !!!");
        f.hak.focus();
        return false;
	}

	if(! f.name.value.trim()) {
        alert("필수 입력 사항 입니다. !!!");
        f.name.focus();
        return false;
	}
	
    if(! isValidDateFormat(f.birth.value)) {
        alert("날짜 형식이 유효하지 않습니다. ");
        f.birth.focus();
        return false;
	}
	
    if(! isValidScoreFormat(f.kor.value)) {
		alert("점수는 0~100 사이만 가능합니다. ");
		f.kor.focus();
		return false;
    }
    
    if(! isValidScoreFormat(f.eng.value)) {
        alert("점수는 0~100 사이만 가능합니다. ");
        f.eng.focus();
        return false;
	}
    if(! isValidScoreFormat(f.mat.value)) {
        alert("점수는 0~100 사이만 가능합니다. ");
        f.mat.focus();
        return false;
	}
	
    f.action="${pageContext.request.contextPath}/escore/${mode}";

	return true;
}

</script>
</head>
<body>

<div class="container">
	<div class="title">
	    <h3><span>|</span> 성적처리</h3>
	</div>

	<form name="scoreForm" method="post" onsubmit="return check();">
		<table class="table table-border table-form">
		<tr>
			<td>학 번</td>
			<td>
				<input type="text" name="hak" class="form-control" maxlength="10" value="${dto.hak}"
						${mode=="update"?"readonly":""}>
			</td>
		</tr>
		
		<tr>
			<td>이 름</td>
			<td>
				<input type="text" name="name" class="form-control" maxlength="10" value="${dto.name}">
			</td>
		</tr>
		
		<tr>
			<td>생년월일</td>
			<td>
				<input type="date" name="birth" class="form-control" maxlength="10" value="${dto.birth}">
			</td>
		</tr>
		
		<tr>
			<td>국 어</td>
			<td>
				<input type="text" name="kor" class="form-control" maxlength="3" value="${dto.kor}">
			</td>
		</tr>
		
		<tr>
			<td>영 어</td>
			<td>
				<input type="text" name="eng" class="form-control" maxlength="3" value="${dto.eng}">
			</td>
		</tr>
		
		<tr>
			<td>수 학</td>
			<td>
				<input type="text" name="mat" class="form-control" maxlength="3" value="${dto.mat}">
			</td>
		</tr>
		</table>
		
		<table class="table">
			<tr>
				<td align="center" colspan="2">
					<button type="submit" class="btn"> ${mode=="update"?"수정완료":"등록완료"} </button> 
					<button type="reset" class="btn"> 다시입력 </button>
					<button type="button" class="btn"
						onclick="javascript:location.href='${pageContext.request.contextPath}/escore/list';"> ${mode=="update"?"수정취소":"등록취소"} </button>
					<c:if test="${mode=='update'}">
						<input type="hidden" name="page" value="${page}">
					</c:if>	
				</td>
			</tr>
		</table>
	</form>
	
	<div class="info-box">${msg}</div>
</div>

</body>
</html>