<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#carResPaymentBtn').on('click',function(){
			location.href="<%= request.getContextPath()%>/main.jsp";
				
		});
	})

</script>

</head>
<body>

<input id="carResPaymentBtn" type="button" value="확인">
</body>
</html>