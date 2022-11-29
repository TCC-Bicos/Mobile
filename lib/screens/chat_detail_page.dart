import 'package:bicos_app/model/chat_mensagem.dart';
import 'package:bicos_app/components/chat/chat_bubble.dart';
import 'package:bicos_app/components/chat/chat_detail_page_appbar.dart';
import 'package:bicos_app/model/items_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/statusFree_User.dart';
import '../utils/tema.dart';

enum MessageType {
  Sender,
  Receiver,
}

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late int theme;
  late int status;
  late List<ChatMensagem> chatMensagem;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  void initState() {
    super.initState();
    status = StatusFreeUser.getStatus();

    chatMensagem = [
      ChatMensagem(
          message: "Olá, Tudo bem?",
          type: status == 1 ? MessageType.Receiver : MessageType.Sender),
      ChatMensagem(
          message:
              "Primeiramente, no próximo jogo você consegue fazer 4 gols no primeiro tempo?",
          type: status == 1 ? MessageType.Receiver : MessageType.Sender),
      ChatMensagem(
          message: "Segundamente, como está o projeto?",
          type: status == 1 ? MessageType.Receiver : MessageType.Sender),
      ChatMensagem(
          message: "Boa tarde, contra Camarões vai ser fácil",
          type: status == 1 ? MessageType.Sender : MessageType.Receiver),
      ChatMensagem(
          message: "Estou trabalhando no projeto já",
          type: status == 1 ? MessageType.Sender : MessageType.Receiver),
      ChatMensagem(
          message: "Está em 30%",
          type: status == 1 ? MessageType.Sender : MessageType.Receiver),
      ChatMensagem(
          message: "Tudo bem",
          type: status == 1 ? MessageType.Receiver : MessageType.Sender),
    ];
  }

  List<ItemsMenu> itemsMenu = [
    ItemsMenu(text: "Fotos & Videos", icons: Icons.image, color: Colors.amber),
    ItemsMenu(
        text: "Documento", icons: Icons.insert_drive_file, color: Colors.blue),
  ];

  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Color(0xff737373),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    itemCount: itemsMenu.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: itemsMenu[index].color.shade50,
                            ),
                            height: 50,
                            width: 50,
                            child: Icon(
                              itemsMenu[index].icons,
                              size: 20,
                              color: itemsMenu[index].color.shade400,
                            ),
                          ),
                          title: Text(itemsMenu[index].text),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        });
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
      appBar: ChatDetailPageAppBar(),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: chatMensagem.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ChatBubble(
                chatMensagem: chatMensagem[index],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              height: 80,
              width: double.infinity,
              color: const Color.fromARGB(255, 196, 196, 196),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showModal();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 21,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Type message...",
                          hintStyle: TextStyle(color: secTextColor),
                          border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 80,
              padding: const EdgeInsets.only(right: 16),
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: primaryColor,
                elevation: 0,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
