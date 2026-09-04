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
        .error-msg { color: #dc3545; font-size: 13px; margin-top: 5px; display: none; }
        .btn-submit { width: 100%; padding: 12px; background-color: #007bff; border: none; border-radius: 4px; color: white; font-size: 16px; cursor: pointer; font-weight: bold; }
        .btn-submit:hover { background-color: #0056b3; }
    </style>
</head>
<body>

<div class="reset-container">
    <h2>비밀번호 재설정</h2>
    
    <!-- action 속성에는 패스워드 변경을 처리할 서버 URL을 넣으시면 됩니다 -->
    <form action="/api/reset-password" method="POST" onsubmit="return validateForm()">
        
        <!-- 검증된 토큰을 서버로 함께 전송하기 위한 hidden 필드입니다. 
             JavaScript나 템플릿 엔진을 통해 value에 토큰 값을 동적으로 넣어주세요. -->
        <input type="hidden" id="token" name="token" value="">

        <div class="form-group">
            <label for="newPassword">새 비밀번호</label>
            <input type="password" id="newPassword" name="newPassword" required placeholder="영문, 숫자, 특수문자 포함 8자 이상">
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
    const passwordRegExp = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;

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
