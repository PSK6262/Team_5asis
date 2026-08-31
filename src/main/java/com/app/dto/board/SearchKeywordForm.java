package com.app.dto.board;

import lombok.Data;

@Data
public class SearchKeywordForm {
	// 검색을 할 때
	// 글 제목만 검색된 경우
	// 글 내용만 검색된 경우
	// 작성자만 검색된 경우
	private String type;
	private String keyword;
}
