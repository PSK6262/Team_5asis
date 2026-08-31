package com.app.dto.board;

import lombok.Data;

// 왜 만들었냐? -> 게임 이름과 게임 별명(alias)를 동시에 보내기 위해서
// 하나만 보내면 , 예를들어 약어를 보냈는데 거기선 풀네임을 원하는 경우
// 그 반대도 동일한데 그 경우에 다시 DB를 검색하는 로직을 사용하면 굉장히 비효율적임
@Data
public class GameNameTransferForm {
	String gameName;
	String gameAlias;
}
