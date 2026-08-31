package com.app.service.api.impl;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.app.common.CommonCode;
import com.app.dto.api.ChzzkApiResponse;
import com.app.dto.api.ChzzkRawResponse;
import com.app.dto.api.ChzzkRawResponse.LiveData;
import com.app.service.api.ChzzkApiService;
import com.app.service.board.GameBoardService;

@Service
public class ChzzkApiServiceImpl implements ChzzkApiService {

	@Autowired
	GameBoardService gameBoardService;
	
	@Override
	public List<ChzzkApiResponse> getChzzkApiResponseByGameAlias(String gameAlias) {
		List<ChzzkApiResponse> response = new ArrayList<>();
		
		// 인코딩
		URI targetUri = UriComponentsBuilder.fromHttpUrl("https://api.chzzk.naver.com")
		        .path("/service/v2/categories/GAME/League_of_Legends/lives")
		        .queryParam("size", CommonCode.CHZZK_API_RAW_DATA_SIZE)
		        .queryParam("sortType", "POPULAR")
		        .build().encode().toUri();

		// HTTP 클라이언트 객체 생성
		RestTemplate restTemplate = new RestTemplate();

		// GET 요청
		ChzzkRawResponse rawData = restTemplate.getForObject(targetUri, ChzzkRawResponse.class);

		System.out.println(rawData);
		
		if(rawData == null) return response;

		if(rawData != null && rawData.getContent() != null && rawData.getContent().getData() != null) {
			int length = Math.min(CommonCode.CHZZK_API_RAW_DATA_SIZE, rawData.getContent().getData().size());
			for(int i=0; i<length ;i++) {
				if(rawData.getContent().getData().get(i).isAdult()) continue;
				
				String liveTitle = rawData.getContent().getData().get(i).getLiveTitle();
				String streamerName = rawData.getContent().getData().get(i).getChannel().getChannelName();
				String previewImageUrlOriginal = rawData.getContent().getData().get(i).getLiveImageUrl();
				String previewImageUrl = (previewImageUrlOriginal != null) ? previewImageUrlOriginal.replace("{type}","360") : "";
				int concurrentUserCount = rawData.getContent().getData().get(i).getConcurrentUserCount();
				String channelId = rawData.getContent().getData().get(i).getChannel().getChannelId();
				String profileImageUrl = rawData.getContent().getData().get(i).getChannel().getChannelImageUrl();
				
				ChzzkApiResponse apiResponse = new ChzzkApiResponse(
							liveTitle , streamerName , previewImageUrl , 
							concurrentUserCount , channelId , profileImageUrl			
						);
				response.add(apiResponse);
				if(response.size() >= CommonCode.CHZZK_API_DATA_SIZE) break;
			}
		}
		return response;
	}
}
