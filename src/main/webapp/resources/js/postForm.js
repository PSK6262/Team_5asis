function cancelForm() {
    const { isEdit, gameAlias, pid, contextPath } = window.PAGE_CONFIG;

    const msg = isEdit 
        ? "수정을 취소하시겠습니까?\n입력한 내용은 저장되지 않습니다."
        : "작성을 취소하시겠습니까?\n입력한 내용은 저장되지 않습니다.";

    if (confirm(msg)) {
        if (isEdit) {
            location.href = contextPath + "/board/" + gameAlias + "/" + pid;
        } else {
            location.href = contextPath + "/board/" + gameAlias;
        }
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const postForm = document.getElementById('postForm');
    const editor = document.getElementById('editor');
    const hiddenContent = document.getElementById('hiddenContent');
    const imageInput = document.getElementById('imageInput');
    const fileInput = document.getElementById('fileInput');
    const fileList = document.getElementById('fileList');

    // 업로드할 전체 파일들을 관리하는 배열 (일반 파일)
    let uploadFiles = [];

    // 1. 화면의 새 파일 목록 UI 및 fileInput 동기화 함수
    function renderFileList() {
        if (!fileList) return;
        fileList.innerHTML = '';
        
        uploadFiles.forEach((file, index) => {
            const li = document.createElement('li');
            li.className = 'file-item';
            li.innerHTML = `
                📎 ${file.name} (${(file.size / 1024).toFixed(1)} KB)
                <button type="button" class="btn-file-remove" style="margin-left: 8px; color: red; cursor: pointer; border: none; background: none;" data-index="${index}">✖</button>
            `;
            fileList.appendChild(li);
        });

        // 파일 삭제(✖) 버튼 클릭 이벤트
        const removeButtons = fileList.querySelectorAll('.btn-file-remove');
        removeButtons.forEach(btn => {
            btn.addEventListener('click', function() {
                const targetIndex = parseInt(this.getAttribute('data-index'), 10);
                uploadFiles.splice(targetIndex, 1); // 배열에서 제거
                renderFileList(); // UI 재갱신 및 input 동기화
            });
        });

        // ★ [핵심 1] 파일 추가/삭제 시점에 즉시 DataTransfer로 fileInput.files 업데이트
        if (fileInput) {
            const dataTransfer = new DataTransfer();
            uploadFiles.forEach(file => {
                dataTransfer.items.add(file);
            });
            fileInput.files = dataTransfer.files;
        }
    }

    // 기존 첨부파일 삭제 체크박스 이벤트
    const deleteCheckboxes = document.querySelectorAll('.file-delete-chk');
    deleteCheckboxes.forEach(chk => {
        chk.addEventListener('change', function() {
            const li = this.closest('li');
            if (this.checked) {
                li.style.textDecoration = 'line-through';
                li.style.color = '#888';
            } else {
                li.style.textDecoration = 'none';
                li.style.color = '#333';
            }
        });
    });

    // 2. 이미지 선택 시 에디터 미리보기 생성
    if (imageInput) {
        imageInput.addEventListener('change', function(e) {
            const files = Array.from(e.target.files);

            files.forEach(file => {
                if (!file.type.startsWith('image/')) return;

                const reader = new FileReader();
                reader.onload = function(event) {
                    const img = document.createElement('img');
                    img.src = event.target.result;
                    img.style.maxWidth = '100%';

                    editor.appendChild(img);
                    editor.appendChild(document.createElement('br'));
                };
                reader.readAsDataURL(file);
            });

            imageInput.value = ''; 
        });
    }

    // 3. 일반 파일 선택 시 업로드 파일 배열에 누적
    if (fileInput) {
        fileInput.addEventListener('change', function(e) {
            const files = Array.from(e.target.files);

            files.forEach(file => {
                uploadFiles.push(file);
            });

            renderFileList(); // renderFileList 내부에서 input.files 자동 반영됨
        });
    }

    // 4. Form 제출 검증 및 동기화
    if (postForm) {
        postForm.addEventListener('submit', function(e) {
            // 에디터 내용을 hidden input에 동기화
            if (editor && hiddenContent) {
                hiddenContent.value = editor.innerHTML.trim();
            }

            // ★ [핵심 2] 본문 내용 검증 (Oracle ORA-01400 방지)
            const textContent = editor ? editor.innerText.trim() : "";
            const hasImage = editor ? editor.querySelector('img') !== null : false;

            if (!textContent && !hasImage) {
                alert("게시글 내용을 입력해주세요.");
                e.preventDefault(); // 전송 중단
                return false;
            }

            console.log("최종 서버로 전송되는 파일 수:", fileInput ? fileInput.files.length : 0);
        });
    }
});