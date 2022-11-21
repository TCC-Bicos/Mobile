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
        text: "Ogaua",
        secondaryText: "Trabaia",
        image: "assets/images/ogaua.png",
        time: "Agora"),
    ChatUsers(
        text: "Shalgun",
        secondaryText: "Aram?",
        image: "assets/images/shalgun.png",
        time: "Ontem"),
    ChatUsers(
        text: "Eruliko",
        secondaryText: "Bora lol?",
        image: "assets/images/eruliko.png",
        time: "18 Dez"),
    ChatUsers(
        text: "Quesheg",
        secondaryText: "Olha esse vídeo aqui",
        image: "assets/images/quesheg.png",
        time: "17 Dez"),
    ChatUsers(
        text: "Choi",
        secondaryText: "Bora sair esse fds?",
        image: "assets/images/choi.png",
        time: "Ontem"),
    ChatUsers(
        text: "Mousedesvio",
        secondaryText: "amogus sus sus amogus",
        image: "assets/images/mousedesvio.png",
        time: "1 Nov"),
    ChatUsers(
      text: "Amariano",
      secondaryText: ":)",
      image: "assets/images/amariano.png",
      time: "Ontem",
    ),
    ChatUsers(
        text: "Roodorooraada",
        secondaryText: "Kof",
        image: "assets/images/roodorooraada.png",
        time: "18 Dez"),
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
                      Container(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 2, bottom: 2),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: secundaryColor,
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: primaryColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Novo",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: textColor),
                            ),
                          ],
                        ),
                      )
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
