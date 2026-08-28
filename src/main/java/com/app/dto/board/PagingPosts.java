package com.app.dto.board;

import java.util.List;

import com.app.common.CommonCode;

import lombok.Data;

@Data
public class PagingPosts {
	
	private List<Post> posts;
	private String gameAlias;
	private int currentPage;
	private int size = CommonCode.PAGING_SIZE; // 한 페이지에 몇개씩 가져올 것인지?
	private boolean hasNext; // 다음페이지가 있는지?
	private boolean hasPrev;
	private int postSize;
	private String category;
	
	// DB에서 직접 계산하면.. 성능이 떨어지니까 미리 계산한 값으로 전달함
	public int getOffset() {
		return (this.currentPage-1) * this.size;
	}
	public void setPostSize(int postSize) {
		this.postSize = postSize;
		
		int maxPage = (int) Math.ceil((double) this.postSize / this.size);
		if (maxPage == 0) maxPage = 1;

		this.hasPrev = (this.currentPage - 2) > 0;
		this.hasNext = (this.currentPage + 2) <= maxPage;
	}
}
