package com.app.dto.api;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ChzzkApiResponse {
    private final String liveTitle;          // 방송 제목
    private final String streamerName;       // 스트리머 닉네임
    private final String previewImageUrl;    // 실시간 미리보기 썸네일 (URL)
    private final int concurrentUserCount;   // 시청자 수
    private final String channelId;          // 클릭 시 채널로 이동할 링크
    private final String profileImageUrl;    // 스트리머 프로필 이미지 URL


    // 링크 간단하게
    public String getChzzkLiveUrl() {
        return "https://naver.com" + this.channelId;
    }
}