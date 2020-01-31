<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>동네한바퀴</title>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.4.1.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/css.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/animation.css" />
</head>

<body>
<header>
	<nav class="navbar navbar-expand-md navbar-light bg-light">
	  <a class="navbar-brand" href="#">동네한바퀴</a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	
	  <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">

	      <li class="nav-item dropdown">
	        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	          회원
	        </a>
	        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
	          <a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberEnroll.do">회원가입</a>
	          <a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
	          <a class="dropdown-item" href="${pageContext.request.contextPath}/member/findPassword.do">비밀번호 찾기</a>
	          <a class="dropdown-item" href="${pageContext.request.contextPath}/member/findId.do">아이디 찾기</a>
	          <a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberView.do">내 정보</a>
	          <a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberBye.do">회원 탈퇴</a>
	        </div>
	      </li>

	    </ul>
	  </div>
	</nav>
</header>
<section>
	<div class="container" id="section">
	
	
	
	
	