import 'package:bicos_app/components/login/loginUser/login_buttons.dart';
import 'package:bicos_app/providers/clientProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import '../utils/app_routes.dart';

class LoginUserScreen extends StatefulWidget {
  const LoginUserScreen({Key? key}) : super(key: key);

  @override
  State<LoginUserScreen> createState() => _LoginUserScreenState();
}

class _LoginUserScreenState extends State<LoginUserScreen> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  ClienteProvider _clientProvider = ClienteProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.2,
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.1),
                child: SizedBox(
                  width: 140,
                  child: Image.asset(
                    'assets/images/bicoslogo_azul.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  bottom: MediaQuery.of(context).size.height * 0.1,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: senhaController,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              LoginUserButtons(
                onPressed: onPressed,
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Ainda não tem uma conta? ',
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(AppRoutes.signup);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onPressed() {
    _clientProvider.loginCliente(
        emailController.text, senhaController.text, context);
  }
}
