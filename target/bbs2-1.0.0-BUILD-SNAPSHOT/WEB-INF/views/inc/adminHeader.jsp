<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

  <link  href="<c:url value="/css/main.css"/>" rel="stylesheet"/>
</head>
<body>

<%--<div class="top_box_menu">
	<ul class="top_member_box" >
		<li>
			<c:if test="${sessionScope.loginDTO.id==null}">
				<a class="" href="<c:url value="/member/login.do"/>">로그인</a> |
			</c:if>
			&lt;%&ndash;사용자 정보를 세션에 저장&ndash;%&gt;
			<c:if test="${sessionScope.loginDTO.id !=null}">
				<a class="me-3 myProfile" type="button" href="<c:url value="/member/myProfile.do"/>">
						&lt;%&ndash;로그인한 사용자 이름&ndash;%&gt;
					마이페이지</a> |
				<a class="" href="javascript:logout()">로그아웃</a> |
			</c:if>
		</li>
		<li>
			<c:if test="${sessionScope.loginDTO.id ==null}">
			<a class="" href="memberRegister.do"> 회원가입</a> |
			</c:if>
		</li>
		<li><a href="#"> 고객센터</a></li>
	</ul>
</div>--%>




<div class="header_top">
	<div class="h1_logo">
		<%--a href=클릭시 이동하는 경로--%>
			<a href="<c:url value="/"/>">
				<%--이미지 파일 경로--%>
				<img src="<c:url value="/imgs/logo.png"/>" alt="상단로고" title="상단로고">
			</a>
	  </a>
	</div>

	<div class="d-flex justify-content-center">
	<input type="text" id="keyWord" name="keyWord" placeholder="검색어 입력"
		   style="width:300px" class="form-control rounded-0 rounded-start" value=""/>
	<button class="btn rounded-0 rounded-end" style="background:#138499; color:white"><i class="fa fa-search"></i></button>
	</div>
	</div>

	<nav class="navbar navbar-expand-sm sticky-top">
	  <div class="container">
	  	<ul class="navbar-nav">
	  		<li class="nav-item">
			    <a class="nav-link" href="<c:url value="/"/>">전체카테고리</a>
	  		</li>
	  		<li class="nav-item">
			    <a class="nav-link" href="<c:url value="/admin/insertCategory.do"/>">카테고리등록</a>
	  		</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/listCategory.do"/>">카테고리 리스트</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/prodInput.do"/>">상품등록</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/productList.do"/>">상품리스트</a>
			</li>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/member/memberList.do"/>">회원리스트</a>
			</li>
			</li>

			<li class="nav-item">
				<a class="nav-link" href="<c:url value="/admin/adminLogin.do"/>">관리자페이지</a>
			</li>
	  	</ul>
	  </div>
	</nav>

	<%--<script>
		function logout(){
			location.href="<c:url value="/member/logout.do"/>"
		}
	</script>--%>


