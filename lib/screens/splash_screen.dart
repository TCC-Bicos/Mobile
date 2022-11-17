import 'dart:async';

import 'package:bicos_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/tema.dart';

String? finalEmail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getValidationData().whenComplete(
      () async {
        Timer(
            const Duration(seconds: 2),
            () => finalEmail == null
                ? Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.opening, (route) => false)
                : Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.navigationbar, (route) => false));
      },
    );
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('emailValidation');
    setState(() {
      finalEmail = obtainedEmail;
    });
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
