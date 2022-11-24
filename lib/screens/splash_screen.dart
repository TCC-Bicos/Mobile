import 'dart:async';

import 'package:bicos_app/model/freelancer.dart';
import 'package:bicos_app/utils/app_routes.dart';
import 'package:bicos_app/utils/freelancer_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cliente.dart';
import '../utils/tema.dart';
import '../utils/user_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late User user;
  late Freelancer freelancer;

  @override
  void initState() {
    user = UserPreferences.getUser();
    freelancer = FreelancerPreferences.getFreelancer();
    Timer(
        const Duration(seconds: 2),
        () => user.idUser == 0 ||
                user.idUser == null && freelancer.idFr == 0 ||
                freelancer.idFr == null
            ? Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRoutes.opening, (route) => false)
            : Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.navigationbar, (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<TemaApp>().getBackgroundColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/bicoslogo_azul.png',
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}
