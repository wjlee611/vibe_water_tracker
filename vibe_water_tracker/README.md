# Vibe Water Tracker - 해커톤 발표 자료

![Vibe Water Tracker Banner](https://via.placeholder.com/1200x300.png?text=Vibe+Water+Tracker)

> 매일 물 마시는 습관을 즐겁게, Vibe Water Tracker와 함께 건강한 수분 섭취를 시작하세요.

---

## 1. 프로젝트 소개 (Introduction)

### 🎯 목표
일상 속에서 가장 중요하지만 잊기 쉬운 '물 마시기'를 사용자가 꾸준히 실천하고 건강한 습관으로 만들도록 돕는 것을 목표로 합니다. 단순히 마신 양을 기록하는 것을 넘어, 통계를 통해 성취감을 부여하고 전체 사용자와의 연결을 통해 동기를 부여합니다.

### 🤔 왜 만들었나요? (Motivation)
많은 사람들이 건강을 위해 충분한 수분 섭취의 중요성을 알지만, 바쁜 일상에 치여 꾸준히 실천하기는 어렵습니다. Vibe Water Tracker는 직관적인 UI와 간편한 기록 방식을 제공하여 사용자가 스트레스 없이 수분 섭취량을 추적하고, 자신의 기록을 보며 즐거움을 느낄 수 있도록 설계되었습니다.

---

## 2. 주요 기능 (Key Features)

-   **💧 간편한 수분 섭취 기록**: 버튼 몇 번의 터치로 간편하게 마신 물의 양을 기록하고 오늘의 총 섭취량을 실시간으로 확인할 수 있습니다.
-   **👤 Google 소셜 로그인**: 복잡한 회원가입 절차 없이 사용하던 Google 계정으로 즉시 앱 사용을 시작할 수 있습니다.
-   **📊 개인 통계 확인**: 일간, 주간, 월간 섭취량 통계를 통해 자신의 수분 섭취 패턴을 한눈에 파악하고 목표 달성에 대한 성취감을 느낄 수 있습니다.
-   **🌍 TMI (Total Member Intake)**: 나뿐만 아니라 앱을 사용하는 모든 유저들의 누적 섭취량을 확인하며 함께 건강한 습관을 만들어나가는 재미를 느낄 수 있습니다.

---

## 3. 앱 화면 (Screenshots)

| 스플래시 & 로그인 | 물 마시기 탭 | 기록 탭 |
| :---: | :---: | :---: |
| ![Splash & Login](https://via.placeholder.com/300x600.png?text=Splash+%26+Login+Screen) | ![Intake Tab](https://via.placeholder.com/300x600.png?text=Water+Intake+Screen) | ![Stats Tab](https://via.placeholder.com/300x600.png?text=Statistics+Screen) |
| 앱 실행 시 자동 로그인 상태를 확인하고, Google 계정으로 간편하게 로그인합니다. | 오늘의 섭취량을 확인하고 버튼을 눌러 간편하게 마신 물의 양을 추가하거나 뺄 수 있습니다. | 일간/주간/월간 개인 통계와 전체 사용자 누적 섭취량을 확인합니다. |

---

## 4. 기술 아키텍처 (Technical Architecture)

### 🏗️ 폴더 구조 (Feature-based Architecture)
유지보수성과 확장성을 높이기 위해 기능별로 코드를 분리하는 **Feature-based 아키텍처**를 채택했습니다.
- **`features`**: `auth`(인증), `home`(메인) 등 각 기능별 UI와 상태 관리 로직을 포함합니다.
- **`data`**: `repositories`를 두어 Firestore와의 데이터 통신 로직을 추상화했습니다.
- **`core`**: `router`, `theme` 등 여러 기능에서 공통으로 사용하는 핵심 모듈을 관리합니다.

### 🔄 상태 관리 (State Management)
**BLoC (Cubit)** 패턴을 사용하여 UI와 비즈니스 로직을 명확하게 분리했습니다.
- **`AuthCubit`**: 사용자의 로그인/로그아웃 등 인증 상태를 관리합니다.
- **`IntakeCubit`**: 일일 물 섭취량의 상태를 관리하고 Firestore와 실시간으로 동기화합니다.
- **`StatsCubit`**: 개인 및 전체 통계 데이터를 불러오고 관리하며, `IntakeCubit`의 변경에 반응합니다.

### ☁️ 데이터 모델 (Data Model on Firestore)
- **`users` 컬렉션**: 사용자별 정보와 날짜별(`YYYY-MM-DD`) 섭취 기록을 저장합니다.
- **`global_stats` 컬렉션**: 모든 사용자의 누적 섭취량을 저장하여 TMI 기능을 구현합니다.

---

## 5. 기술 스택 (Tech Stack)

-   **Framework**: Flutter
-   **Backend & DB**: Firebase (Authentication, Firestore)
-   **State Management**: `flutter_bloc` (Cubit)
-   **Routing**: `go_router`
-   **Authentication**: `google_sign_in`

---

## 6. 해커톤 진행 과정 (Development Journey)

-   **Phase 1: 프로젝트 기반 설정 완료**
    -   Flutter 프로젝트 생성 및 Firebase 연동, 주요 의존성 설정 및 폴더 구조 설계
-   **Phase 2: 사용자 인증 기능 완료**
    -   Google 소셜 로그인/로그아웃 기능 및 Splash/Login 화면 구현
-   **Phase 3: 물 마시기 핵심 기능 완료**
    -   Home 화면의 탭 네비게이션 구조 구현 및 섭취량 기록 UI/기능 구현
-   **Phase 4: 기록 및 통계 기능 완료**
    -   개인/전체 통계 UI 구현 및 Firestore 데이터 연동 완료

---

## 7. 향후 개선 계획 (Future Plans)

-   **푸시 알림**: 사용자가 설정한 시간에 물 마시기를 잊지 않도록 리마인더 알림 기능 추가
-   **목표 설정 및 달성률 표시**: 개인별 일일 목표 섭취량을 설정하고 달성률을 시각적으로 보여주는 기능
-   **게이미피케이션**: 연속 달성일, 뱃지 등 게임 요소를 도입하여 동기 부여 강화
-   **UI/UX 고도화**: 차트 라이브러리를 도입하여 통계 데이터를 더욱 다채롭게 시각화

---

## 🚀 실행 방법 (Getting Started)

1.  **Clone the repository:**
    ```bash
    git clone https://repository.url/vibe_water_tracker.git
    cd vibe_water_tracker
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    ```bash
    flutter run
    ```