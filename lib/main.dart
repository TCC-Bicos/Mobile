// @dart=2.9
import 'dart:ui';

import 'package:bicos_app/screens/edit_profile_screen.dart';
import 'package:bicos_app/screens/home_screen.dart';
import 'package:bicos_app/screens/login_screen.dart';
import 'package:bicos_app/screens/navigation_screen.dart';
import 'package:bicos_app/screens/profile_screen.dart';
import 'package:bicos_app/screens/signup_screen.dart';
import 'package:bicos_app/screens/welcome_screen.dart';
import 'package:bicos_app/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:bicos_app/utils/app_routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.amber),
        fontFamily: 'Inter',
        canvasColor: const Color.fromARGB(255, 250, 253, 255),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontSize: 20,
                fontFamily: 'Inter',
              ),
              titleMedium: const TextStyle(
                fontSize: 18,
                fontFamily: 'Inter',
              ),
            ),
      ),
      routes: {
        AppRoutes.opening: (ctx) => const WelcomeScreen(),
        AppRoutes.login: (ctx) => const LoginScreen(),
        AppRoutes.signup: (ctx) => const SignUpScreen(),
        AppRoutes.navigationbar: (ctx) => NavigationBarScreen(),
        AppRoutes.profile: (ctx) => const ProfilePage(),
        AppRoutes.editProfile: (ctx) => EditProfilePage(),
      },
    );
  }
}
