		//=====이메일 중복체크=====
		var isEmailChecked = false; //이메일 중복체크 통과된 것만 가입 가능하도록
		
		function checkDuplicate(){
			var email = document.getElementById("email").value;
			
			if (email == ""){
				alert("이메일을 먼저 입력해주세요.");
				return;
			}
			
			fetch(contextPath + "/user/checkEmail", {	//수정
				method: "POST",
				headers: { "Content-Type": "application/x-www-form-urlencoded"},
				body: "email=" + email
			})
			.then(response => response.text())
			.then(result => {
				var msg = document.getElementById("msgBox");
				
				if (result == "1"){
					msg.innerText = "이미 사용 중인 이메일입니다.";
					msg.style.color = "red"
					isEmailChecked = false;
				} else {
					msg.innerText = "사용 가능한 이메일입니다.";
					msg.style.color = "green";
					isEmailChecked = true;
				}
			});
		}
		
		//이메일 수정 시 중복체크 상태 초기화
		document.getElementById("email").addEventListener("input", function(){
			isEmailChecked = false;
			document.getElementById("msgBox").innerText = "";
		});
		
		
		//=====비밀번호 형식 검사=====
		var pwInput = document.getElementById("password");		
		var pwFormatMsg = document.getElementById("pwFormatMsg");
		var pwRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~`]).{8,20}$/;
		
		function checkPwFormat() {
			var pw = pwInput.value;
			
			if (pw === "") {
					pwFormatMsg.innerText = "영문, 숫자, 특수문자 포함 8~20자";
					pwFormatMsg.style.color = "#888";
					return false;
			}
			
			if (pwRegex.test(pw)) {
					pwFormatMsg.innerText = "";
					return true;
			} else {
					pwFormatMsg.innerText = "영문, 숫자, 특수문자를 포함하여 8~20자로 입력해 주세요.";
					pwFormatMsg.style.color = "red"; //조건에 맞지 않을때만 표시
					return false;
			}
		}
		
		
		//=====비밀번호 실시간 일치 검사=====
		var pwConfirmInput = document.getElementById("passwordConfirm");
		var pwMsg = document.getElementById("pwMsg");
		
		function checkPwMatch() {
			var pw = pwInput.value;
			var pwConfirm = pwConfirmInput.value;
			
			//둘 다 비어있거나 확인 칸이 비어있으면 메세지 숨김
			if (pwConfirm === "") {
					pwMsg.innerText = "";
					return false;
			}
			
			if (pw === pwConfirm){
					pwMsg.innerText = "비밀번호가 일치합니다.";
					pwMsg.style.color = "green";
					return true;
			} else {
					pwMsg.innerText = "비밀번호가 맞지 않습니다.";
					pwMsg.style.color = "red";
					return false;
			}	
		}
		
		//실시간 이벤트 리스너 연결
		pwInput.addEventListener("input", function() {
			checkPwFormat();
			if (pwConfirmInput.value !== "") checkPwMatch();
		});
		pwConfirmInput.addEventListener("input", checkPwMatch);
		
		
		
		//===== 최종 검사 =====
		document.getElementById("signupForm").addEventListener("submit", function(e){
			//이메일 중복체크 안했을 시 팝업
			if(!isEmailChecked){
				e.preventDefault();
				alert("이메일 중복체크를 먼저 완료해 주세요.");
				document.getElementById("email").focus();
				return false;
			}
			
			//비밀번호 형식 확인
			if(!checkPwFormat()){
				e.preventDefault();
				pwInput.focus();
				return false;
			}
			
			//비밀번호 일치 확인
			if(!checkPwMatch()){
				e.preventDefault();
				pwConfirmInput.focus();
				return false;
			}
		});

		
		
		// 약관 표준 텍스트 데이터
		const termsText = {
		    service: `[제1조 목적]
		본 약관은 5ASIS 서비스 이용과 관련하여 회사와 회원 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.

		[제2조 서비스 이용]
		회원은 본 약관 및 관계 법령을 준수하여야 하며, 타인의 정보를 도용하거나 서비스를 부정하게 이용해서는 안 됩니다.

		[제3조 면책]
		회사는 천재지변 또는 불가항력으로 인해 서비스를 제공할 수 없는 경우 책임이 면제됩니다.`,

		    privacy: `[개인정보 수집 및 이용 동의]
		1. 수집 항목: 이메일, 비밀번호, 닉네임
		2. 수집 목적: 회원 식별, 서비스 제공 및 부정 이용 방지
		3. 보유 및 이용 기간: 회원 탈퇴 시까지 (관계 법령에 따름)

		※ 회원은 개인정보 수집 동의를 거부할 권리가 있으나, 거부 시 회원가입이 제한됩니다.`
		};

		function openTerms(type) {
		    document.getElementById("modalTitle").innerText = (type === 'service') ? "이용약관" : "개인정보 수집 및 이용 동의";
		    document.getElementById("modalContent").innerText = termsText[type];
		    document.getElementById("termsModal").style.display = "flex";
		}

		function closeTermsModal() {
		    document.getElementById("termsModal").style.display = "none";
		}