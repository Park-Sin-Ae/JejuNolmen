<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%
  	int res = (Integer)request.getAttribute("cnt");
   
   	if(res>0){
   	%>	
   	{
   		"flag" : "저장성공"
   	}
   	
   	<% }else{ %>
   	{
   		"flag" : "저장실패"
   	}
   	
   	<%	
   	 }
   	%>
