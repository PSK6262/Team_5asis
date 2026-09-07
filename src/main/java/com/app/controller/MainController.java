package com.app.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.app.common.CommonCode;
import com.app.dto.api.SteamGame;
import com.app.dto.board.GameNameTransferForm;
import com.app.dto.user.UserInfo;
import com.app.service.api.SteamGameService;
import com.app.service.board.GameBoardService;
import com.app.service.user.UserService;


/**
 * ================================================================
 * 메인 페이지 Controller
 * ================================================================
 *
 * 메인 페이지에 필요한 데이터를 조회하여
 * main.jsp로 전달하는 역할을 담당한다.
 *
 * 현재 메인 페이지에서 사용하는 데이터
 *
 * 1. 인기 게임 TOP 6
 * 2. Steam 할인 게임 TOP 6
 * 3. Steam 랜덤 게임 TOP 6
 * 4. 로그인 사용자 정보
 * 5. 사용자 닉네임
 * 6. 사용자 프로필 이미지
 */
@Controller
public class MainController {


    /**
     * ============================================================
     * 기존 게임 게시판 Service
     * ============================================================
     *
     * DB에서 인기 게임 및 전체 게임 정보를 가져올 때 사용한다.
     */
    @Autowired
    GameBoardService gameBoardService;


    /**
     * ============================================================
     * 사용자 Service
     * ============================================================
     *
     * 로그인한 사용자의 프로필 정보를 조회할 때 사용한다.
     */
    @Autowired
    UserService userService;


    /**
     * ============================================================
     * Steam 게임 Service
     * ============================================================
     *
     * SteamGameServiceImpl을 통해 실제 Steam API를 호출한다.
     *
     * Controller에서는 API 호출 방법을 직접 알 필요가 없다.
     *
     * Controller
     *      ↓
     * SteamGameService
     *      ↓
     * SteamGameServiceImpl
     *      ↓
     * Steam API
     */
    @Autowired
    SteamGameService steamGameService;


    /**
     * ============================================================
     * 메인 페이지
     * ============================================================
     *
     * URL:
     *
     * /main
     *
     * 메인 페이지에 필요한 모든 데이터를 조회한 후
     * main.jsp로 전달한다.
     */
    @GetMapping("/main")
    public String vasis(
            Model model,
            HttpSession session) {


        // =========================================================
        // 1. 인기 게임 TOP 6 조회
        // =========================================================
        //
        // 기존 DB에서 인기 게임 6개를 조회한다.
        //
        // main.jsp에서는
        //
        // ${popularSixGames}
        //
        // 로 사용한다.
        // =========================================================

        List<GameNameTransferForm> popularSixGames =
                gameBoardService.findPopularSixGames();

        model.addAttribute(
                "popularSixGames",
                popularSixGames
        );


        // =========================================================
        // 2. 전체 게임 목록 조회
        // =========================================================
        //
        // 기존 메인 페이지에서 사용하던 전체 게임 목록이다.
        //
        // 다른 페이지 또는 기존 JavaScript에서 사용할 가능성이
        // 있으므로 기존 코드를 유지한다.
        // =========================================================

        List<GameNameTransferForm> allGames =
                gameBoardService.findAllGames();

        model.addAttribute(
                "games",
                allGames
        );


        // =========================================================
        // 3. Steam 할인 게임 조회
        // =========================================================
        //
        // SteamGameService를 통해 Steam API에서
        // 현재 할인 중인 게임을 가져온다.
        //
        // ServiceImpl 내부에서 최대 6개의 게임을 반환하도록
        // 구현되어 있다.
        // =========================================================

        List<SteamGame> steamDiscountGames =
                steamGameService.getDiscountGames();

        model.addAttribute(
                "steamDiscountGames",
                steamDiscountGames
        );


        // =========================================================
        // 4. Steam 랜덤 게임 조회
        // =========================================================
        //
        // SteamGameService에서 게임 목록을 가져온 후
        // 랜덤으로 6개의 게임을 선택한다.
        // =========================================================

        List<SteamGame> steamRandomGames =
                steamGameService.getRandomGames();

        model.addAttribute(
                "steamRandomGames",
                steamRandomGames
        );


        // =========================================================
        // 5. 로그인 사용자 정보 확인
        // =========================================================
        //
        // 로그인하지 않은 경우:
        //
        // LOGIN_USER     = null
        // LOGIN_USER_ID  = null
        //
        // 로그인한 경우:
        //
        // LOGIN_USER
        // LOGIN_USER_ID
        //
        // 가 Session에 저장되어 있다.
        // =========================================================

        UserInfo loginUser =
                (UserInfo) session.getAttribute(
                        "LOGIN_USER"
                );


        Long loginUserId =
                (Long) session.getAttribute(
                        "LOGIN_USER_ID"
                );


        // =========================================================
        // 6. 사이드바 기본값 설정
        // =========================================================
        //
        // 로그인하지 않았거나 프로필 이미지가 없는 경우
        // 기본 프로필 이미지를 사용한다.
        // =========================================================

        String nickname = "Guest";

        String profileImage =
                CommonCode.SIDEBAR_PROFILE_DEFAULT_IMAGE;


        // =========================================================
        // 7. 로그인 사용자 프로필 조회
        // =========================================================
        //
        // 로그인한 사용자라면 DB에서 프로필 정보를 조회한다.
        // =========================================================

        if (loginUser != null && loginUserId != null) {


            /**
             * DB에서 사용자 프로필 정보를 가져온다.
             */
            Map<String, Object> profileInfo =
                    userService.getUserProfile(
                            loginUserId
                    );


            /**
             * 로그인한 사용자의 닉네임을 사용한다.
             */
            nickname =
                    loginUser.getNickname();


            /**
             * ====================================================
             * 프로필 이미지 확인
             * ====================================================
             *
             * DB에 프로필 이미지가 존재하면
             *
             * URL_FILE_PATH
             *
             * 값을 사용한다.
             *
             * 이미지가 없으면 위에서 설정한
             * 기본 이미지를 그대로 사용한다.
             */
            if (profileInfo != null
                    && profileInfo.get("URL_FILE_PATH") != null) {

                profileImage =
                        profileInfo.get(
                                "URL_FILE_PATH"
                        ).toString();
            }


            /**
             * JSP에서 로그인 사용자 객체가
             * 필요할 수 있으므로 Model에 전달한다.
             */
            model.addAttribute(
                    "loginUser",
                    loginUser
            );


            /**
             * 개발 단계에서 실제 값을 확인하기 위한 로그.
             */
            System.out.println(
                    "닉네임: " + nickname
            );

            System.out.println(
                    "프로필 이미지: " + profileImage
            );
        }


        // =========================================================
        // 8. JSP에서 사용할 닉네임 전달
        // =========================================================

        model.addAttribute(
                "nickname",
                nickname
        );


        // =========================================================
        // 9. JSP에서 사용할 프로필 이미지 전달
        // =========================================================
        //
        // profileImage는 항상 String 형태의 이미지 URL이다.
        //
        // 따라서 JSP에서는
        //
        // ${profileImage}
        //
        // 로 바로 사용한다.
        // =========================================================

        model.addAttribute(
                "profileImage",
                profileImage
        );


        // =========================================================
        // 10. main.jsp 출력
        // =========================================================

        return "main";
    }
}