<%@ page import="java.util.ArrayList"%>
<%@ page import="kr.ezen.bbs.domain.MemberDTO" %>
<%@ page import="kr.ezen.bbs.domain.CategoryDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../inc/adminHeader.jsp" %>

<style>
	td{vertical-align:middle;}
</style>


<c:if test="${requestScope.msg !=null}">
	<script>
		alert("${requestScope.msg}");
	</script>
</c:if>



<div class="container w-75 mt-5">
	<h3>상품 리스트</h3>
	<table class="table">
		<thead>
		<tr>
			<th>번호</th>
			<th>카테고리 코드</th>
			<th>이미지</th>
			<th>상품명</th>
			<th>가격</th>
			<th>제조사</th>
			<th>수량</th>
			<th>수정/삭제</th>
		</tr>
		</thead>
		<tbody>
		<c:if test="${list==null || list.size() ==0}">
			<tr>
				<td colspan="8">상품이 존재하지 않습니다!!</td>
			</tr>
		</c:if>
		<c:if test="${list!=null || list.size() !=0}">
			<c:forEach var="dto" items="${list}">
				<tr>
					<%--이전에는 getter와 setter를 직접 만들었지만, rombok이 자동으로 생성--%>
					<%--getter를 만들때 getpnum으로 대문자로 생성해 주었기 때문에 롬복이 첫글자를 대문자로 만들어줌--%>
					<%--대문자로 바뀌어 출력됨--%>

					<td>${dto.pnum}</td>
					<td>${dto.pcategory_fk}</td>
					<td>
							<%-- 						<img src="<%=request.getContextPath() %>/uploadedFile/${dto.pimage}" style="width:60px"/> --%>
							<%--<c:url />은 context경로를 자동으로 붙여줌 --%>
						<img src="<c:url value="/uploadedFile/${dto.pimage}"/>" style="width:60px"/>
					</td>
						<td>${dto.pname}</td>
						<td>${dto.price}</td>
						<td>${dto.pcompany}</td>
						<td>${dto.pqty}</td>
					<td>
						<a href="prodUpdate.do?pnum=${dto.pnum}" class="btn btn-sm btn-info">수정</a>
						<a href="javascript:pdDel('${dto.pnum}', '${dto.pimage}')" class="btn btn-sm btn-danger">삭제</a>
					</td>
				</tr>
			</c:forEach>
		</c:if>
		</tbody>
	</table>
</div>
<script>
	function pdDel(pnum, pimage){
		let isDel = confirm("삭제 하시겠습니까?");
		if(isDel) location.href="prodDelete.do?pnum="+pnum+"&pimage="+pimage;
	}
</script>


<jsp:include page="../inc/footer.jsp"/>