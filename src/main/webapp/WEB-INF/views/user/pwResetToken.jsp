<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 재설정</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pwResetToken.css">
</head>
<body>

<div class="reset-container">
    <h2>비밀번호 재설정</h2>
    
    <!-- 컨트롤러 매핑 주소인 /reset 으로 설정 -->
    <form action="${pageContext.request.contextPath}/user/reset" method="POST" onsubmit="return validateForm()">
        
        <!-- 1. 이메일 추가: GET 방식으로 들어왔을 때 검증한 이메일을 여기에 바인딩해 주세요.
             사용자에게 보여주되 수정은 못 하도록 readonly 처리를 했습니다. 
             화면에서 아예 숨기고 싶다면 type="hidden"으로 변경하셔도 됩니다. -->
        <div class="form-group">
            <label for="email">이메일 계정</label>
            <input type="email" id="email" name="email" value="${email}" readonly required>
        </div>

        <!-- 2. 비밀번호 추가: 컨트롤러의 request.getParameter("password")와 일치하도록 name="password" 설정 -->
        <div class="form-group">
            <label for="newPassword">새 비밀번호</label>
            <input type="password" id="newPassword" name="password" required placeholder="영문, 숫자, 특수문자 포함 8자 이상">
            <div id="passwordError" class="error-msg">비밀번호 형식이 올바르지 않습니다.</div>
        </div>

        <div class="form-group">
            <label for="confirmPassword">새 비밀번호 확인</label>
            <input type="password" id="confirmPassword" required placeholder="비밀번호를 한번 더 입력하세요">
            <div id="confirmError" class="error-msg">비밀번호가 일치하지 않습니다.</div>
        </div>

        <button type="submit" class="btn-submit">비밀번호 변경하기</button>
    </form>
</div>
<script src="${pageContext.request.contextPath}/resources/js/pwResetToken.js"></script>
</body>
</html>
