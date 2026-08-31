package com.app.dto.api;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

// JSON으로 받음
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ChzzkRawResponse {
    
    private int code;
    private Content content;

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Content {
        private List<LiveData> data;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class LiveData {
        private String liveTitle;
        private String liveImageUrl;
        private int concurrentUserCount;
        private boolean adult;
        private Channel channel;
    }

    @Data
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Channel {
        private String channelId;
        private String channelName;
        private String channelImageUrl;
    }
}
