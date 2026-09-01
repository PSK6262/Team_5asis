<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<style>

body {
		background-color: #f5f5f5;
		color: #333;
		min-height: 100vh;
		
		display: flex;
		justify-content: center;
		align-items: center;
		flex-direction: column;
}

.login-container {
		width: 260px;
		padding: 30px;
		
		background-color: white;
		border-radius: 8px;
		border: 2px solid transparent;
	    background:
	        linear-gradient(white, white) padding-box,
	        linear-gradient(
	            135deg,
	            #E0B85A 0%,
	            #C5A052 35%,
	            #4E8580 70%,
	            #2F7778 100%
	        ) border-box;
	
	    box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);	    
}

.page-title {
		font-size: 28px;
		font-weight: bold;
		margin-top: 0;
}

/* 로그인 버튼 */
.btn {
		height: 26px;
		border: none;
		border-radius: 5px;
		font-size: 13px;
		cursor: pointer;
}

.btn-submit {
		width: 75px;
		background-color: #333;
		color: white;
}

.btn-submit:hover {
		background: linear-gradient(135deg, #E0B85A, #2F7778);
		transform: translateY(2px);
}

.login-btn {
		text-align: center;
		margin-top: 15px;
}

/* 입력폼*/
.form-group {
		margin-bottom: 20px;
}

.form-label {
		display: block;
		margin-bottom: 4px;
		font-size: 16px;
}

.form-input {
		width: 97%;
		height: 22px;
}

/* 찾기 */
.find-area {
		text-align: center;
		margin-top: 12px;
}

/* 체크박스, 폰트 높낮이 조정 */
input[type="checkbox"] {
    	vertical-align: middle;
    	margin: 0 3px 0 0;
}

.check-label {
		font-size: 11px;
		vertical-align: middle;
}

/* 회원가입 경로 위 여백 */
.signup-area {
   		margin-top: 10px;
}

.click-label {
		font-size: 11px;		
}

</style>
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
	        <!-- 비밀번호 맞지않을 때 -->
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