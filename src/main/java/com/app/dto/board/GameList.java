package com.app.dto.board;

import lombok.Data;

@Data
public class GameList {
    private Long gameId; // PK
    private String gameName;
    private String gameAlias;
    private String gameAliasKor;
    private String chzzkGameName;
}
