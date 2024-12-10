import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:shared_preferences/shared_preferences.dart";

import "providers/providers.dart";
import "screens/home/auth_widget.dart";
import "utils/colors.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontSize: 20),
            titleMedium: TextStyle(fontSize: 16),
            bodyLarge: TextStyle(fontSize: 16),
            bodyMedium: TextStyle(fontSize: 14),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              disabledBackgroundColor: AppColors.buttonDisabled,
              elevation: 2,
            ),
          ),
        ),
        home: const AuthWidget(),
      ),
    ),
  );
}
