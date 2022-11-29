import 'package:bicos_app/model/freelancer.dart';
import 'package:bicos_app/providers/freelancerProvider.dart';
import 'package:bicos_app/utils/freelancer_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/cliente.dart';
import '../../../providers/clientProvider.dart';
import '../../../utils/statusFree_User.dart';
import '../../../utils/tema.dart';
import '../../../utils/user_preferences.dart';

class SenhaConfigs extends StatefulWidget {
  const SenhaConfigs({Key? key}) : super(key: key);

  @override
  State<SenhaConfigs> createState() => _SenhaConfigsState();
}

class _SenhaConfigsState extends State<SenhaConfigs> {
  late int theme;
  late int status;
  late User user;
  late Freelancer freelancer;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  void initState() {
    super.initState();
    user = UserPreferences.getUser();
    freelancer = FreelancerPreferences.getFreelancer();
    status = StatusFreeUser.getStatus();
  }

  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController senhaAtualController = TextEditingController();
  TextEditingController novaSenhaController = TextEditingController();
  TextEditingController confirmNovaSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    readTheme();

    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;
    Color secundaryColor = status == 0
        ? context.watch<TemaApp>().getSecundaryColorUser
        : context.watch<TemaApp>().getSecundaryColorFree;
    Color backColor = status == 0
        ? context.watch<TemaApp>().getBackgroundColorUser
        : context.watch<TemaApp>().getBackgroundColorFree;
    Color textColor = status == 0
        ? context.watch<TemaApp>().getTextColorUser
        : context.watch<TemaApp>().getTextColorFree;
    Color secTextColor = context.watch<TemaApp>().getSecundaryTextColor;

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  // status == 0
                  //     ? context.read<ClienteProvider>().checkPass(
                  //         user.EmailUser,
                  //         senhaAtualController.text,
                  //         novaSenhaController.text,
                  //         user.idUser,
                  //         context)
                  //     : context.read<FreelancerProvider>().checkPass(
                  //         freelancer.EmailFr,
                  //         senhaAtualController.text,
                  //         novaSenhaController.text,
                  //         freelancer.idFr,
                  //         context);

                  Fluttertoast.showToast(
                    msg: 'Senha atualizada',
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  Navigator.of(context).pop();
                }
              },
              icon: Icon(
                Icons.check,
                color: backColor,
                size: 30,
              ))
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme == 0 ? primaryColor : backColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: theme == 0
            ? const Color.fromARGB(255, 250, 253, 255)
            : secundaryColor,
        title: Text(
          'Senha',
          style: TextStyle(color: theme == 0 ? primaryColor : backColor),
        ),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'A senha deve conter pelo menos 8 carateres, letra maiúscula e minúscula, caractere especial e número',
                style: TextStyle(fontSize: 15, color: secTextColor),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Senha atual',
                style: TextStyle(fontSize: 16, color: textColor),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
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
                    return 'A senha deve conter pelo menos 8 carateres, letra maiúscula e minúscula, caractere especial e número';
                  }
                  return null;
                },
                controller: senhaAtualController,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  errorMaxLines: 4,
                  counterStyle: TextStyle(color: textColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: textColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: textColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 2,
                    bottom: 2,
                    left: 15,
                    right: 15,
                  ),
                ),
                style: TextStyle(fontSize: 16, color: textColor),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Nova senha',
                style: TextStyle(fontSize: 16, color: textColor),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
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
                controller: novaSenhaController,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  errorMaxLines: 4,
                  counterStyle: TextStyle(color: textColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: textColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: textColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 2,
                    bottom: 2,
                    left: 15,
                    right: 15,
                  ),
                ),
                style: TextStyle(fontSize: 16, color: textColor),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Confirme a nova senha',
                style: TextStyle(fontSize: 16, color: textColor),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor confirme a senha';
                  }
                  if (novaSenhaController.text !=
                      confirmNovaSenhaController.text) {
                    return 'As senhas devem ser iguais';
                  }
                  return null;
                },
                controller: confirmNovaSenhaController,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  counterStyle: TextStyle(color: textColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: textColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: textColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 2,
                    bottom: 2,
                    left: 15,
                    right: 15,
                  ),
                ),
                style: TextStyle(fontSize: 16, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
