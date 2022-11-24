import 'package:bicos_app/model/freelancer.dart';
import 'package:bicos_app/providers/freelancerProvider.dart';
import 'package:bicos_app/utils/freelancer_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/cliente.dart';
import '../../../providers/clientProvider.dart';
import '../../../utils/statusFree_User.dart';
import '../../../utils/tema.dart';
import '../../../utils/user_preferences.dart';

class InfoPessoais extends StatefulWidget {
  const InfoPessoais({Key? key}) : super(key: key);

  @override
  State<InfoPessoais> createState() => _InfoPessoaisState();
}

class _InfoPessoaisState extends State<InfoPessoais> {
  late int theme;
  late int status;
  late User user;
  late Freelancer freelancer;
  late TextEditingController emailController;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  void initState() {
    super.initState();
    user = UserPreferences.getUser();
    freelancer = FreelancerPreferences.getFreelancer();
    status = StatusFreeUser.getStatus();
    emailController = TextEditingController(
        text: status == 0 ? user.EmailUser : freelancer.EmailFr);
  }

  final GlobalKey<FormState> _formkey = GlobalKey();
  TextEditingController telefoneController = TextEditingController();

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

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
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
          'Informações pessoais',
          style: TextStyle(color: theme == 0 ? primaryColor : backColor),
        ),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              'Email',
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              onTap: () async {
                bool? showEmailEditor = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Theme(
                      data: ThemeData(dialogBackgroundColor: backColor),
                      child: AlertDialog(
                        title: Text(
                          'Email',
                          style: TextStyle(color: textColor),
                        ),
                        content: Form(
                          key: _formkey,
                          child: TextFormField(
                            controller: emailController,
                            style: TextStyle(color: textColor),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: textColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: textColor),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Insira um E-mail';
                              } else if (!RegExp(
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                  .hasMatch(value)) {
                                return 'Insira um E-mail válido';
                              } else if (status == 0
                                  ? value == user.EmailUser
                                  : value == freelancer.EmailFr) {
                                return 'Sem alteração de E-mail';
                              }
                              return null;
                            },
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                if (_formkey.currentState!.validate()) {
                                  status == 0
                                      ? context
                                          .read<ClienteProvider>()
                                          .updateEmailUser(emailController.text,
                                              user.idUser, context)
                                      : context
                                          .read<FreelancerProvider>()
                                          .updateEmailFreelancer(
                                              emailController.text,
                                              freelancer.idFr,
                                              context);
                                }
                              });
                            },
                            child: const Text('Salvar'),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              readOnly: true,
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
                hintText: status == 0 ? user.EmailUser : freelancer.EmailFr,
                hintStyle: TextStyle(fontSize: 16, color: textColor),
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
              'Telefone',
              style: TextStyle(fontSize: 16, color: textColor),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: telefoneController,
              onTap: () async {
                bool? showTelEditor = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Theme(
                      data: ThemeData(dialogBackgroundColor: backColor),
                      child: AlertDialog(
                        title: Text(
                          'Telefone',
                          style: TextStyle(color: textColor),
                        ),
                        content: TextFormField(
                          initialValue: user.TelUser,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textColor),
                            ),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () async {
                              context.read<ClienteProvider>().updateTelUser(
                                  telefoneController.text,
                                  user.idUser,
                                  context);
                              Navigator.of(context).pop();
                            },
                            child: const Text('Salvar'),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              readOnly: true,
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
                hintText: status == 0 ? user.TelUser : freelancer.TelFr,
                hintStyle: TextStyle(fontSize: 16, color: textColor),
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
    );
  }
}
