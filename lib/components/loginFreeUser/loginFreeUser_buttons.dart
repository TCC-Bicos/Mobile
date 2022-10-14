import 'package:bicos_app/utils/app_routes.dart';
import 'package:bicos_app/utils/statusFree_User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginFreeUserButtons extends StatelessWidget {
  LoginFreeUserButtons({Key? key}) : super(key: key);

  StatusFreeUser _statusFreeUser = StatusFreeUser();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 260,
          child: TextButton(
            onPressed: () {
              _statusFreeUser.statusFreeUser = 0;
              Navigator.of(context).pushNamed(AppRoutes.loginUser);
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 24, 145, 250)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 24, 145, 250)),
                ),
              ),
            ),
            child: const Text(
              'Entrar como Cliente',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 260,
          child: TextButton(
            onPressed: () {
              _statusFreeUser.statusFreeUser = 1;
              Navigator.of(context).pushNamed(AppRoutes.loginFreelancer);
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 24, 145, 250)),
                ),
              ),
            ),
            child: const Text(
              'Entrar como Freelancer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
