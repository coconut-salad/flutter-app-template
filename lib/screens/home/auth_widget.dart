import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../providers/providers.dart";
import "../login/login.dart";
import "home.dart";

class AuthWidget extends ConsumerWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(languageProvider);
    final isAuthenticatedAsyncValue = ref.watch(isAuthenticatedProvider);

    return PopScope(
      canPop: false,
      child: isAuthenticatedAsyncValue.when(
        data: (isAuthenticated) {
          if (isAuthenticated) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (error, stackTrace) => Scaffold(
          body: Center(
            child: Text(
              language.translate("An error occurred. Please try again."),
            ),
          ),
        ),
      ),
    );
  }
}
