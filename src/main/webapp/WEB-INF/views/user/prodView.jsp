<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<section class="w-75 ps-5">
  <h3>상품 정보[${requestScope.specValue}]</h3>
  <ul class="d-flex p-0" style="list-style:none;">
    <!-- 상품 이미지 -->
    <li class="me-5">
      <img src="<c:url value="/uploadedFile/${requestScope.dto.pimage}"/>" width="220px"/>
    </li>
    <!-- 상품 상세내용 -->
    <li>
      <form name="prodForm" method="post">
        상품번호 : ${requestScope.pnum}<br/>
        상품이름 : ${requestScope.dto.pname}<br/>
        상품가격 : <fmt:formatNumber value="${requestScope.dto.price}"/><br/>
        상품포인트 :<fmt:formatNumber value="${requestScope.dto.ppoint}"/><br/>
        상품수량 : <input type="text" name="pQty" size="3" value="1"/>개<br/>
        <p class="mt-3"><b>[상품 소개]</b><br/>
          ${requestScope.dto.pcontent}
        </p>
        <c:if test="${sessionScope.isLogin != null}">
          <a href="javascript:goCart(${requestScope.pnum})" class="btn btn-sm btn-primary">장바구니 담기</a>
        </c:if>

        <c:if test="${sessionScope.isLogin == null }">
          <a href="javascript:alert('로그인이 필요합니다')" class="btn btn-sm btn-primary">장바구니 담기</a>
        </c:if>

        <!-- 				<a href="javascript:history.back();" class="btn btn-sm btn-info">계속 쇼핑하기</a> -->
        <a href="<c:url value="/"/>" class="btn btn-sm btn-info">계속 쇼핑하기</a>
      </form>
    </li>
  </ul>
</section>
<script>
  function goCart(pNum){
    document.prodForm.action="cartAdd.do?pNum="+pNum;
    document.prodForm.submit();
  }
</script>