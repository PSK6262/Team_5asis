<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>

	<div class="signup-container">
		<h2>회원가입</h2>
		<form id="signupForm"
			action="${pageContext.request.contextPath}/user/signup" method="POST">

			<div>
				<label for="email">이메일</label> <input type="text" id="email"
					name="email" placeholder="이메일 입력" required>
				<button type="button" id="btnCheckId">중복확인</button>
			</div>

			<div>
				<label for="password">비밀번호</label> <input type="password"
					id="password" name="password" placeholder="비밀번호 입력" required>
			</div>

			<div>
				<label for="passwordConfirm">비밀번호 확인</label> <input type="password"
					id="passwordConfirm" name="passwordConfirm" placeholder="비밀번호 재입력"
					required>
			</div>

			<div>
				<label for="nickname">닉네임</label> <input type="text" id="nickname"
					name="nickname" placeholder="닉네임 입력" required>
			</div>
			
			<div>
				<button type="submit" id="btnSignup">가입하기</button>
			</div>
			
			
		</form>
	</div>



</body>
</html>