<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../inc/adminHeader.jsp" %>

<div class="container mt-5">

<h3>고객센터</h3>
   <div>
      <form id="searchForm" method="post" action="list.do">
         <div class="d-flex justify-content-center">
            <select class="form-select me-2" style="width:200px" name="searchType">
               <option value="">선택</option>
               <option value="S" ${pDto.searchType == 'S' ? 'selected':''}>제목</option>
               <option value="C" ${pDto.searchType == 'C' ? 'selected':''}>내용</option>
               <option value="W" ${pDto.searchType == 'W' ? 'selected':''}>글쓴이</option>
               <option value="SC" ${pDto.searchType == 'SC' ? 'selected':''}>제목+내용</option>
               <option value="SW" ${pDto.searchType == 'SW' ? 'selected':''}>제목+글쓴이</option>
               <option value="SCW" ${pDto.searchType == 'SCW' ? 'selected':''}>제목+내용+글쓴이</option>
            </select>
            <input type="text" id="keyWord" name="keyWord" placeholder="검색어 입력"
                   style="width:300px" class="form-control rounded-0 rounded-start" value="${pDto.keyWord}"/>
            <button class="btn rounded-0 rounded-end" style="background:#138499; color:white"><i class="fa fa-search"></i></button>
         </div>
      </form>
   </div>

<div class="my-3 d-flex justify-content-between">
   <div><b>${pDto.viewPage}</b> / ${pDto.totalPage} pages</div>


   <%-- 검색이 없을 경우 --%>
   <c:if test="${pDto.searchType == null || pDto.searchType ==''}">
   <div>
      <select class="form-select form-select-sm" id="cntPerPage">
         <option value="5" ${pDto.cntPerPage == 5 ? 'selected':''}>게시글 5개</option>
         <option value="10" ${pDto.cntPerPage == 10 ? 'selected':''}>게시글 10개</option>
         <option value="20" ${pDto.cntPerPage == 20 ? 'selected':''}>게시글 20개</option>
      </select>
   </div>
   </c:if>

   <%-- 검색이 있을 경우 --%>
   <c:if test="${pDto.searchType != null && pDto.searchType !=''}">
      <div>
         <select class="form-select form-select-sm" id="cntPerPage">
            <c:choose>
               <c:when test="${pDto.totalCnt <=5}">
                  <option value="5" ${pDto.cntPerPage == 5 ? 'selected':''}>선택없음</option>
               </c:when>

               <c:when test="${pDto.totalCnt > 5 && pDto.totalCnt < 10}">
                  <option value="5" ${pDto.cntPerPage == 5 ? 'selected':''}>게시글 5개</option>
                  <option value="10" ${pDto.cntPerPage == 10 ? 'selected':''}>게시글 10개</option>
               </c:when>

               <c:when test="${pDto.totalCnt >= 10 && pDto.totalCnt < 20}">
                  <option value="5" ${pDto.cntPerPage == 5 ? 'selected':''}>게시글 5개</option>
                  <option value="10" ${pDto.cntPerPage == 10 ? 'selected':''}>게시글 10개</option>
               </c:when>

               <c:otherwise>
                  <option value="5" ${pDto.cntPerPage == 5 ? 'selected':''}>게시글 5개</option>
                  <option value="10" ${pDto.cntPerPage == 10 ? 'selected':''}>게시글 10개</option>
                  <option value="20" ${pDto.cntPerPage == 20 ? 'selected':''}>게시글 20개</option>
               </c:otherwise>

            </c:choose>
         </select>
      </div>
   </c:if>




</div>
<table class="table">
   <thead class="table-dark">
      <tr>
         <th>번호</th>
         <th>제목</th>
         <th>조회수</th>
         <th>글쓴이</th>
         <th>등록일</th>
      </tr>
   </thead>
   <%-- XSS(cross-site Scripting 공격 : 웹사이트에 스크립트 코드를 주입시켜서 공격하는
      해킹 기법,
      JSP의 <c:out />는 입력된 태그를 해석하지 못하도록 문자로 변환하여 공격을 방어함.
   --%>
   <tbody>
      <c:set var="rowNum" value="${pDto.startRowNum}"/>
      <c:forEach var="dto" items="${list}">
      <tr>

<%--     <td>${dto.bid}</td>--%>
         <td>${rowNum}</td>
         <td><a href="<c:url value="/board/view.do?bid=${dto.bid}&viewPage=${pDto.viewPage}&cntPerPage=${pDto.cntPerPage}&searchType=${pDto.searchType}&keyWord=${pDto.keyWord}"/>"><c:out value="${dto.subject}"/></a></td>
         <td>${dto.hit}</td>
         <td><c:out value="${dto.writer}"/></td>
         <td>${dto.reg_date}</td>
      </tr>
         <c:set var="rowNum" value="${rowNum - 1}"/>
      </c:forEach>
      <tr>
         <td colspan="5" class="text-center">
            <button class="btn btn-primary" id="btn-write">글쓰기</button>
         </td>
      </tr>
   </tbody>
</table>
<ul class="pagination justify-content-center my-5">
  <li class="page-item ${pDto.prevPage <=0 ? 'disabled':''}">
  	<a class="page-link" href="list.do?viewPage=${pDto.prevPage}&cntPerPage=${pDto.cntPerPage}">이전</a>
  </li>

  <c:forEach var="i" begin="${pDto.blockStart}" end="${pDto.blockEnd}">
  	<li class="page-item ${pDto.viewPage == i ? 'active':''}">
  		<a class="page-link" href="list.do?viewPage=${i}&cntPerPage=${pDto.cntPerPage}&searchType=${pDto.searchType}&keyWord=${pDto.keyWord}">${i}</a>
  	</li>
  </c:forEach>

  <li class="page-item ${pDto.blockEnd >=pDto.totalPage ? 'disabled':''}">
  	<a class="page-link" href="list.do?viewPage=${pDto.nextPage}&cntPerPage=${pDto.cntPerPage}">다음</a>
  </li>
</ul>
<script>
	$(document).ready(function(){
		$("#btn-write").click(()=>{
			location.href="<c:url value='register.do?cntPerPage=${pDto.cntPerPage}'/>";
		})
	});

    $("#cntPerPage").change(function () {
       let cntVal = $("#cntPerPage option:selected").val();
       alert(cntVal);
       <%--location.href = "<c:url value='list.do?viewPage=${pDto.viewPage}&cntPerPage='/>"+cntVal;--%>
       location.href = "<c:url value='list.do?viewPage=1&searchType=${pDto.searchType}&keyWord=${pDto.keyWord}&cntPerPage='/>"+cntVal;
    });
</script>
<jsp:include page="../inc/footer.jsp"/>