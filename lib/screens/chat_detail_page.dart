import 'package:bicos_app/model/chat_mensagem.dart';
import 'package:bicos_app/components/chat/chat_bubble.dart';
import 'package:bicos_app/components/chat/chat_detail_page_appbar.dart';
import 'package:bicos_app/model/items_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MessageType {
  Sender,
  Receiver,
}

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMensagem> chatMensagem = [
    ChatMensagem(message: "Oi Kof", type: MessageType.Receiver),
    ChatMensagem(message: "Ta trabaiando?", type: MessageType.Receiver),
    ChatMensagem(message: "Oi gaua to sim e vc?", type: MessageType.Sender),
    ChatMensagem(message: "Tbm to", type: MessageType.Receiver),
    ChatMensagem(message: "Blz ent", type: MessageType.Sender),
  ];

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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Container(
                      height: 4,
                      width: 50,
                      color: Colors.grey.shade200,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    itemCount: itemsMenu.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
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
    return Scaffold(
      appBar: ChatDetailPageAppBar(),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: chatMensagem.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ChatBubble(
                chatMensagem: chatMensagem[index],
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
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
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Type message...",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
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
              padding: EdgeInsets.only(right: 30, bottom: 50),
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                backgroundColor: Color.fromARGB(255, 30, 192, 233),
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
