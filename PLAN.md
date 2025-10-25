# Vibe Water Tracker 개발 계획

이 문서는 `PRD.md`를 기반으로 프로젝트의 기술적인 설계와 구현 계획을 정의합니다.

## 1. 프로젝트 아키텍처

### 1.1. 폴더 구조 (Feature-based)

-   **`lib/src`**: 소스 코드의 루트 디렉토리입니다.
    -   **`features`**: 기능별 모듈을 관리합니다.
        -   `auth`: 사용자 인증 (스플래시, 로그인) 관련 코드를 포함합니다.
        -   `home`: 메인 화면 (물 마시기, 기록) 관련 코드를 포함합니다.
    -   **`core`**: 여러 기능에서 공통으로 사용하는 로직 및 위젯을 관리합니다.
        -   `router`: `go_router`를 사용한 화면 라우팅 설정을 담당합니다.
        -   `theme`: 앱의 전체적인 테마(색상, 폰트 등)를 정의합니다.
        -   `widgets`: 공통적으로 사용되는 커스텀 위젯을 포함합니다.
    -   **`data`**: 데이터 소스 및 모델을 관리합니다.
        -   `models`: Firestore와 통신하기 위한 데이터 모델(User, Intake 등)을 정의합니다.
        -   `repositories`: 데이터의 CRUD(생성, 읽기, 업데이트, 삭제) 로직을 추상화합니다.

### 1.2. 레이어 구성 (Layered Architecture)

-   **Presentation Layer**: UI와 상태 관리를 담당합니다. (Flutter Widgets, BLoC/Cubit)
-   **Domain Layer**: 앱의 핵심 비즈니스 로직을 포함합니다. (이번 프로젝트에서는 Repository가 일부 담당)
-   **Data Layer**: 데이터 소스(Firebase Auth, Firestore)와의 통신 및 데이터 처리를 담당합니다.

## 2. 데이터 모델 설계 (Firestore)

-   **`users` 컬렉션**:
    -   `{userId}` (문서):
        -   `uid` (String): Firebase Authentication에서 제공하는 고유 사용자 ID
        -   `email` (String): 사용자 이메일
        -   `displayName` (String): 사용자 이름
        -   `daily_intakes` (Map): 날짜별 물 섭취량 기록 (`{ "YYYY-MM-DD": amount (Number) }`)
-   **`global_stats` 컬렉션**:
    -   `total_intake` (문서):
        -   `totalAmount` (Number): 모든 사용자의 누적 섭취량 합계

## 3. 상태 관리 전략 (BLoC/Cubit)

-   **AuthCubit**: 사용자의 인증 상태(로그인/로그아웃)를 관리하여 앱의 전체적인 흐름을 제어합니다.
-   **IntakeCubit**: 사용자의 일일 물 섭취량 상태를 관리하고, Firestore와 데이터를 동기화합니다.
-   **StatsCubit**: 개인(일간, 주간, 월간) 및 전체 사용자의 통계 데이터를 불러와 관리합니다.

## 4. UI 화면 구성

-   **Splash Screen**: 앱 실행 시 사용자의 로그인 상태를 확인하고, 로그인 페이지 또는 홈 페이지로 자동 라우팅합니다.
-   **Login Screen**: "Google 계정으로 로그인" 버튼을 제공하여 Firebase 인증을 수행합니다.
-   **Home Screen**:
    -   **하단 탭 네비게이션 (`BottomNavigationBar`)**을 통해 두 개의 메인 화면을 전환합니다.
        1.  **물 마시기 (Water Intake Tab)**:
            -   오늘의 총 섭취량을 표시합니다.
            -   섭취량을 추가/감소시키는 버튼(+10ml, +30ml, +50ml, -30ml)을 제공합니다.
        2.  **기록 (Stats Tab)**:
            -   개인 통계 (오늘, 이번 주, 이번 달 마신 양)를 표시합니다.
            -   전체 사용자 누적 섭취량 (TMI)을 보여줍니다.
            -   로그아웃 버튼을 제공합니다.

## 5. 구현 순서 (우선순위별)

1.  **Phase 1: 프로젝트 기반 설정**
    -   Flutter 프로젝트 생성 및 Firebase 연동 (Android/iOS 설정 포함)
    -   `go_router`, `flutter_bloc` 등 주요 의존성 추가
    -   위에서 설계한 폴더 구조 생성 및 기본 라우팅 설정

2.  **Phase 2: 사용자 인증 기능**
    -   `AuthRepository` 및 `AuthCubit` 구현 (Google 로그인 로직)
    -   Splash Screen UI 및 라우팅 로직 구현
    -   Login Screen UI 및 Google 로그인 버튼 연동

3.  **Phase 3: 물 마시기 핵심 기능**
    -   Home Screen의 기본 구조 (탭 네비게이션) 구현
    -   Water Intake Tab UI 구현
    -   `IntakeRepository` 및 `IntakeCubit` 구현 (Firestore 데이터 연동)
    -   섭취량 추가/감소 기능 구현

4.  **Phase 4: 기록 및 통계 기능**
    -   Stats Tab UI 구현
    -   `StatsRepository` 및 `StatsCubit` 구현
    -   개인 및 전체 통계 데이터 조회 및 화면 표시
    -   로그아웃 기능 구현

5.  **Phase 5: 고도화 및 마무리**
    -   전체적인 UI/UX 다듬기
    -   코드 리팩토링 및 주석 추가
    -   (선택) 간단한 단위 테스트 또는 위젯 테스트 작성