<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

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

.signup-container {
		width: 260px;
		padding: 30px;
		
		background-color: white;
		border-radius: 8px;
		border: 2px solid transparent;
	    background:
	        linear-gradient(white, white) padding-box,
	        linear-gradient(
	            135deg,
	            #2F7778 0%,
	            #4E8580 35%,
	            #C5A052 70%,
	            #E0B85A 100%
	        ) border-box;
	
	    box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);	    
}

.page-title {
		font-size: 28px;
		font-weight: bold;
		margin-top: 0;
}

/* 버튼 */
.btn {
		height: 26px;
		border: none;
		border-radius: 5px;
		font-size: 13px;
		cursor: pointer;
}

.btn-check, .btn-submit {
		width: 75px;
		background-color: #333;
		color: white;
}

.btn-check:hover {
		background: darkgray;
}

.btn-submit:hover {
		background: linear-gradient(135deg, #2F7778, #E0B85A);
		transform: translateY(2px);
}


/* 중복체크 버튼 정렬 */
.id-check {
	    display: flex;
    	gap: 5px;
}

.id-check .form-input {
   		flex: 1;
   	 	width: auto;
}

.signup-btn {
		text-align: center;
		margin-top: 15px;
}

/* 입력폼 */
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

/* 체크박스, 폰트 높낮이 조정 */
.agree-item {
		display: flex;
		align-items: center;
		margin-bottom: 3px;
}

.agree-item input[type="checkbox"] {
    	margin: 0 3px 0 0;
}

.check-label {
    font-size: 11px;
}

.click-label {
    font-size: 11px;
}

.agree-item .check-label {
    margin-right: 3px;
}


/* 컨테이너 사이 여백 */
.login-area {
    	margin-top: 10px;
}

</style>

</head>


<body>

	<div class="signup-container">
		<h1 class="page-title">회원가입</h1>
		<form id="signupForm" action="${pageContext.request.contextPath}/user/signup" method="POST">

			<div class="form-group">
    			<label class="form-label" for="email">이메일</label>

    				<div class="id-check">
        				<input class="form-input" type="text" id="email" name="email" placeholder="이메일 입력" required>
        				<button type="button" class="btn btn-check" id="btnCheckId" onclick="checkDuplicate()">중복체크</button>
			    	</div>
				<!-- 중복체크 글씨출력 -->
			    	<div id="msgBox" style="font-size: 13px; margin-top: 5px; font-weight: bold;"></div>
			</div>
			
			<div class="form-group">
				<label class="form-label" for="password">비밀번호</label>
				<input class="form-input" type="password" id="password" name="password" placeholder="비밀번호 입력" required>
				<br><small>문자, 숫자, 특수문자 포함 8~20자</small>
			</div>
			
			<div class="form-group">
				<label class="form-label" for="passwordConfirm">비밀번호 확인</label> 
				<input class="form-input" type="password" id="passwordConfirm" name="passwordConfirm"
						placeholder="비밀번호 재입력" required>
			</div>
			
			<div class="form-group">
				<label class="form-label" for="nickname">닉네임</label>
				<input class="form-input" type="text" id="nickname" name="nickname" placeholder="닉네임 입력" required>
			</div>
			
			<div class="agree-item">
                <input type="checkbox" id="termsService" name="agreeTerms" value="Y" required>
                <label class="check-label" for="termsService">[필수] 이용약관 동의</label>
                <a href="#none" class="click-label">전체보기</a>
            </div>
            <div class="agree-item">
                <input type="checkbox" id="termsPrivacy" name="agreePrivacy" value="Y" required>
                <label class="check-label" for="termsPrivacy">[필수] 개인정보 수집 및 이용 동의</label>
                <a href="#none" class="click-label">전체보기</a>
            </div>
			<div class="signup-btn">
				<button type="submit" class="btn btn-submit" id="btnSignup">가입하기</button>
			</div>
		</form>
	</div>
		
	<div class="login-area">
       	<span class="check-label">이미 계정이 있으신가요?</span>
       	<a class="click-label" href="${pageContext.request.contextPath}/user/login">로그인</a>
    </div>
			
	
	<!-- 백엔드통신 스크립트 -->
	<script>
		function checkDuplicate(){
			var email = document.getElementById("email").value;
			
			if (email == ""){
				alert("이메일을 먼저 입력해주세요!");
				return;
			}
			
			fetch("${pageContext.request.contextPath}/user/checkEmail", {
				method: "POST",
				headers: { "Content-Type": "application/x-www-form-urlencoded"},
				body: "email=" + email
			})
			.then(response => response.text())
			.then(result => {
				var msg = document.getElementById("msgBox");
				
				if (result == "1"){
					msg.innerText = "이미 사용 중인 이메일입니다.";
					msg.style.color = "red"
				} else {
					msg.innerText = "사용 가능한 이메일입니다.";
					msg.style.color = "green";
				}
			
			});
			
		}
	</script>
	
</body>
</html>