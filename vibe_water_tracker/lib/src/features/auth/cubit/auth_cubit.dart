import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vibe_water_tracker/src/data/repositories/auth_repository.dart';
import 'package:vibe_water_tracker/src/features/auth/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription _userSubscription;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.unknown()) {
    _userSubscription = _authRepository.user.listen((user) {
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  Future<void> signInWithGoogle() async {
    await _authRepository.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
