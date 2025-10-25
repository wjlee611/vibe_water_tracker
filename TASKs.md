# Vibe Water Tracker 작업 목록 (TASKs)

이 문서는 `PLAN.md`에 정의된 각 개발 단계를 구체적인 작업 항목으로 나누어 관리합니다. 완료된 항목은 `[x]`로 표시합니다.

## Phase 1: 프로젝트 기반 설정 (Foundation)

- [x] **1-1. FVM 설정:** `fvm use stable` 명령어로 Flutter 버전 고정
- [x] **1-2. 의존성 추가:** `pubspec.yaml` 파일에 다음 패키지 추가
  - `firebase_core`
  - `firebase_auth`
  - `cloud_firestore`
  - `google_sign_in`
  - `flutter_bloc`
  - `go_router`
- [x] **1-3. Firebase 프로젝트 설정:** Firebase 콘솔에서 신규 프로젝트 생성
- [ ] **1-4. Flutter 앱에 Firebase 연동:** `flutterfire configure` 명령어를 사용하여 iOS, Android 앱에 Firebase 설정 파일 추가
- [ ] **1-5. 기본 디렉토리 구조 생성:** `lib/src` 내부에 `core`, `data`, `domain`, `presentation` 디렉토리 생성
- [ ] **1-6. 기본 라우터 설정:** `go_router`를 사용하여 스플래시, 로그인, 홈 화면에 대한 기본 라우팅 경로 설정
- [ ] **1-7. Material 3 기반 앱 테마 설정:** `main.dart` 파일에 `ThemeData`를 사용하여 기본 컬러 스킴 및 텍스트 스타일 정의

## Phase 2: 사용자 인증 (Authentication)

- [ ] **2-1.** ...
- [ ] **2-2.** ...

## Phase 3: 핵심 기능 - 물 마시기 (Core Feature)

- [ ] **3-1.** ...
- [ ] **3-2.** ...

## Phase 4: 핵심 기능 - 기록 확인 (History)

- [ ] **4-1.** ...
- [ ] **4-2.** ...

## Phase 5: 테스트 및 배포 준비

- [ ] **5-1.** ...
- [ ] **5-2.** ...
