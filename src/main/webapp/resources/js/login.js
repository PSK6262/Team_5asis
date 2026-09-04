function openFindPwModal() {
    document.getElementById("findPwEmail").value = "";
    document.getElementById("findPwResult").innerText = "";
    document.getElementById("findPwModal").style.display = "flex";
    document.getElementById("findPwEmail").focus();
}

function closeFindPwModal() {
    document.getElementById("findPwModal").style.display = "none";
}

function searchPassword() {
    var email = document.getElementById("findPwEmail").value.trim();
    var resultDiv = document.getElementById("findPwResult");

    if (email === "") {
        alert("이메일을 입력해 주세요.");
        return;
    }

    fetch(contextPath + "/user/findPassword", { //수정
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "email=" + encodeURIComponent(email)
    })
    .then(response => response.text())
    .then(result => {
        if (result === "NOT_FOUND") {
            resultDiv.innerText = "등록되지 않은 이메일입니다.";
            resultDiv.style.color = "red";
        } else if(result === "DEACTIVATED"){
			resultDiv.innerText = "탈퇴된 계정입니다.";
			resultDiv.style.color = "red";
		} else {
            resultDiv.innerHTML = "가입하신 이메일로 비밀번호 재설정 링크가 발송되었습니다.<br><small style='color: #888;'>메일함을 확인해 주세요!</small>";
            resultDiv.style.color = "#2F7778";
        }
    })
    .catch(err => {
        resultDiv.innerText = "메일 발송 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.";
        resultDiv.style.color = "red";
    });
}



// 로그인 폼 비동기 전송 (스택 누적 방지 & 이메일 보존)
document.getElementById("loginForm").addEventListener("submit", function(e) {
    e.preventDefault(); // 브라우저 새로고침 및 히스토리 스택 누적 차단

    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    const rememberId = document.getElementById("rememberId") ? (document.getElementById("rememberId").checked ? "Y" : "N") : "N";
    const errorMsg = document.querySelector(".login-error-msg");

    fetch(contextPath + "/user/login", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({
            email: email,
            password: password,
            rememberId: rememberId
        })
    })
    .then(response => {
        // 로그인 성공 시 메인(/main) 또는 이전 페이지로 이동
        if (response.redirected && !response.url.includes("/user/login")) {
            window.location.replace(response.url);
        } else {
            // 로그인 실패 시 화면 새로고침없이 에러 글씨만 띄움
            if (errorMsg) {
                errorMsg.innerText = "아이디 또는 비밀번호가 일치하지 않습니다.";
            }
        }
    })
    .catch(err => {
        console.error("로그인 통신 오류:", err);
    });
});
		
		