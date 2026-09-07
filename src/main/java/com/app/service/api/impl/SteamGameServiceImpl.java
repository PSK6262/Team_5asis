package com.app.service.api.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.app.dto.api.SteamGame;
import com.app.service.api.SteamGameService;

/**
 * SteamGameService의 실제 구현 클래스
 *
 * 주요 기능
 * 1. Steam 할인 게임 6개 조회
 * 2. Steam Store 전체 게임을 최대한 넓게 대상으로 랜덤 게임 조회
 *
 * 주의
 * ------------------------------------------------------------
 * Steam의 공식 전체 App List API(IStoreService/GetAppList)는
 * 현재 API Key가 필요하다.
 *
 * 따라서 랜덤 게임은 API Key가 필요 없는
 * Steam Store의 공개 검색 API(storesearch)를 이용한다.
 *
 * 여러 검색어와 랜덤 페이지를 사용해서
 * 특정 할인 목록에 한정되지 않은 게임을 랜덤하게 가져온다.
 */
@Service
public class SteamGameServiceImpl implements SteamGameService {

    /*
     * ============================================================
     * Steam API 주소
     * ============================================================
     */

    /**
     * Steam 할인 게임 API
     *
     * featuredcategories API의 specials 영역을 사용한다.
     */
    private static final String STEAM_FEATURED_API_URL =
            "https://store.steampowered.com/api/featuredcategories"
            + "?cc=KR&l=koreana";


    /**
     * Steam Store 검색 API
     *
     * term에는 검색어가 들어간다.
     *
     * 예:
     *
     * https://store.steampowered.com/api/storesearch/
     * ?term=action&cc=KR&l=koreana
     */
    private static final String STEAM_STORE_SEARCH_API_URL =
            "https://store.steampowered.com/api/storesearch/"
            + "?term={term}"
            + "&cc=KR"
            + "&l=koreana"
            + "&start={start}"
            + "&count={count}";


    /**
     * Steam 개별 게임 상세정보 API
     *
     * appid를 이용해서 게임의 상세정보를 가져온다.
     */
    private static final String STEAM_APP_DETAILS_API_URL =
            "https://store.steampowered.com/api/appdetails/"
            + "?appids={appid}"
            + "&cc=KR"
            + "&l=koreana";


    /*
     * ============================================================
     * 화면 표시 개수
     * ============================================================
     */

    /**
     * 메인 화면에 표시할 게임 개수
     *
     * 현재 JSP가 3 × 2 구조이므로 6개를 사용한다.
     */
    private static final int DISPLAY_GAME_COUNT = 6;


    /*
     * ============================================================
     * 랜덤 검색 설정
     * ============================================================
     */

    /**
     * 한 번의 검색에서 가져올 게임 개수
     *
     * Steam Store 검색 API에 너무 많은 데이터를 요청하지 않도록
     * 적당한 개수만 가져온다.
     */
    private static final int SEARCH_RESULT_COUNT = 50;


    /**
     * 랜덤 검색을 최대 몇 번 시도할지 설정한다.
     *
     * 검색 결과가 없는 경우나
     * 이미 가져온 게임과 중복되는 경우를 대비한다.
     */
    private static final int RANDOM_SEARCH_ATTEMPT_COUNT = 10;


    /**
     * 랜덤 검색어 목록
     *
     * 특정 장르 하나에만 몰리지 않도록
     * 다양한 검색어를 준비한다.
     *
     * 검색어가 서로 다르기 때문에
     * Steam Store의 서로 다른 영역에서 게임을 가져올 가능성이 높아진다.
     */
    private static final String[] RANDOM_SEARCH_TERMS = {

        "a",
        "e",
        "i",
        "o",
        "s",
        "r",
        "t",
        "n",
        "m",
        "c",
        "d",
        "g",
        "p",
        "f",
        "h",
        "k",
        "l",
        "b",
        "v",
        "w",
        "y",

        "action",
        "adventure",
        "rpg",
        "strategy",
        "simulation",
        "sports",
        "racing",
        "horror",
        "indie",
        "arcade",
        "shooter",
        "puzzle",
        "survival",
        "multiplayer",
        "open world"
    };


    /*
     * ============================================================
     * Java Random
     * ============================================================
     */

    /**
     * 랜덤 값을 생성하기 위한 객체
     */
    private final Random random = new Random();


    /*
     * ============================================================
     * RestTemplate
     * ============================================================
     */

    /**
     * Steam Store API에 HTTP GET 요청을 보내기 위한 객체
     */
    private final RestTemplate restTemplate = new RestTemplate();


    /*
     * ============================================================
     * 할인 게임
     * ============================================================
     */

    /**
     * Steam 할인 게임 6개를 가져온다.
     */
    @Override
    public List<SteamGame> getDiscountGames() {

        /*
         * Steam 할인/추천 API 호출
         */
        Map<String, Object> response =
                getSteamFeaturedApiResponse();


        /*
         * API 호출 실패
         */
        if (response == null) {
            return Collections.emptyList();
        }


        /*
         * specials 영역 가져오기
         */
        Map<String, Object> specials =
                getMap(response.get("specials"));


        if (specials == null) {
            return Collections.emptyList();
        }


        /*
         * 할인 게임 목록 가져오기
         */
        List<Map<String, Object>> items =
                getMapList(specials.get("items"));


        /*
         * 최종 할인 게임 목록
         */
        List<SteamGame> games =
                new ArrayList<>();


        /*
         * 할인 게임을 SteamGame DTO로 변환
         */
        for (Map<String, Object> item : items) {

            SteamGame game =
                    convertToSteamGame(item);


            if (game != null) {

                games.add(game);
            }


            /*
             * 6개를 채우면 종료
             */
            if (games.size() >= DISPLAY_GAME_COUNT) {

                break;
            }
        }


        return games;
    }


    /*
     * ============================================================
     * 랜덤 게임
     * ============================================================
     */

    /**
     * Steam Store에서 랜덤 게임 6개를 가져온다.
     *
     * 기존 방식과 차이
     * ------------------------------------------------------------
     *
     * 기존:
     *
     *     specials
     *        ↓
     *     할인 게임 목록
     *        ↓
     *     shuffle()
     *
     *
     * 현재:
     *
     *     랜덤 검색어 선택
     *        ↓
     *     Steam Store 검색
     *        ↓
     *     랜덤 페이지 선택
     *        ↓
     *     게임 후보 추출
     *        ↓
     *     중복 제거
     *        ↓
     *     실제 게임인지 확인
     *        ↓
     *     최대 6개 반환
     */
    @Override
    public List<SteamGame> getRandomGames() {

        /*
         * 최종 랜덤 게임 목록
         */
        List<SteamGame> randomGames =
                new ArrayList<>();


        /*
         * 같은 게임이 여러 검색 결과에서
         * 중복으로 들어오는 것을 막기 위한 Set
         */
        Set<Long> selectedGameIds =
                new HashSet<>();


        /*
         * ========================================================
         * 랜덤 검색 여러 번 실행
         * ========================================================
         */
        for (int attempt = 0;
             attempt < RANDOM_SEARCH_ATTEMPT_COUNT;
             attempt++) {

            /*
             * 이미 6개를 찾았다면 종료
             */
            if (randomGames.size() >= DISPLAY_GAME_COUNT) {

                break;
            }


            /*
             * ----------------------------------------------------
             * 1. 랜덤 검색어 선택
             * ----------------------------------------------------
             */
            String randomTerm =
                    RANDOM_SEARCH_TERMS[
                        random.nextInt(
                            RANDOM_SEARCH_TERMS.length
                        )
                    ];


            /*
             * ----------------------------------------------------
             * 2. 랜덤 검색 결과 가져오기
             * ----------------------------------------------------
             *
             * 먼저 검색 결과의 전체 개수를 알아야
             * 랜덤한 시작 위치를 계산할 수 있다.
             */
            Map<String, Object> searchResponse =
                    getSteamStoreSearchResponse(
                            randomTerm,
                            0
                    );


            /*
             * 검색 실패
             */
            if (searchResponse == null) {

                continue;
            }


            /*
             * Steam 검색 결과 전체 개수
             */
            Integer totalCount =
                    getInteger(
                        searchResponse.get("total_count")
                    );


            /*
             * 검색 결과가 없으면 다음 검색
             */
            if (totalCount == null
                    || totalCount <= 0) {

                continue;
            }


            /*
             * ----------------------------------------------------
             * 3. 랜덤 시작 위치 계산
             * ----------------------------------------------------
             *
             * 예를 들어 검색 결과가 10,000개라면
             *
             * 0 ~ 9,950
             *
             * 사이에서 랜덤으로 시작 위치를 만든다.
             */
            int maxStart =
                    Math.max(
                        0,
                        totalCount - SEARCH_RESULT_COUNT
                    );


            int randomStart = 0;


            if (maxStart > 0) {

                randomStart =
                        random.nextInt(maxStart + 1);
            }


            /*
             * ----------------------------------------------------
             * 4. 랜덤 위치의 게임 목록 가져오기
             * ----------------------------------------------------
             */
            Map<String, Object> randomSearchResponse =
                    getSteamStoreSearchResponse(
                            randomTerm,
                            randomStart
                    );


            if (randomSearchResponse == null) {

                continue;
            }


            /*
             * 검색 결과의 items 가져오기
             */
            List<Map<String, Object>> items =
                    getMapList(
                        randomSearchResponse.get("items")
                    );


            /*
             * 검색 결과가 없으면 다음 검색
             */
            if (items.isEmpty()) {

                continue;
            }


            /*
             * 검색 결과 자체도 한 번 섞는다.
             *
             * 같은 페이지에서 항상 첫 번째 게임부터
             * 선택되지 않도록 한다.
             */
            Collections.shuffle(items);


            /*
             * ----------------------------------------------------
             * 5. 검색 결과에서 게임 선택
             * ----------------------------------------------------
             */
            for (Map<String, Object> item : items) {

                /*
                 * 화면에 6개가 들어갔다면 종료
                 */
                if (randomGames.size()
                        >= DISPLAY_GAME_COUNT) {

                    break;
                }


                /*
                 * Steam 검색 결과의 appid
                 */
                Long appId =
                        getLong(item.get("id"));


                /*
                 * ID가 없으면 무시
                 */
                if (appId == null) {

                    continue;
                }


                /*
                 * 이미 선택한 게임이면 무시
                 */
                if (selectedGameIds.contains(appId)) {

                    continue;
                }


                /*
                 * 검색 API 결과의 type 확인
                 *
                 * 일반적으로 game이면 게임이다.
                 */
                String type =
                        getString(item.get("type"));


                if (type != null
                        && !"game".equalsIgnoreCase(type)) {

                    continue;
                }


                /*
                 * ------------------------------------------------
                 * 6. 상세정보 API 호출
                 * ------------------------------------------------
                 *
                 * 검색 결과만 사용하지 않고
                 * appdetails API로 한 번 더 확인한다.
                 */
                SteamGame game =
                        getSteamGameDetails(appId);


                /*
                 * 실제 게임 데이터가 정상적으로 들어온 경우
                 */
                if (game != null) {

                    /*
                     * 중복 방지용 ID 저장
                     */
                    selectedGameIds.add(appId);


                    /*
                     * 최종 게임 목록에 추가
                     */
                    randomGames.add(game);
                }
            }
        }


        /*
         * ========================================================
         * 랜덤 결과 로그
         * ========================================================
         *
         * Eclipse Console에서 실제로 몇 개가 들어왔는지
         * 확인할 수 있다.
         */
        System.out.println(
                "[Steam 랜덤 게임 개수] "
                + randomGames.size()
        );


        for (SteamGame game : randomGames) {

            System.out.println(
                    "[Steam 랜덤 게임] "
                    + game.getId()
                    + " / "
                    + game.getName()
            );
        }


        /*
         * 최종 랜덤 게임 목록 반환
         */
        return randomGames;
    }


    /*
     * ============================================================
     * Steam Store Search API
     * ============================================================
     */

    /**
     * Steam Store 검색 API를 호출한다.
     *
     * @param term 검색어
     * @param start 검색 시작 위치
     * @return Steam 검색 결과
     */
    @SuppressWarnings("unchecked")
    private Map<String, Object> getSteamStoreSearchResponse(
            String term,
            int start) {

        try {

            /*
             * Steam Store 검색 API 호출
             *
             * {term}
             * → 검색어
             *
             * {start}
             * → 검색 시작 위치
             */
            ResponseEntity<Map> response =
                    restTemplate.getForEntity(
                        STEAM_STORE_SEARCH_API_URL,
                        Map.class,
                        term,
                        start,
                        SEARCH_RESULT_COUNT
                    );


            /*
             * 정상 응답이면 Body 반환
             */
            if (response.getStatusCode().is2xxSuccessful()) {

                return response.getBody();
            }

        } catch (Exception e) {

            /*
             * 검색 API 오류가 발생해도
             * 메인 페이지 전체가 500이 되지 않도록 한다.
             */
            System.out.println(
                    "[Steam Store 검색 API 오류]"
            );

            System.out.println(
                    "검색어 : " + term
            );

            System.out.println(
                    "시작 위치 : " + start
            );

            System.out.println(
                    e.getMessage()
            );
        }


        return null;
    }


    /*
     * ============================================================
     * Steam App Details API
     * ============================================================
     */

    /**
     * Steam appid를 이용하여
     * 실제 게임 상세정보를 가져온다.
     *
     * @param appId Steam App ID
     * @return SteamGame 또는 null
     */
    @SuppressWarnings("unchecked")
    private SteamGame getSteamGameDetails(
            Long appId) {

        try {

            /*
             * Steam App Details API 호출
             */
            ResponseEntity<Map> response =
                    restTemplate.getForEntity(
                        STEAM_APP_DETAILS_API_URL,
                        Map.class,
                        appId
                    );


            /*
             * HTTP 오류
             */
            if (!response.getStatusCode().is2xxSuccessful()) {

                return null;
            }


            /*
             * 전체 응답
             */
            Map<String, Object> body =
                    response.getBody();


            if (body == null) {

                return null;
            }


            /*
             * appid가 JSON의 key로 들어간다.
             *
             * 예:
             *
             * "730": {
             *     "success": true,
             *     "data": {...}
             * }
             */
            Object appResponseObject =
                    body.get(
                        String.valueOf(appId)
                    );


            if (!(appResponseObject instanceof Map)) {

                return null;
            }


            Map<String, Object> appResponse =
                    (Map<String, Object>)
                    appResponseObject;


            /*
             * Steam이 해당 게임 정보를
             * 정상적으로 찾았는지 확인한다.
             */
            Object successObject =
                    appResponse.get("success");


            if (!(successObject instanceof Boolean)
                    || !((Boolean) successObject)) {

                return null;
            }


            /*
             * 실제 게임 상세 데이터
             */
            Map<String, Object> data =
                    getMap(
                        appResponse.get("data")
                    );


            if (data == null) {

                return null;
            }


            /*
             * Steam 앱 종류 확인
             */
            String type =
                    getString(data.get("type"));


            /*
             * game만 허용한다.
             *
             * DLC, demo, software 등은 제외한다.
             */
            if (!"game".equalsIgnoreCase(type)) {

                return null;
            }


            /*
             * 상세정보를 SteamGame DTO로 변환
             */
            return convertDetailedSteamGame(data);

        } catch (Exception e) {

            /*
             * 개별 게임 하나가 실패해도
             * 전체 랜덤 검색은 계속 진행한다.
             */
            System.out.println(
                    "[Steam 게임 상세정보 오류] appid="
                    + appId
            );

            System.out.println(
                    e.getMessage()
            );
        }


        return null;
    }


    /*
     * ============================================================
     * Featuredcategories → SteamGame 변환
     * ============================================================
     */

    /**
     * 할인 API 데이터를 SteamGame DTO로 변환한다.
     */
    private SteamGame convertToSteamGame(
            Map<String, Object> item) {

        if (item == null) {

            return null;
        }


        /*
         * 게임 ID
         */
        Long id =
                getLong(item.get("id"));


        /*
         * 게임 이름
         */
        String name =
                getString(item.get("name"));


        /*
         * 게임 이미지
         */
        String headerImage =
                getString(
                    item.get("header_image")
                );


        /*
         * 할인율
         */
        Integer discountPercent =
                getInteger(
                    item.get("discount_percent")
                );


        /*
         * 할인 전 가격
         */
        String originalPrice =
                formatPrice(
                    item.get("original_price")
                );


        /*
         * 할인 후 가격
         */
        String finalPrice =
                formatPrice(
                    item.get("final_price")
                );


        /*
         * 한국 지역
         */
        String currency = "KRW";


        /*
         * 할인 여부
         */
        boolean discounted =
                discountPercent != null
                && discountPercent > 0;


        /*
         * 할인 종료 시간
         */
        Long discountExpiration =
                getLong(
                    item.get("discount_expiration")
                );


        /*
         * 필수 데이터가 없으면 제외
         */
        if (id == null || name == null) {

            return null;
        }


        /*
         * DTO 생성
         */
        SteamGame game =
                new SteamGame();


        game.setId(id);
        game.setName(name);
        game.setDiscountPercent(discountPercent);
        game.setOriginalPrice(originalPrice);
        game.setFinalPrice(finalPrice);
        game.setCurrency(currency);
        game.setHeaderImage(headerImage);
        game.setDiscounted(discounted);
        game.setDiscountExpiration(
                discountExpiration
        );


        return game;
    }


    /*
     * ============================================================
     * App Details → SteamGame 변환
     * ============================================================
     */

    /**
     * Steam App Details API 데이터를
     * SteamGame DTO로 변환한다.
     */
    private SteamGame convertDetailedSteamGame(
            Map<String, Object> data) {

        /*
         * 게임 ID
         */
        Long id =
                getLong(
                    data.get("steam_appid")
                );


        /*
         * 게임 이름
         */
        String name =
                getString(
                    data.get("name")
                );


        /*
         * Steam 헤더 이미지
         */
        String headerImage =
                getString(
                    data.get("header_image")
                );


        /*
         * 기본값
         *
         * 무료 게임은 price_overview 자체가 없을 수 있다.
         */
        Integer discountPercent = 0;

        String originalPrice =
                "무료";

        String finalPrice =
                "무료";

        boolean discounted = false;


        /*
         * 가격 정보
         */
        Map<String, Object> priceOverview =
                getMap(
                    data.get("price_overview")
                );


        /*
         * 유료 게임인 경우
         */
        if (priceOverview != null) {

            /*
             * 할인율
             */
            Integer apiDiscount =
                    getInteger(
                        priceOverview.get(
                            "discount_percent"
                        )
                    );


            if (apiDiscount != null) {

                discountPercent =
                        apiDiscount;
            }


            /*
             * 할인 여부
             */
            discounted =
                    discountPercent > 0;


            /*
             * Steam에서 제공하는
             * 화면 표시용 가격을 우선 사용한다.
             */
            String initialFormatted =
                    getString(
                        priceOverview.get(
                            "initial_formatted"
                        )
                    );


            String finalFormatted =
                    getString(
                        priceOverview.get(
                            "final_formatted"
                        )
                    );


            /*
             * formatted 가격이 있으면 그대로 사용한다.
             *
             * 이렇게 하면
             * 1,000원 / ₩ 10,000 등
             * Steam에서 제공하는 실제 표시 형식을
             * 그대로 사용할 수 있다.
             */
            if (initialFormatted != null) {

                originalPrice =
                        initialFormatted;

            } else {

                originalPrice =
                        formatPrice(
                            priceOverview.get(
                                "initial"
                            )
                        );
            }


            if (finalFormatted != null) {

                finalPrice =
                        finalFormatted;

            } else {

                finalPrice =
                        formatPrice(
                            priceOverview.get(
                                "final"
                            )
                        );
            }
        }


        /*
         * 통화
         */
        String currency =
                getString(
                    priceOverview != null
                        ? priceOverview.get("currency")
                        : null
                );


        if (currency == null) {

            currency = "KRW";
        }


        /*
         * 할인 종료 시간
         */
        Long discountExpiration =
                getLong(
                    priceOverview != null
                        ? priceOverview.get(
                            "discount_expiration"
                        )
                        : null
                );


        /*
         * 필수 데이터 확인
         */
        if (id == null || name == null) {

            return null;
        }


        /*
         * DTO 생성
         */
        SteamGame game =
                new SteamGame();


        game.setId(id);
        game.setName(name);
        game.setDiscountPercent(
                discountPercent
        );
        game.setOriginalPrice(
                originalPrice
        );
        game.setFinalPrice(
                finalPrice
        );
        game.setCurrency(
                currency
        );
        game.setHeaderImage(
                headerImage
        );
        game.setDiscounted(
                discounted
        );
        game.setDiscountExpiration(
                discountExpiration
        );


        return game;
    }


    /*
     * ============================================================
     * Featuredcategories API
     * ============================================================
     */

    /**
     * Steam 할인 API 호출
     */
    @SuppressWarnings("unchecked")
    private Map<String, Object>
    getSteamFeaturedApiResponse() {

        try {

            ResponseEntity<Map> response =
                    restTemplate.getForEntity(
                        STEAM_FEATURED_API_URL,
                        Map.class
                    );


            if (response.getStatusCode().is2xxSuccessful()) {

                return response.getBody();
            }

        } catch (Exception e) {

            System.out.println(
                    "[Steam Featuredcategories API 오류]"
            );

            System.out.println(
                    e.getMessage()
            );
        }


        return null;
    }


    /*
     * ============================================================
     * Map 변환 Helper
     * ============================================================
     */

    /**
     * Object를 Map으로 안전하게 변환한다.
     */
    @SuppressWarnings("unchecked")
    private Map<String, Object> getMap(
            Object value) {

        if (value instanceof Map) {

            return (Map<String, Object>) value;
        }


        return null;
    }


    /**
     * Object를 Map List로 안전하게 변환한다.
     */
    @SuppressWarnings("unchecked")
    private List<Map<String, Object>> getMapList(
            Object value) {

        if (value instanceof List) {

            return (List<Map<String, Object>>) value;
        }


        return Collections.emptyList();
    }


    /*
     * ============================================================
     * String 변환 Helper
     * ============================================================
     */

    /**
     * Object를 String으로 안전하게 변환한다.
     */
    private String getString(
            Object value) {

        if (value == null) {

            return null;
        }


        String result =
                value.toString().trim();


        if (result.isEmpty()) {

            return null;
        }


        return result;
    }


    /*
     * ============================================================
     * Integer 변환 Helper
     * ============================================================
     */

    /**
     * Object를 Integer로 변환한다.
     */
    private Integer getInteger(
            Object value) {

        if (value == null) {

            return null;
        }


        /*
         * Number 타입
         */
        if (value instanceof Number) {

            return ((Number) value).intValue();
        }


        /*
         * String 숫자
         */
        try {

            return Integer.valueOf(
                value.toString()
            );

        } catch (Exception e) {

            return null;
        }
    }


    /*
     * ============================================================
     * Long 변환 Helper
     * ============================================================
     */

    /**
     * Object를 Long으로 변환한다.
     */
    private Long getLong(
            Object value) {

        if (value == null) {

            return null;
        }


        /*
         * Number 타입
         */
        if (value instanceof Number) {

            return ((Number) value).longValue();
        }


        /*
         * String 숫자
         */
        try {

            return Long.valueOf(
                value.toString()
            );

        } catch (Exception e) {

            return null;
        }
    }


    /*
     * ============================================================
     * 가격 포맷
     * ============================================================
     */

    /**
     * Steam 가격 숫자를 화면 표시용 문자열로 변환한다.
     *
     * 단, App Details API에서는
     * initial_formatted / final_formatted를
     * 우선 사용한다.
     */
    private String formatPrice(
            Object value) {

        /*
         * 가격 정보 없음
         */
        if (value == null) {

            return "가격 정보 없음";
        }


        /*
         * 문자열인 경우
         */
        if (value instanceof String) {

            String price =
                    value.toString().trim();


            if (price.isEmpty()) {

                return "가격 정보 없음";
            }


            return price;
        }


        /*
         * 숫자인 경우
         *
         * Steam의 initial/final 가격은
         * 최소 화폐 단위로 제공된다.
         */
        if (value instanceof Number) {

            long price =
                    ((Number) value).longValue();


            long won =
                    price / 100;


            return String.format(
                    "%,d원",
                    won
            );
        }


        /*
         * 그 외 타입
         */
        return String.valueOf(value);
    }
}