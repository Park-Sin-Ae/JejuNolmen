<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page isELIgnored="true" %>    
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>제주놀멘</title>
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
<script src="<%=request.getContextPath() %>/js/lodging.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/lodging/lodging.css">
<script>

mypath = '<%= request.getContextPath()%>';
	
$(function(){
	
	
	// 메인페이지에서 넘어 온 값 (일정 시작일, 일정 종료일, 검색값)
	let startDate = "<%=(String) request.getAttribute("mainStrHddn")%>";
	let endDate = "<%=(String) request.getAttribute("mainEndHddn")%>";
	let searchValue = "<%=(String) request.getAttribute("mainSearchHddn")%>";
	

	// 메인에서 넘어 온 값 가져와서 숙소리스트 출력 페이지 옆 검색창에 값 넣어주기
	$('#startDate').val(startDate);
	$('#endDate').val(endDate);
	$('#lodgingName').val(searchValue != 'null' ? searchValue : '');
	$('#guestNum').val(2);
	
	// 만약 날짜가 선택되지 않았다면(값이 없다면) 오늘 날짜와 내일 날짜로 넣어주기
    if ($('#startDate').val() === "" && $('#endDate').val() === ""){
	    let currentDate = new Date();
		$('#startDate').val(currentDate.toISOString().slice(0, 10));
		currentDate.setDate(currentDate.getDate() + 1);
		let tomorrow = currentDate.toISOString().slice(0, 10);
		$('#endDate').val(tomorrow);
    }
	
	// 숙소 리스트 출력 함수 // js파일 ajax도 같이 주석처리함
	// $.lodgingList(startDate, endDate, searchValue);   
	
	// 검색창에 넣은 값 꺼내오기
    let lodgingName = $('#lodgingName').val();
	let startDate2 = $('#startDate').val();
	let endDate2 = $('#endDate').val();
    let guestNum = $('#guestNum').val();
	let lodgingType = "전체";

	// 넘어온 값들 가지고 검색버튼 누르는 것 없이 리스트 출력 실행
	$.ajax({
			url : `${mypath}/lodgingList.do`,
			type : 'get',
			data : {
					"lodgingName"  :  lodgingName,
					"startDate"    :  startDate2,
					"endDate"      :  endDate2,
					"guestNum"     :  guestNum,
					"lodgingType"  :  lodgingType
			},
			success : function(result){
				code = "";
			
			$.each(result, function(i, v){
				
				code +=`<div class="lodging" id="lodgingBox">
						   <div class="lod-img">
						       <img src="${mypath}/lodgingImage.do?imgName=${v.l_img_path}" alt="${v.l_img_path}"/>
				           </div>		  
						   <div class="lod-info-container">
							   <div class="lod-list-info">
								   <p class="lod-list-lodCode" data-lod-code='${v.lod_code}' style="display : none;"> ${v.lod_code} <br>
								   <p class="lod-list-lodType"> ${v.lod_type} <br>
					               <a class="lod-list-lodName"> ${v.lod_nm} </a>
				                   <p class="lod-list-lodAddr"> ${v.lod_addr} <br>
						       </div>
							   <div class="lod-list-price">
								   <p> ${v.lowestRoomPrice}원<br>
							   </div>
						   </div>
					    </div> 
	                    <br><hr>`;
			}); // $.each문 끝
	
				$('#lodgingList').html(code);	
				
			},
			error : function(xhr){
				alert("상태 : " + xhr.status);
			},
			dataType : 'json'
		}); // ajax 끝
		   
		// 검색 버튼 실행 이벤트
		$('#searchBtn').on('click', function(){
			// 검색조건에 따른 숙소 리스트
			$.searchLodgingList();
		});
	
	// 숙소상품(div어디든) 클릭 이벤트 : 숙소 상세페이지 출력
	$(document).on('click', '#lodgingBox', function(){
		
		// 값 가져오기
		var lodCode = $(this).find(".lod-list-lodCode").data("lod-code");
		var lodName = $("#lodName").val();
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		var guestNum = $("#guestNum").val();
		var lodgingType = $("[name=lodgingType]:checked").val();
		
		// 값 저장하기
		$("#formCode").val(lodCode);
		$("#formName").val(lodName);
		$("#formStartDate").val(startDate);
		$("#formEndDate").val(endDate);
		$("#formGuestNum").val(guestNum);
		$("#lodgingType").val(lodgingType);
		
		// form태그 제출
		$('#lodgingBox-send').submit();
	});	
	
}); // 전체 펑션 끝

</script>
<style>
#searchForm, #lodgingList{
	vertical-align : top;
	margin-right : 20px; *//*요소 사이의 간격 조절*/
}
#searchForm input[type="text"],
#searchForm input[type="date"],
#searchForm input[type="number"]{
	margin-bottom : 10px;
}
#searchForm label{
	font-size : 0.9rem;
}
.resLodingJSP-all{
	display : flex;
	flex-direction: column;
}
/* .resLodingJSP-body{ */
/* 	display : flex; */
/* 	margin-left : 25%; */
/* } */
.lod-schedule{
/* 	margin-right: 3%; */
	/* border : 1px solid gray; */
}
.lod-list{
	/* border : 1px solid gray; */
}

</style>

</head>
<body>

<!-- 서블릿에 보낼 값 저장할 hidden form -->
<form id="lodgingBox-send" action="<%=request.getContextPath() %>/lodgingDetail.do" method="get">
  <input type="hidden" name="lod_code" id="formCode">
  <input type="hidden" name="lod_nm" id="formName">
  <input type="hidden" name="lod_start" id="formStartDate">
  <input type="hidden" name="lod_end" id="formEndDate">
  <input type="hidden" name="guestNum" id="formGuestNum">
  <input type="hidden" name="lodgingType" id="lodgingType">
</form>

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
        <a class="nav-link navTxt" href="<%=request.getContextPath()%>/notice/userNotice.jsp">이벤트</a>
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
	<div class = "row">
		<div class="col-3">
		<div class="side-left">
			<h6>일정</h6>
			<form id="searchForm">
			    <div>
			        <input class="form-control" type="text" placeholder="숙소이름/주소 입력" id="lodgingName" name="lod_nm">
			    </div>
			    <div>
			        <label for="startDate">숙박 시작일</label><br>
			        <input class="form-control" type="date" id="startDate" name="lod_start">
			    </div>
			    <div>
			        <label for="endDate">숙박 종료일</label><br>
			        <input class="form-control" type="date" id="endDate" name="lod_end">
			    </div>
			    <div>
			        <label for="guestNum">인원</label><br>
			        <input class="form-control" type="number" placeholder="2" id="guestNum" name="guestNum" min="1">
			    </div>
			    <br><hr><br>
			
			<h6 class="mb-3">숙소 유형</h6>
				<label>
				    <input type="radio" name="lodgingType" value="전체" checked> 전체
				</label><br>
				<label>
				    <input type="radio" name="lodgingType" value="모텔"> 모텔
				</label><br>
				<label>
				    <input type="radio" name="lodgingType" value="호텔/리조트"> 호텔/리조트
				</label><br>
				<label>
				    <input type="radio" name="lodgingType" value="펜션"> 펜션
				</label><br>
				<br>
				
				<input class="btn btn-outline-warning" type="button" id="searchBtn" value="검색">
			</form>
		</div>
		</div>
		
		<!-- 숙소 리스트 출력 부분 -->
		<div class="lod-list col-9">
			<div id="lodgingList" class="mt-5"></div>
			<nav aria-label="Page navigation example">
					  <ul class="pagination justify-content-center">
					    <li class="page-item disabled">
					      <a class="page-link">Previous</a>
					    </li>
					    <li class="page-item"><a class="page-link" href="#">1</a></li>
					    <li class="page-item"><a class="page-link" href="#">2</a></li>
					    <li class="page-item"><a class="page-link" href="#">3</a></li>
					    <li class="page-item">
					      <a class="page-link" href="#">Next</a>
					    </li>
					  </ul>
			</nav>
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