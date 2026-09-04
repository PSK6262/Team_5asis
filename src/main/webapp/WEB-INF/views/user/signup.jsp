<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/signup.css?v=2">
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
				<div id="pwFormatMsg" style="font-size: 11px; color: #888; margin-top: 4px;">문자, 숫자, 특수문자 포함 8~20자</div>
			</div>
			
			<div class="form-group">
				<label class="form-label" for="passwordConfirm">비밀번호 확인</label> 
				<input class="form-input" type="password" id="passwordConfirm" name="passwordConfirm"
						placeholder="비밀번호 재입력" required>
				<!-- 가입시 비밀번호 일치 여부 -->
				<div id="pwMsg" style="font-size:13px; margin-top: 5px;"></div>				
			</div>
			
			<div class="form-group">
				<label class="form-label" for="nickname">닉네임</label>
				<input class="form-input" type="text" id="nickname" name="nickname" placeholder="닉네임 입력" required>
			</div>
			
			<div class="agree-item">
                <input type="checkbox" id="termsService" name="agreeTerms" value="Y" required>
                <label class="check-label" for="termsService">[필수] 이용약관 동의</label>                
                <a href="javascript:void(0);" class="click-label" onclick="openTerms('service')">전체보기</a>

            </div>
            <div class="agree-item">
                <input type="checkbox" id="termsPrivacy" name="agreePrivacy" value="Y" required>
                <label class="check-label" for="termsPrivacy">[필수] 개인정보 수집 및 이용 동의</label>
                <a href="javascript:void(0);" class="click-label" onclick="openTerms('privacy')">전체보기</a>
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
	
	
	<!-- 약관 모달 팝업 레이어 -->
	<div id="termsModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); justify-content: center; align-items: center; z-index: 999;">
	    <div style="background: white; width: 320px; padding: 20px; border-radius: 8px; max-height: 400px; display: flex; flex-direction: column;">
	        <h3 id="modalTitle" style="margin-top: 0;">약관 안내</h3>
	        <div id="modalContent" style="flex: 1; overflow-y: auto; font-size: 12px; color: #666; border: 1px solid #eee; padding: 10px; margin-bottom: 15px; white-space: pre-line; line-height: 1.5;"></div>
	        <button type="button" class="btn btn-submit" style="width: 100%;" onclick="closeTermsModal()">확인</button>
	    </div>
	</div>
	
	<script>const contextPath = "${pageContext.request.contextPath}";</script>
	<script src="${pageContext.request.contextPath}/resources/js/signup.js"></script>
</body>
</html>