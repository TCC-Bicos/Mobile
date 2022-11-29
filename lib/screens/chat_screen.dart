import 'package:bicos_app/components/chat/chat.dart';
import 'package:bicos_app/model/chat_users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/statusFree_User.dart';
import '../utils/tema.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        text: "Richarlison",
        secondaryText: "Você: Tudo bem",
        image: "assets/images/richarlison.png",
        time: "Hoje"),
    ChatUsers(
        text: "Shalgun",
        secondaryText: "Muito obrigado",
        image: "assets/images/shalgun.png",
        time: "Ontem"),
    ChatUsers(
        text: "Eruliko",
        secondaryText: "A logo pode ser um pouco maior?",
        image: "assets/images/eruliko.png",
        time: "25 Nov"),
    ChatUsers(
        text: "Quesheg",
        secondaryText: "Não aguento mais esse tcc",
        image: "assets/images/quesheg.png",
        time: "22 Nov"),
    ChatUsers(
        text: "Choi",
        secondaryText: "Bolsonaro",
        image: "assets/images/choi.png",
        time: "20 Nov"),
    ChatUsers(
        text: "Mousedesvio",
        secondaryText: "amogus sus sus amogus",
        image: "assets/images/mousedesvio.png",
        time: "20 Nov"),
    ChatUsers(
      text: "Amariano",
      secondaryText: ":)",
      image: "assets/images/amariano.png",
      time: "19 Nov",
    ),
    ChatUsers(
        text: "Roodorooraada",
        secondaryText: "Kauã Gabriel 15 anos",
        image: "assets/images/roodorooraada.png",
        time: "1 Nov"),
  ];

  late int theme;
  late int status;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  void initState() {
    super.initState();
    status = StatusFreeUser.getStatus();
  }

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
      body: Scaffold(
        backgroundColor: backColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Chats",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Procurar...",
                    hintStyle: TextStyle(color: secTextColor),
                    prefixIcon: Icon(
                      Icons.search,
                      color: primaryColor,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: status == 0
                        ? const Color.fromARGB(48, 65, 124, 175)
                        : const Color.fromARGB(47, 65, 175, 70),
                    contentPadding: const EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: primaryColor)),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ChatUsersList(
                    text: chatUsers[index].text,
                    secondaryText: chatUsers[index].secondaryText,
                    image: chatUsers[index].image,
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3) ? true : false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
