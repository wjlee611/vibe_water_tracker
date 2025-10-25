import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_water_tracker/src/features/auth/cubit/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthCubit>().signInWithGoogle();
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
