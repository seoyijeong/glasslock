<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<c:set var="cnt" value="${cnt+1}" />
<!-- Card -->
<div class="card me-2" style="width: 200px">
  <a href="prodView.do?pnum=${dto.pnum}&pSpec=${dto.pspec}"
     style="height: 120px; overflow: hidden;"> <img
          class="card-img-top"
          src="<c:url value="/uploadedFile/${dto.pimage}"/>" alt="Card image"
          style="width: 100%;">
  </a>
  <div class="card-body">
    <h4 class="card-title" style="font-size: 15px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">
      <b>${dto.pname}</b>
    </h4>
    <p class="card-text">
      가격 :
      <fmt:formatNumber value="${dto.price}" />
    </p>
    <p class="card-text">
      포인트 :
      <fmt:formatNumber value="${dto.ppoint}" />
    </p>
    <!-- 로그인 되었을 경우 -->
    <c:if test="${sessionScope.isLogin != null }">
      <a href="cartAdd.do?pnum=${dto.pnum}&pQty=1&pSpec=${dto.pspec}" class="btn btn-primary" style="width: 100%">장바구니 담기</a>
    </c:if>

    <!-- 로그인 안되었을 경우 -->
    <c:if test="${sessionScope.isLogin == null }">
      <a href="javascript:alert('로그인이 필요합니다')" class="btn btn-primary" style="width: 100%">장바구니 담기</a>
    </c:if>

  </div>
</div>
<!-- Card End -->
<c:if test="${cnt%4 ==0}">
  </div><div class="d-flex mt-3">
</c:if>