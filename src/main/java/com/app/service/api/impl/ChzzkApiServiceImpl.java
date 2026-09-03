package com.app.service.api.impl;

import java.net.URI;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.app.common.CommonCode;
import com.app.dao.board.GameBoardDAO;
import com.app.dto.api.ChzzkApiResponse;
import com.app.dto.api.ChzzkRawResponse;
import com.app.dto.api.ChzzkRawResponse.LiveData;
import com.app.service.api.ChzzkApiService;
import com.app.service.board.GameBoardService;

@Service
public class ChzzkApiServiceImpl implements ChzzkApiService {

	@Autowired
	GameBoardService gameBoardService;
	
	@Autowired
	GameBoardDAO gameBoardDAO;
	
	private final RestTemplate restTemplate;
	
	public ChzzkApiServiceImpl() {
		SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
		factory.setConnectTimeout(1500); // 1.5초 안에 연결이 안되면 타임아웃 ( 네이버랑 연결이 안되면 )
		factory.setReadTimeout(2000); // 2초 안에 못 읽으면 타임아웃 ( 네이버측에서 데이터 전송이 늦으면 )
		this.restTemplate = new RestTemplate(factory);
	}
	
	@Override
	public List<ChzzkApiResponse> getChzzkApiResponseByGameAlias(String gameAlias) {
		List<ChzzkApiResponse> response = new ArrayList<>();
		
		String chzzkCategoryName = gameBoardDAO.findChzzkCategoryNameByGameAlias(gameAlias);
		
		// 인코딩
		URI targetUri = UriComponentsBuilder.fromHttpUrl("https://api.chzzk.naver.com")
		        .path("/service/v2/categories/GAME/" + chzzkCategoryName + "/lives")
		        .queryParam("size", CommonCode.CHZZK_API_RAW_DATA_SIZE)
		        .queryParam("sortType", "POPULAR")
		        .build().encode().toUri();
		System.out.println(targetUri);
		
		// HTTP 클라이언트 객체 생성
		//RestTemplate restTemplate = new RestTemplate();

		// GET 요청
		ChzzkRawResponse rawData = null;
		try {
			rawData = restTemplate.getForObject(targetUri, ChzzkRawResponse.class);
		} catch (RestClientException e) {
			return response;
		}
		
		if(rawData == null) return response;

		if(rawData.getContent() != null && rawData.getContent().getData() != null) {
			int length = Math.min(CommonCode.CHZZK_API_RAW_DATA_SIZE, rawData.getContent().getData().size());
			for(int i=0; i<length ;i++) {
				if(rawData.getContent().getData().get(i).isAdult()) continue;
				
				LiveData liveData = rawData.getContent().getData().get(i);
				
				String liveTitle = liveData.getLiveTitle();
				String streamerName = liveData.getChannel().getChannelName();
				String previewImageUrlOriginal = liveData.getLiveImageUrl();
				String previewImageUrl = (previewImageUrlOriginal != null) ? previewImageUrlOriginal.replace("{type}","360") : "";
				int concurrentUserCount = liveData.getConcurrentUserCount();
				String channelId = liveData.getChannel().getChannelId();
				String profileImageUrl = liveData.getChannel().getChannelImageUrl();
				
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
