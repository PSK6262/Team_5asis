package com.app.dto;

import lombok.Data;

@Data
public class GameList {
    private Long gameId; // PK
    private String gameName;
    private String gameAlias;
}
