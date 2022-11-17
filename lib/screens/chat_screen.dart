import 'package:bicos_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'dart:ui';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Column(
          children: [
            _top(),
            _body(),
          ],
        ),
      ),
    );
  }

  Widget _top() {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fale sobre \nseus trabalhos',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black12,
                ),
                child: const Icon(
                  Icons.search,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Avatar(
                        margin: const EdgeInsets.only(right: 15),
                        image: 'assets/images/${index + 1}.jpg',
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          color: Colors.white,
        ),
        child: ListView(
          padding: const EdgeInsets.only(top: 35),
          physics: const BouncingScrollPhysics(),
          children: [
            _itemChats(
              avatar: 'assets/images/2.jpg',
              name: 'Johnny Doe',
              chat:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
              time: '08.10',
            ),
            _itemChats(
              avatar: 'assets/images/4.jpg',
              name: 'Adrian',
              chat: 'Excepteur sint occaecat cupidatat non proident',
              time: '03.19',
            ),
            _itemChats(
              avatar: 'assets/images/5.jpg',
              name: 'Fiona',
              chat: 'Hii... 😎',
              time: '02.53',
            ),
            _itemChats(
              avatar: 'assets/images/6.jpg',
              name: 'Emma',
              chat: 'Consectetur adipiscing elit',
              time: '11.39',
            ),
            _itemChats(
              avatar: 'assets/images/7.jpg',
              name: 'Alexander',
              chat:
                  'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur',
              time: '00.09',
            ),
            _itemChats(
              avatar: 'assets/images/8.jpg',
              name: 'Alsoher',
              chat:
                  'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur',
              time: '00.09',
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemChats(
      {String avatar = '', name = '', chat = '', time = '00.00'}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.chat);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        elevation: 0,
        child: Row(
          children: [
            Avatar(
              margin: const EdgeInsets.only(right: 20),
              size: 60,
              image: avatar,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$name',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$time',
                        style: const TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$chat',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Avatar extends StatelessWidget {
  final double size;
  final image;
  final EdgeInsets margin;
  const Avatar(
      {Key? key,
      this.image,
      this.size = 50,
      this.margin = const EdgeInsets.all(0)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
