<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../inc/header.jsp" %>

<div class="container w-50 mt-5 p-5 shadow">
    
   <form action="<c:url value="register.do"/>" method="post">
      <%--cntPerPage :뒤로가기 버튼으로 현재 페이지 전에 보고 있던 페이지로 넘어가기 위해--%>
      <input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}"/>
      <h4>글쓰기</h4>            
         
      <input class="form-control" type="text" id="subject" name="subject" placeholder="글제목을 입력하세요" autofocus>      
      
      <textarea class="form-control mt-2" name="contents" id="contents" placeholder="내용을 입력하세요"></textarea>
      
      <input class="form-control mt-2" type="text" id="writer" name="writer" placeholder="이름을 입력하세요">
      
      <div class="text-center mt-3">
         <button class="btn btn-primary">등록</button>   
      </div>
   </form>
</div>
<jsp:include page="../inc/footer.jsp"/>