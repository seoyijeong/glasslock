<%@ page import="java.util.ArrayList"%>
<%@ page import="kr.ezen.bbs.domain.MemberDTO" %>
<%@ page import="kr.ezen.bbs.domain.CategoryDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/adminHeader.jsp" %>



<div class='container mt-3'>                                                                                
  <h2>카테고리 리스트</h2>
  <table class='table'>                                                                                     
    <thead class='table-dark'>                                                                              
      <tr>
		  <th>번호</th>
		  <th>코드</th>
		  <th>카테고리명</th>
		  <th>수정/삭제</th>
      </tr>                                                                                                 
    </thead>                                                                                                
    <tbody>

	<%--controller list--%>
<c:forEach var="cDto" items="${list}">
	<tr>
		<td>${cDto.catNum}</td>
		<td>${cDto.code}</td>
		<td>${cDto.catName}</td>
	<%--<td><input type="button" class='btn btn-danger btn-sm' value="삭제" onclick="delMember(${dto.no})"/></td>--%>
		<%--c:url 을 붙이는 이유: 브라우저에 세션쿠키를 붙여서 보낸다--%>
		<td>
		<a href="prodUpdate.do?pNum=${dto.pNum}" class="btn btn-sm btn-info">수정</a>
		<a href="<c:url value='/admin/categoryDelete.do?catNum=${cDto.catNum}'/>" class="btn btn-danger btn-sm">삭제</a></td>
	</tr>
</c:forEach>
	</tbody>
  </table>
</div>

<jsp:include page="../inc/footer.jsp"/>