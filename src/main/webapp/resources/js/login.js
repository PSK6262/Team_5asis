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
                } else {
                    resultDiv.innerHTML = "가입하신 이메일로 임시 비밀번호를 발송했습니다.<br><small style='color: #888;'>메일함을 확인해 주세요!</small>";
                    resultDiv.style.color = "#2F7778";
                }
            })
            .catch(err => {
                resultDiv.innerText = "메일 발송 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.";
                resultDiv.style.color = "red";
            });
        }
		
		//로그인 폼 제출시 비동기(fetch) 처리 (방문기록 스택 방지)
		document.getElementById("loginForm").addEventListener("submit", function(e) {
			e.preventDefault();
			
			const email = document.getElementById("email").value;
			const password = document.getElementById("password").value;
			const rememberId = document.getElementById("rememberId") ? (document.getElementById("rememberId").checked ? "Y" : "N") : "N";
			const errorMsg = document.querySelector(".login-error-msg");
			
			fetch(contextPath + "/user/login", {
				method: "POST",
				headers: {"Content-Type": "application/x-www-form-urlencoded"},
				body: new URLSearchParams({
					email: email,
					password: password,
					rememberId: rememberId
				})
			})
			
			.then(response => {
				//서버에서 리다이렉트 응답이 오면 해당 주소로 이동
				if(response.redirected){
					//replace를 사용하면 로그인 페이지 자체를 히스토리에서 지우고 이동함
					window.location.replace(response.url);
				} else {
					return response.text();
				}
			}) 
			.then(html => {
				//로그인 실패 시: 화면 이동없이 에러글씨만 업데이트
				if (html && errorMsg) {
					errorMsg.innerText = "아이디 또는 비밀번호가 일치하지 않습니다.";
				}
			})
			.catch(err => {
				console.error("로그인 통신 오류:", err);
			});
			
		});
		