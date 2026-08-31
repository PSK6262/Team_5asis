package com.app.service.api;

import java.util.List;

import com.app.dto.api.ChzzkApiResponse;

public interface ChzzkApiService {
	List<ChzzkApiResponse> getChzzkApiResponseByGameAlias(String gameAlias);
}
