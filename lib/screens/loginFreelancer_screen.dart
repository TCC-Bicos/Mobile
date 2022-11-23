import 'package:bicos_app/providers/freelancerProvider.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../components/login/login_buttons.dart';
import 'package:brasil_fields/brasil_fields.dart' as brasil_fields;
import '../utils/app_routes.dart';

class LoginFreelancerScreen extends StatefulWidget {
  const LoginFreelancerScreen({Key? key}) : super(key: key);

  @override
  State<LoginFreelancerScreen> createState() => _LoginFreelancerScreenState();
}

class _LoginFreelancerScreenState extends State<LoginFreelancerScreen> {
  final cpfController = TextEditingController();
  final senhaController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
          child: Form(
            key: _formkey,
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
                      TextFormField(
                        controller: cpfController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          brasil_fields.CpfInputFormatter(),
                        ],
                        decoration: const InputDecoration(
                          hintText: 'CPF',
                          hintStyle: TextStyle(fontSize: 16),
                        ),
                        style: const TextStyle(fontSize: 16),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Por favor insira um CPF";
                          }
                          if (!CPFValidator.isValid(value)) {
                            return "Por favor insira um CPF válido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: senhaController,
                        decoration: const InputDecoration(
                          hintText: 'Senha',
                          hintStyle: TextStyle(fontSize: 16),
                          errorMaxLines: 4,
                        ),
                        style: const TextStyle(fontSize: 16),
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor insira uma senha';
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return 'A senha deve conter 8 carateres, letra maiúscula e minúscula, caractere especial e número';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                LoginButtons(
                  onPressed: () {
                    setState(() {
                      if (_formkey.currentState!.validate()) {
                        onPressed();
                      }
                    });
                  },
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
      ),
    );
  }

  void onPressed() {
    context
        .read<FreelancerProvider>()
        .loginFreelancer(cpfController.text, senhaController.text, context);
  }
}
