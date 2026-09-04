<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css?v=2">
</head>

<body>

	
	<div class="login-container">
		<a href="${pageContext.request.contextPath}/main">
	    <img src="${pageContext.request.contextPath}/resources/image/teamLogo.png" alt="5ASIS 로고" class="site-logo">
		</a>
		
	    <h1 class="page-title">로그인</h1>
		<form id="loginForm" action="${pageContext.request.contextPath}/user/login" method="POST">
	    
	        <div class="form-group">
            	<label class="form-label" for="email">이메일</label>
				<!-- (수정) 방금 친 이메일이(typedEmail)이 있으면 그거 우선, 없으면 쿠키(rememberEmail) 표시 -->
	            <input class="form-input" type="text" id="email" name="email" value="${not empty typedEmail ? typedEmail : rememberEmail}" 
	            			placeholder="이메일 입력" required>
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
				<!-- 쿠키가 있으면 체크박스도 체크 상태로 유지 -->
				<input type="checkbox" id="rememberId" name="rememberId" value="Y" ${not empty rememberEmail ? 'checked' : ''}>아이디 기억</label>
	        </div>
	        
	        <div class="login-btn">
	            <button type="submit" class="btn btn-submit">로그인</button>
	        </div>
	        
	        <div class="find-area">
	        	<a class="click-label" href="javascript:void(0);" onclick="openFindPwModal()">비밀번호 찾기</a>
	        </div>
	    </form>
	</div>
	
	
	<!-- 비밀번호 찾기 모달 팝업 레이어 -->
	<div id="findPwModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; 
	background: rgba(0,0,0,0.5); justify-content: center; align-items: center; z-index: 999;">
		<div style="background: white; width: 280px; padding: 25px; border-radius: 10px; display: flex; flex-direction: column; 
		box-shadow: 0 4px 20px rgba(0,0,0,0.15);">
			<h3 style="margin: 0 0 10px 0; font-size: 18px; font-weight: bold;">비밀번호 찾기</h3>
			<p style="font-size: 12px; color: #666; margin: 0 0 10px 0;">가입하신 이메일 주소를 입력해 주세요.</p>
			
			<div style="display: flex; gap: 6px; margin-bottom: 12px; align-items:center;">
				<input type="text" id="findPwEmail" placeholder="이메일 입력" style="flex: 1; height: 32px; box-sizing: border-box; padding: 0 10px; 
				font-size: 13px; border: 1px solid #ccc; border-radius: 5px; outline: none;">
				<button type="button" class="btn btn-submit" style="width: 65px; height: 32px; border-radius: 5px;" onclick="searchPassword()">찾기</button>
			</div>
			
			<!-- 결과 출력영역 -->
			<div id="findPwResult" style="font-size: 13px; margin: 5px 0 15px 0; min-height: 20px; line-height: 1.4;"></div>
			<button type="button" class="btn" style="width: 100%; height: 32px; background-color: #f0f0f0; color: #555; 
			border: 1px solid #ddd; border-radius: 5px;" onclick="closeFindPwModal()">닫기</button>
		</div>
	</div>
	
	<div class="signup-area">
		<span class="check-label">아직 회원이 아니신가요?</span>
		<a class="click-label" href="${pageContext.request.contextPath}/user/signup">회원가입</a>	
	</div>
	
	<script>const contextPath = "${pageContext.request.contextPath}";</script>
	<!-- 모든 컴퓨터에서 캐시가 자동 갱신됨 -->
	<script src="${pageContext.request.contextPath}/resources/js/login.js?v=1.1"></script>
		
	</body>
</html>