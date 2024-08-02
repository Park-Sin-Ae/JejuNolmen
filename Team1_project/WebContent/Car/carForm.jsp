<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차량 등록하기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
 <!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="<%= request.getContextPath()%>/font/font.css">
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/main.css">

<script>

	$(document).ready(function(){
		$('#submitBtn').click(function(){
		
		/* var vform = document.querySelector('#carForm');	
		var formData = new FormData(vform);
		
		formData = vforom.serializeJSON(); */
		
		var formData = new FormData($('#carForm')[0]);
		
		/* data = {
			"no" : $('#no').val(),
			"year" : $('#year').val(),
			"type" : $('#type').val(),
			"name" : $('#name').val(),
			"price" : $('#price').val(),
			"companyName" : $('#companyName').val(),
			"companyCode" : $('#companyCode').val(),
			"companyTel" : $('#companyTel').val(),
			"companyAddr" : $('#companyAddr').val(),
			"companyMail" : $('#companyMail').val(),
			"content" : $('#content').val(),
			"imgPath" : $('#imgPath').val()
		}
		 */
		$.ajax({
			url : "<%=request.getContextPath() %>/carInsert.do",
			type : "post",
			data : formData,
			enctype : "multipart/form-data",
			//cache : false,
			contentType : false,
			processData : false,
			async : true,
			success : function(response){
				alert("등록 성공");
				window.location.href = "car.jsp";
			},
			error : function(){
				alert("등록 실패!!!");
			},
			dataType : 'json'
 		 })
			
	   })
	   
	   $('#cancelBtn').click(function(){
		    window.history.back(); // 이전 페이지로 돌아가기
		});
	   
	   
	})



</script>
</head>
<body>
<!-- header str -->
<div class="border-bottom">
<div class="container">
<nav class="navbar navbar-expand-lg justify-content-lg-between">
  <a class="navbar-brand" href="<%=request.getContextPath()%>/main.jsp"><img alt="로고" src="<%=request.getContextPath()%>/images/logo.png"></a>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link navTxt" href="<%=request.getContextPath()%>/lodging/resLodging.jsp">숙소 </a>
      </li>
      <li class="nav-item">
        <a class="nav-link navTxt" href="<%=request.getContextPath()%>/Car/carList.jsp">렌트카</a>
      </li>
      <li class="nav-item">
        <a class="nav-link navTxt" href="">이벤트</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <img alt="귤" src="<%=request.getContextPath()%>/images/gyul.png">
        </a>
<%
	MemberVO loginMember = (MemberVO)session.getAttribute("loginMember");
%>
<%
if(loginMember == null){
	
%>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="<%=request.getContextPath()%>/Member/login.jsp">로그인/회원가입</a>
        </div>
	<%
} else {		//로그인이 되었을 때..
%>
<div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a id="mainMyPage"class="dropdown-item" href="<%=request.getContextPath()%>/Member/memUpdate.jsp">마이페이지</a>
          <a class="dropdown-item" href="<%=request.getContextPath()%>/reservation/reservation.jsp">예약내역</a>

          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="<%=request.getContextPath()%>/memberLogout.do">로그아웃</a>
</div>

		
	<%
}
	%>
        
      </li>
    </ul>
  </div>
</nav>
</div>
</div>
<!-- header end -->
<div class="container">
	<div class="row">
		<div class="col-3">
			<ul class="mypage">
			  <li><a href="<%=request.getContextPath()%>/Car/car.jsp">차량 관리</a></li>
			  <li><a href="<%=request.getContextPath()%>/lodging/lodging.jsp">숙소 관리</a></li>
			  <li><a href="<%=request.getContextPath()%>/event/event.jsp">이벤트 관리</a></li>
			  <li><a href="<%=request.getContextPath()%>/notice/notice.jsp">공지사항 관리</a></li>
			  <li><a href="<%=request.getContextPath()%>/qnaReply/qnaReply.jsp">고객문의 관리</a></li>
			</ul>
		</div>
		<div class="col-9">
		<form id="carForm" method="post" enctype="multipart/form-data">
		<div id="insertForm">
		<div class="mt-5">
			<h3>차량 등록</h3>
			<hr>
		</div>
			<div class="cont1 xsCont">
				<div>
                <label for="title" class="form-label">업체코드</label>
                <input class="form-control" type="text" id="companyCode" name="companyCode" required>
            </div>
			<div>
                <label for="title" class="form-label">차량번호</label>
                <input class="form-control" type="text" id="no" name="no" required>
            </div>
			<div>
                <label for="title" class="form-label">연식</label>
                <input class="form-control" type="text" id="year" name="year" required>
            </div>
			<div>
                <label for="type" class="form-label">차량종류</label>
                <select class="form-control" id="type" name="type" required>
                	<option value="경/소형">경/소형</option>
                	<option value="중형차">중형차</option>
                	<option value="SUV">SUV</option>
                	<option value="전기차">전기차</option>
                </select>
            </div>
			<div>
                <label for="title" class="form-label">차량명</label>
                <input class="form-control" type="text" id="name" name="name" required>
            </div>
			<div>
                <label for="title" class="form-label">가격</label>
                <input class="form-control" type="text" id="price" name="price" required>
            </div>
            <div>
                <label for="title" class="form-label">이용정보</label>
				<textarea class="form-control" id="content" name="content" style="width: 500px; height:200px;"></textarea>
            </div>
            <div class="mt-3">
            	차량 이미지 첨부 <input type="file" id="imgPath" name="fimg">
            </div>
            <div id="button" class="text-center mt-5">
                <button class="btn btn-success" type="button" id="submitBtn">등록</button>
                <button class="btn btn-outline-danger" type="button" id="cancelBtn">취소</button>
            </div>
			</div>
		</div>
	</form>
		</div>
	</div>
</div>
	

	<!-- footer str -->
<div class="footer">
	<div class="ftWrap">
		<div class="ftTxt">
			<p>(주)제주놀멘컴퍼니</p>
			<p>주소 : 대전광역시 대전광역시 중구 계룡로 846, 3층 305호 | 대표이사 : 김현경 | 사업자등록번호 : 123-12-12345</p>
			<p>전화번호 : 042-222-8202 | 호스팅서비스제공자의 상호 표시 : (주)제주놀멘컴퍼니</p>
		</div>
		<ul class="mt-3">
			<li><a href="#">이용약관</a></li>
			<li><a href="#"><span class="black">개인정보처리방침</span></a></li> 
			<li><a href="#">소비자 분쟁해결 기준</a></li>
			<li><a href="#">콘텐츠산업진흥법에 의한 표시</a></li>
		</ul>
		<div class=copyright>
			<p>Copyright JEJUNOLE COMPANY Corp. All rights reserved.</p>
		</div>
	</div>
</div>
<!-- footer end -->
</body>
</html>