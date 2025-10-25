# Vibe Water Tracker 작업 목록 (TASKs)

이 문서는 `PLAN.md`에 정의된 개발 계획을 구체적인 작업 단위로 나누어 관리합니다.

**상태 표시:**
- [ ] 미완료
- [~] 진행 중
- [x] 완료

---

### Phase 1: 프로젝트 기반 설정

- [x] Flutter 프로젝트 생성 및 Firebase 연동 (Android/iOS)
- [x] `go_router`, `flutter_bloc`, `firebase_core`, `firebase_auth`, `cloud_firestore`, `google_sign_in` 의존성 추가
- [x] `lib/src` 내부에 `core`, `data`, `features` 디렉토리 구조 생성
- [x] `core/router.dart` 기본 라우팅 설정
- [x] `core/theme.dart` 기본 앱 테마 설정

### Phase 2: 사용자 인증 기능

- [x] `data/repositories/auth_repository.dart` 구현 (Google 로그인/로그아웃)
- [x] `features/auth/cubit/auth_cubit.dart` 구현 (인증 상태 관리)
- [x] `features/auth/views/splash_screen.dart` UI 및 라우팅 로직 구현
- [x] `features/auth/views/login_screen.dart` UI 및 Google 로그인 연동

### Phase 3: 물 마시기 핵심 기능

- [x] `features/home/views/home_screen.dart` 기본 구조 구현 (하단 탭 네비게이션)
- [x] `features/home/views/water_intake_tab.dart` UI 구현
- [x] `data/models/user_model.dart`, `intake_model.dart` 데이터 모델 정의
- [x] `data/repositories/intake_repository.dart` 구현 (Firestore 데이터 CRUD)
- [x] `features/home/cubit/intake_cubit.dart` 구현 (섭취량 상태 관리)
- [x] 섭취량 추가/감소 기능 구현 및 Firestore 연동

### Phase 4: 기록 및 통계 기능

- [ ] `features/home/views/stats_tab.dart` UI 구현
- [ ] `data/repositories/stats_repository.dart` 구현 (통계 데이터 조회)
- [ ] `features/home/cubit/stats_cubit.dart` 구현 (통계 상태 관리)
- [ ] 개인 통계 (오늘, 주간, 월간) 조회 및 표시 기능 구현
- [ ] 전체 사용자 누적 섭취량 조회 및 표시 기능 구현
- [ ] 로그아웃 기능 구현

### Phase 5: 고도화 및 마무리

- [ ] 전체적인 UI/UX 개선 및 디자인 다듬기
- [ ] 코드 리팩토링 및 불필요한 코드 제거
- [ ] (선택) 주요 로직에 대한 단위 테스트 코드 작성
- [ ] (선택) 주요 위젯에 대한 위젯 테스트 코드 작성