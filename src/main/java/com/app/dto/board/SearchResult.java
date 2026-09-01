package com.app.dto.board;

import java.util.List;

import com.app.dto.user.UserInfo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SearchResult {
		List<Post> searchedByTitle;
		List<Post> searchedByContent;
		List<UserInfo> searchedByNickname;
		List<GameNameTransferForm> searchedByBoardName;
}
