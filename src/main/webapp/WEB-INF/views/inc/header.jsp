<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

    <link href="<c:url value="/css/main.css"/>" rel="stylesheet"/>
</head>
<body>
<div class="container">
    <div class="gnb_header_top">
        <div class="top_box_menu">
            <ul class="top_member_box">
                <li>
                    <c:if test="${sessionScope.loginDTO.id==null}">
                    <a href="<c:url value="/member/login.do"/>">로그인</a><span class="txt_bar"></span>
                    </c:if>
                <li><a href="<c:url value="/member/memberRegister.do"/>">회원가입</a><span class="txt_bar"></span></li>
                <c:if test="${sessionScope.loginDTO.id !=null}">
                    <a href="<c:url value="/member/myProfile.do"/>">마이페이지</a><span class="txt_bar"></span>
                    <a href="javascript:logout()">로그아웃</a><span class="txt_bar"></span>
                </c:if>
                </li>

                <li><a href="<c:url value="/board/list.do"/>">고객센터</a></li>
            </ul>
        </div>
        <%--상단 오른쪽 마이페이지,고객센터 등 end--%>
    </div> <%--gnb_header_top--%>

    <div class="header_top">
        <div class="h1_logo">
            <%--a href=클릭시 이동하는 경로--%>
            <a href="<c:url value="/"/>">
                <%--이미지 파일 경로--%>
                <img src="<c:url value="/imgs/logo.png"/>" alt="상단로고" title="상단로고">
            </a>
        </div>

        <div class="d-flex justify-content-center">
            <input type="text" id="keyWord" name="keyWord" placeholder="검색어 입력"
                   style="width:300px" class="form-control rounded-0 rounded-start" value=""/>
            <button class="btn rounded-0 rounded-end" style="background:#138499; color:white"><i
                    class="fa fa-search"></i>
            </button>
        </div>

		<div class="gnb_category_right">
			<ul>
				<li><a href="#"><img src="/imgs/"></a></li>
				<li><a href="#"><img src="/imgs/"></a></li>
				<li class="category_cart"><a href="#"><img src="/imgs/"></a>
					<p>0</p>
				</li>
			</ul>
		</div>

    </div> <%--header_top--%>
</div>  <%--header container--%>


<nav class="navbar navbar-expand-sm sticky-top">
    <div class="container">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/"/>">전체카테고리</a>
            </li>
            <li class="nav-item">
                <%--href: 클릭시 이동하는 페이지--%>
                <a class="nav-link" href="#">기획전</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/member/memberList.do"/>">타임세일</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="#"/>">베스트</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="">신상품</a>
            </li>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="">이벤트</a>
            </li>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="">WithGlasslock</a>
            </li>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="">멤버십</a>
            </li>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="">대량주문</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<c:url value="/admin/adminLogin.do"/>">관리자페이지</a>
            </li>
        </ul>
    </div>
</nav>

<script>
    function logout() {
        location.href = "<c:url value="/member/logout.do"/>"
    }
</script>


