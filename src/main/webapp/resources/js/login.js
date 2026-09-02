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
                    resultDiv.innerHTML = "회원님의 비밀번호는<br><strong style='color: #2F7778; font-size: 15px;'>[ " + result + " ]</strong> 입니다.";
                    resultDiv.style.color = "#333";
                }
            })
            .catch(err => {
                resultDiv.innerText = "조회 중 오류가 발생했습니다.";
                resultDiv.style.color = "red";
            });
        }