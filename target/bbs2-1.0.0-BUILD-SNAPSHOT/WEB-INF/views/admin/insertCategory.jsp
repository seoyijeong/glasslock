<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../inc/header.jsp" %>

<div class="container w-50 mt-5 p-5 shadow">
    
   <form action="<c:url value="insertRegister.do"/>" method="post">
      <input type="hidden" name="cntPerPage" value="${pDto.cntPerPage}"/>
      <h4>카테고리 등록</h4>
      <label for="code">카테고리 코드</label>
      <input class="form-control" type="text" id="code" name="code" placeholder="코드를 입력하세요" autofocus>

      <label for="catName">카테고리 명</label>
      <input class="form-control mt-2" type="text" id="catName" name="catName" placeholder="카테고리명을 입력하세요">
      
      <div class="text-center mt-3">
         <button class="btn btn-primary">등록</button>   
      </div>
   </form>
</div>
<jsp:include page="../inc/footer.jsp"/>