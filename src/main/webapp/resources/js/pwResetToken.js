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