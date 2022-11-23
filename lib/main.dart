// @dart=2.9

import 'package:bicos_app/providers/anunUserProvider.dart';
import 'package:bicos_app/providers/clientProvider.dart';
import 'package:bicos_app/providers/freelancerProvider.dart';
import 'package:bicos_app/providers/servicosProvider.dart';
import 'package:bicos_app/screens/configs/conta/conta_configs_screen.dart';
import 'package:bicos_app/screens/configs/conta/infopessoais_screen.dart';
import 'package:bicos_app/screens/configs/theme_screen.dart';
import 'package:bicos_app/screens/edit_profile_screen.dart';
import 'package:bicos_app/screens/loginFreelancer_screen.dart';
import 'package:bicos_app/screens/loginUserFreelancer_screen.dart';
import 'package:bicos_app/screens/loginUser_screen.dart';
import 'package:bicos_app/screens/menu/configs.dart';
import 'package:bicos_app/screens/navigation_screen.dart';
import 'package:bicos_app/screens/novoAnuncio_Usuario_screen.dart';
import 'package:bicos_app/screens/novoAnuncio_Freelancer_screen.dart';
import 'package:bicos_app/screens/signup_screen.dart';
import 'package:bicos_app/screens/splash_screen.dart';
import 'package:bicos_app/screens/welcome_screen.dart';
import 'package:bicos_app/utils/freelancer_preferences.dart';
import 'package:bicos_app/utils/statusFree_User.dart';
import 'package:bicos_app/utils/tema.dart';
import 'package:bicos_app/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:bicos_app/utils/app_routes.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.init();
  await StatusFreeUser.init();
  await FreelancerPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClienteProvider()),
        ChangeNotifierProvider(create: (_) => FreelancerProvider()),
        ChangeNotifierProvider(create: (_) => AnunUserProvider()),
        ChangeNotifierProvider(create: (_) => TemaApp()),
        ChangeNotifierProvider(create: (_) => ServicosProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: const Color.fromARGB(255, 0, 38, 92)),
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
          AppRoutes.splashScreen: (ctx) => const SplashScreen(),
          AppRoutes.opening: (ctx) => const WelcomeScreen(),
          AppRoutes.loginAsFreeUser: (ctx) => const LoginFreeUserScreen(),
          AppRoutes.loginUser: (ctx) => const LoginUserScreen(),
          AppRoutes.loginFreelancer: (ctx) => const LoginFreelancerScreen(),
          AppRoutes.signup: (ctx) => const SignUpScreen(),
          AppRoutes.navigationbar: (ctx) => NavigationBarScreen(),
          AppRoutes.editProfile: (ctx) => EditProfilePage(),
          AppRoutes.novoAnuncioFreelancer: (ctx) =>
              const NovoAnuncioFreelancer(),
          AppRoutes.novoAnuncioUsuario: (ctx) => const NovoAnuncioUsuario(),
          AppRoutes.configs: (ctx) => const ConfigsScreen(),
          AppRoutes.contaConfigs: (ctx) => const ContaConfigs(),
          AppRoutes.infoPessoais: (ctx) => const InfoPessoais(),
          AppRoutes.tema: (ctx) => const ThemeScreen(),
        },
      ),
    );
  }
}
