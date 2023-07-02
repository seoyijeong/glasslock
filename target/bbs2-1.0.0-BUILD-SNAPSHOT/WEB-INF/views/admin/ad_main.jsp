<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ include file="../inc/adminHeader.jsp" %>
<div class="container w-50 shadow rounded border p-5 mt-5">
    <%--form 태그는 submit을 하면 action으로 이동!--%>
<%--    <form action="<c:url value="/admin/ad_main.do"/>" method="post">--%>
        <div class="container">
            <h2>관리자 페이지</h2>
            <ul>
                <li><a href="">쇼핑몰 카테고리 등록</a></li>
                <li><a href="">쇼핑몰 카테고리 리스트</a></li>
                <li><a href="">쇼핑몰 상품 등록</a></li>
                <li><a href="">쇼핑몰 상품 리스트</a></li>
            </ul>
        </div>
<%--    </form>--%>

<jsp:include page="../inc/footer.jsp" />