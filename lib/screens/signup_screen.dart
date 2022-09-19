import 'package:bicos_app/components/signup/signup_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 250, 253, 255),
        title: Image.asset(
          'assets/images/bicoslogo_azul.png',
          fit: BoxFit.contain,
          height: 22,
        ),
        elevation: 1,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: SizedBox(
                    child: Text(
                      'Criar conta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        fontSize: 32,
                        color: Color.fromARGB(255, 0, 38, 92),
                      ),
                    ),
                  ),
                ),
                SignupStepper(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
