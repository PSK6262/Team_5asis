<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 재설정</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f6f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .reset-container { background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); width: 100%; max-width: 400px; }
        h2 { margin-bottom: 20px; color: #333; text-align: center; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #666; font-size: 14px; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-size: 16px; }
        .form-group input:focus { border-color: #007bff; outline: none; }
        .form-group input:read-only { background-color: #e9ecef; color: #495057; cursor: not-allowed; }
        .error-msg { color: #dc3545; font-size: 13px; margin-top: 5px; display: none; }
        .btn-submit { width: 100%; padding: 12px; background-color: #007bff; border: none; border-radius: 4px; color: white; font-size: 16px; cursor: pointer; font-weight: bold; }
        .btn-submit:hover { background-color: #0056b3; }
    </style>
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

<script>
function validateForm() {
    const password = document.getElementById("newPassword").value;
    const confirmPassword = document.getElementById("confirmPassword").value;
    
    const passwordError = document.getElementById("passwordError");
    const confirmError = document.getElementById("confirmError");
    
    let isValid = true;

    // 비밀번호 정규식 (영문, 숫자, 특수문자 포함 8자 이상)
    const passwordRegExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,20}$/;

    // 1. 비밀번호 유효성 검사
    if (!passwordRegExp.test(password)) {
        passwordError.style.display = "block";
        isValid = false;
    } else {
        passwordError.style.display = "none";
    }

    // 2. 비밀번호 일치 여부 검사
    if (password !== confirmPassword) {
        confirmError.style.display = "block";
        isValid = false;
    } else {
        confirmError.style.display = "none";
    }

    return isValid;
}
</script>

</body>
</html>
