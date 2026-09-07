package com.app.dto.api;

/**
 * ================================================================
 * SteamGame
 * ================================================================
 *
 * Steam에서 가져온 게임 1개의 정보를 저장하는 DTO(Data Transfer Object).
 *
 * Steam API에서 가져오는 게임 정보를 Controller와 JSP까지
 * 전달하기 위한 용도로 사용한다.
 *
 * 주요 사용 데이터
 *
 * 1. id
 *    - Steam 게임의 고유 App ID
 *    - 예: 730 = Counter-Strike 2
 *
 * 2. name
 *    - Steam 게임 이름
 *
 * 3. discountPercent
 *    - 현재 할인율
 *    - 예: 75 → 75% 할인
 *
 * 4. originalPrice
 *    - 할인 전 가격
 *
 * 5. finalPrice
 *    - 할인 후 가격
 *
 * 6. currency
 *    - 가격 통화
 *    - 한국 기준 KRW 등을 사용
 *
 * 7. headerImage
 *    - Steam에서 제공하는 게임 대표 이미지 URL
 *
 * 8. discounted
 *    - 현재 할인 중인지 여부
 *
 * 9. discountExpiration
 *    - 할인 종료 Unix Timestamp
 *
 * 이 DTO를 사용하면 JSP에서
 *
 * ${game.id}
 * ${game.name}
 * ${game.discountPercent}
 * ${game.originalPrice}
 * ${game.finalPrice}
 * ${game.headerImage}
 *
 * 와 같이 데이터를 사용할 수 있다.
 */
public class SteamGame {

    /**
     * Steam 게임의 고유 App ID.
     *
     * Steam Store URL을 만들 때 사용한다.
     *
     * 예:
     * https://store.steampowered.com/app/730/
     */
    private Long id;

    /**
     * Steam 게임 이름.
     *
     * 예:
     * Counter-Strike 2
     */
    private String name;

    /**
     * 게임 할인율.
     *
     * 예:
     * 50 → 50% 할인
     */
    private Integer discountPercent;

    /**
     * 할인 전 가격.
     *
     * 화면에 표시하기 편하도록 문자열로 관리한다.
     *
     * 예:
     * 32,000원
     */
    private String originalPrice;

    /**
     * 할인 후 최종 가격.
     *
     * 예:
     * 16,000원
     */
    private String finalPrice;

    /**
     * 가격의 통화 단위.
     *
     * 예:
     * KRW
     */
    private String currency;

    /**
     * Steam 게임 대표 이미지 URL.
     *
     * Steam API의 header_image 값을 저장한다.
     */
    private String headerImage;

    /**
     * 현재 게임이 할인 중인지 여부.
     *
     * true  → 할인 중
     * false → 할인하지 않음
     */
    private boolean discounted;

    /**
     * 할인 종료 시간.
     *
     * Steam API에서 Unix Timestamp 형태로 전달될 수 있다.
     *
     * 값이 없는 경우 null이 될 수 있다.
     */
    private Long discountExpiration;


    /**
     * 기본 생성자.
     *
     * Spring에서 DTO 객체를 생성하거나
     * JSON 데이터를 객체로 변환할 때 사용할 수 있도록
     * 기본 생성자를 만들어둔다.
     */
    public SteamGame() {
    }


    /**
     * 모든 필드를 한 번에 초기화할 수 있는 생성자.
     *
     * ServiceImpl에서 Steam API 데이터를 변환할 때
     * 편리하게 사용할 수 있다.
     */
    public SteamGame(
            Long id,
            String name,
            Integer discountPercent,
            String originalPrice,
            String finalPrice,
            String currency,
            String headerImage,
            boolean discounted,
            Long discountExpiration) {

        this.id = id;
        this.name = name;
        this.discountPercent = discountPercent;
        this.originalPrice = originalPrice;
        this.finalPrice = finalPrice;
        this.currency = currency;
        this.headerImage = headerImage;
        this.discounted = discounted;
        this.discountExpiration = discountExpiration;
    }


    /**
     * Steam 게임 ID 반환
     */
    public Long getId() {
        return id;
    }

    /**
     * Steam 게임 ID 설정
     */
    public void setId(Long id) {
        this.id = id;
    }


    /**
     * 게임 이름 반환
     */
    public String getName() {
        return name;
    }

    /**
     * 게임 이름 설정
     */
    public void setName(String name) {
        this.name = name;
    }


    /**
     * 할인율 반환
     */
    public Integer getDiscountPercent() {
        return discountPercent;
    }

    /**
     * 할인율 설정
     */
    public void setDiscountPercent(Integer discountPercent) {
        this.discountPercent = discountPercent;
    }


    /**
     * 할인 전 가격 반환
     */
    public String getOriginalPrice() {
        return originalPrice;
    }

    /**
     * 할인 전 가격 설정
     */
    public void setOriginalPrice(String originalPrice) {
        this.originalPrice = originalPrice;
    }


    /**
     * 할인 후 가격 반환
     */
    public String getFinalPrice() {
        return finalPrice;
    }

    /**
     * 할인 후 가격 설정
     */
    public void setFinalPrice(String finalPrice) {
        this.finalPrice = finalPrice;
    }


    /**
     * 통화 단위 반환
     */
    public String getCurrency() {
        return currency;
    }

    /**
     * 통화 단위 설정
     */
    public void setCurrency(String currency) {
        this.currency = currency;
    }


    /**
     * 게임 대표 이미지 URL 반환
     */
    public String getHeaderImage() {
        return headerImage;
    }

    /**
     * 게임 대표 이미지 URL 설정
     */
    public void setHeaderImage(String headerImage) {
        this.headerImage = headerImage;
    }


    /**
     * 할인 여부 반환
     */
    public boolean isDiscounted() {
        return discounted;
    }

    /**
     * 할인 여부 설정
     */
    public void setDiscounted(boolean discounted) {
        this.discounted = discounted;
    }


    /**
     * 할인 종료 시간 반환
     */
    public Long getDiscountExpiration() {
        return discountExpiration;
    }

    /**
     * 할인 종료 시간 설정
     */
    public void setDiscountExpiration(Long discountExpiration) {
        this.discountExpiration = discountExpiration;
    }
}