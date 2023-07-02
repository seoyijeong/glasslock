<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="inc/header.jsp"/>

<!-- Carousel -->
<div id="demo" class="carousel slide" data-bs-ride="carousel">

	<!-- Indicators/dots -->
	<div class="carousel-indicators">
		<button type="button" data-bs-target="#demo" data-bs-slide-to="0" class="active"></button>
		<button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
		<button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
		<button type="button" data-bs-target="#demo" data-bs-slide-to="3"></button>
		<button type="button" data-bs-target="#demo" data-bs-slide-to="4"></button>
	</div>

	<!-- The slideshow/carousel -->
	<div class="carousel-inner">
		<div class="carousel-item active" data-bs-interval="1000">
			<img src="imgs/1.jpg" alt=".." class="d-block w-100">
		</div>
		<div class="carousel-item">
			<img src="imgs/2.jpg" alt=".." class="d-block w-100">
		</div>
		<div class="carousel-item">
			<img src="imgs/3.jpg" alt=".." class="d-block w-100">
		</div>
		<div class="carousel-item">
			<img src="imgs/4.jpg" alt=".." class="d-block w-100">
		</div>
		<div class="carousel-item">
			<img src="imgs/5.jpg" alt=".." class="d-block w-100">
		</div>

	</div>
	<!-- The slideshow/carousel end-->

	<div class="main_content" >
		<div class="main_todaysale">
			<h1>머뭇거릴 시간이 없어요</h1>
			<p>오직 오늘만 누릴수 있는 세일 특가!</p>

			<%--카운트다운--%>
			<h2 id="remain-time"></h2>
			<script src="js/app.js"></script>
		</div>
		<%--카운트 다운 end--%>

		<div class="container">

		</div>


		<!-- Left and right controls/icons -->
		<button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
			<span class="carousel-control-prev-icon"></span>
		</button>
		<button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
			<span class="carousel-control-next-icon"></span>
		</button>
	</div>


<jsp:include page="inc/footer.jsp"/>