<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
</head>

<body>

	<div class="login-container">
	    <h1 class="page-title">로그인</h1>
		<form id="loginForm" action="${pageContext.request.contextPath}/user/login" method="POST">
	    
	        <div class="form-group">
            	<label class="form-label" for="email">이메일</label>
	            <input class="form-input" type="text" id="email" name="email" placeholder="이메일 입력" required>
	        </div>
	        
	        <div class="form-group">
            	<label class="form-label" for="password">비밀번호</label>
	            <input class="form-input" type="password" id="password" name="password" placeholder="비밀번호 입력" required>
	        <!-- 회원정보 일치하지 않을 때 -->
	        <p class="login-error-msg" style="color: red; font-size:13px; margin: 8px 0 0 0; text-align: left;">
	        	${loginError}
	        </p>
	        </div>
	        
	        <div>
	        <label class="check-label" for="rememberId">
				<input type="checkbox" id="rememberId" name="rememberId" value="Y">아이디 기억</label>
	        </div>
	        
	        <div class="login-btn">
	            <button type="submit" class="btn btn-submit">로그인</button>
	        </div>
	        
<!-- 	        경로 추가해야 함 -->
	        <div class="find-area">
	        	<a class="click-label" href="#none">아이디/비밀번호 찾기</a>
	        </div>
	    </form>
	</div>
	
	<div class="signup-area">
		<span class="check-label">아직 회원이 아니신가요?</span>
		<a class="click-label" href="${pageContext.request.contextPath}/user/signup">회원가입</a>	
	</div>
	
</body>
</html>