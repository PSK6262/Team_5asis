<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>5ASIS</title>


    <!-- ============================================================
         Bootstrap
         ============================================================
         
         현재 메인 페이지에서 Bootstrap의 기본 기능을 사용할 수 있도록
         CDN을 연결한다.
         
         메인 카드 레이아웃은 우리가 직접 작성한 CSS를 사용하므로
         Bootstrap의 Grid에 의존하지 않는다.
         ============================================================ -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB"
        crossorigin="anonymous">


    <!-- ============================================================
         메인 페이지 CSS
         ============================================================
         
         메인 페이지의 전체 레이아웃과
         게임 카드 디자인을 담당한다.
         ============================================================ -->

    <link
        href="${pageContext.request.contextPath}/resources/css/main.css"
        rel="stylesheet"
        type="text/css">


    <!-- ============================================================
         Navbar CSS
         ============================================================
         
         기존 Navbar의 디자인을 담당한다.
         
         메인 페이지 CSS와 분리해서 관리하기 때문에
         메인 페이지의 카드 스타일을 수정해도
         Navbar에 영향을 주지 않는다.
         ============================================================ -->

    <link
        href="${pageContext.request.contextPath}/resources/css/navbar.css"
        rel="stylesheet"
        type="text/css">


    <!-- ============================================================
         Sidebar CSS
         ============================================================
         
         기존 Sidebar의 디자인을 담당한다.
         
         메인 페이지의 게임 카드 레이아웃과
         Sidebar의 스타일을 분리해서 관리한다.
         ============================================================ -->

    <link
        href="${pageContext.request.contextPath}/resources/css/sidebar.css"
        rel="stylesheet"
        type="text/css">

</head>


<body>


    <!-- ============================================================
         메인 페이지 전체 컨테이너
         ============================================================
         
         이 영역은 Navbar / Sidebar / Main Content를
         하나의 페이지 구조로 묶는다.
         
         CSS의 Grid Layout을 이용해서
         
         ┌──────────────────────────────┐
         │           Navbar             │
         ├──────────┬───────────────────┤
         │ Sidebar  │    Main Content   │
         │          │                   │
         └──────────┴───────────────────┘
         
         구조를 유지한다.
         ============================================================ -->

    <div class="main_container">


        <!-- ========================================================
             Navbar 영역
             ========================================================
             
             기존 Navbar JSP를 그대로 include한다.
             
             ⚠️ Navbar 코드를 여기서 직접 수정하지 않는다.
             ======================================================== -->

        <header class="main_header">

            <jsp:include page="common/navbar.jsp" />

        </header>


        <!-- ========================================================
             Sidebar 영역
             ========================================================
             
             기존 Sidebar JSP를 그대로 include한다.
             
             프로필 이미지와 닉네임은
             Controller에서 전달한
             
             ${profileImage}
             ${nickname}
             
             값을 Sidebar에서 사용한다.
             ======================================================== -->

        <aside class="main_sidebar">

            <jsp:include page="common/sidebar.jsp" />

        </aside>


        <!-- ========================================================
             메인 콘텐츠 영역
             ========================================================
             
             실제 게임 목록이 표시되는 영역이다.
             
             Navbar와 Sidebar와 별도의 영역으로 구성하기 때문에
             게임 카드 CSS가 기존 레이아웃에 영향을 주지 않는다.
             ======================================================== -->

        <main class="main_content">


            <!-- ====================================================
                 1. 인기 게임 TOP 6
                 ====================================================
                 
                 DB에서 조회한 인기 게임 6개를 출력한다.
                 
                 Controller:
                 
                 popularSixGames
                 
                 ↓
                 
                 JSP:
                 
                 ${popularSixGames}
                 ==================================================== -->

            <section class="game-section">


                <!-- 섹션 제목 -->

                <h2 class="game-section-title">

                    🔥 인기 게임 TOP 6

                </h2>


                <!-- ==================================================
                     게임 카드 Grid
                     ==================================================
                     
                     CSS에서
                     
                     grid-template-columns:
                     repeat(3, ...);
                     
                     를 사용하기 때문에
                     
                     3개씩 한 줄에 배치된다.
                     
                     총 6개라면
                     
                     1  2  3
                     4  5  6
                     
                     형태가 된다.
                     ================================================== -->

                <div class="game-card-container">


                    <!-- 인기 게임 목록 반복 -->

                    <c:forEach
                        var="game"
                        items="${popularSixGames}">


                        <!-- ==================================================
                             인기 게임 카드
                             ==================================================
                             
                             카드를 클릭하면
                             기존 인기 게임 클릭 이벤트를 실행한다.
                             ================================================== -->

                        <div
                            class="game-card"
                            onclick="popularGamesOnclickEvent('${game.gameAlias}')">


                            <!-- 게임 이미지 -->

                            <img
                                src="${game.gameImage}"
                                alt="${game.gameName}">


                            <!-- 게임 이름 -->

                            <div class="game-card-name">

                                ${game.gameName}

                            </div>

                        </div>

                    </c:forEach>

                </div>

            </section>



            <!-- ====================================================
                 2. Steam 할인 게임
                 ====================================================
                 
                 Steam API에서 가져온 할인 게임을 출력한다.
                 
                 Controller:
                 
                 steamDiscountGames
                 
                 ↓
                 
                 JSP:
                 
                 ${steamDiscountGames}
                 ==================================================== -->

            <section class="game-section">


                <!-- 섹션 제목 -->

                <h2 class="game-section-title">

                    💸 STEAM 할인 게임

                </h2>


                <!-- ==================================================
                     Steam 할인 게임 Grid
                     ==================================================
                     
                     인기 게임과 동일하게
                     
                     3열 × 2행
                     
                     구조를 사용한다.
                     ================================================== -->

                <div class="game-card-container steam-card-container">


                    <!-- Steam 할인 게임 반복 -->

                    <c:forEach
                        var="game"
                        items="${steamDiscountGames}">


                        <!-- ==================================================
                             Steam 할인 게임 카드
                             ==================================================
                             
                             카드를 클릭하면 Steam Store의
                             해당 게임 페이지로 이동한다.
                             ================================================== -->

                        <div
                            class="steam-game-card"
                            onclick="location.href='https://store.steampowered.com/app/${game.id}/?cc=KR&l=koreana'">


                            <!-- Steam 게임 대표 이미지 -->

                            <img
                                src="${game.headerImage}"
                                alt="${game.name}">


                            <!-- Steam 게임 정보 -->

                            <div class="steam-game-info">


                                <!-- 게임 이름 -->

                                <div class="steam-game-name">

                                    ${game.name}

                                </div>


                                <!-- ==================================================
                                     가격 정보
                                     ==================================================
                                     
                                     할인율
                                     할인 전 가격
                                     할인 후 가격
                                     
                                     순서로 출력한다.
                                     ================================================== -->

                                <div class="steam-game-price">


                                    <!-- 할인율 -->

                                    <c:if test="${game.discountPercent > 0}">

                                        <span class="discount-percent">

                                            -${game.discountPercent}%

                                        </span>

                                    </c:if>


                                    <!-- 할인 전 가격 -->

                                    <c:if test="${not empty game.originalPrice}">

                                        <span class="original-price">

                                            ${game.originalPrice}

                                        </span>

                                    </c:if>


                                    <!-- 할인 후 가격 -->

                                    <span class="final-price">

                                        ${game.finalPrice}

                                    </span>

                                </div>

                            </div>

                        </div>

                    </c:forEach>

                </div>

            </section>

        </main>

    </div>


    <!-- ============================================================
         메인 페이지 JavaScript
         ============================================================
         
         인기 게임 클릭 이벤트 등 기존 기능을 유지하기 위해
         삭제하지 않는다.
         ============================================================ -->

    <script
        type="text/javascript"
        src="${pageContext.request.contextPath}/resources/js/main.js">
    </script>


</body>

</html>