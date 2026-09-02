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