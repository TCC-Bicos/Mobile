import 'dart:io';

import 'package:bicos_app/screens/chat_screen.dart';
import 'package:bicos_app/screens/profile_screen.dart';
import 'package:bicos_app/screens/trabalhos_screen.dart';
import 'package:bicos_app/screens/search_screen.dart';
import 'package:bicos_app/utils/tema.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:provider/provider.dart';

import '../components/menu/modalMenu.dart';
import '../screens/home_screen.dart';
import '../utils/statusFree_User.dart';

class NavigationBarScreen extends StatefulWidget {
  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  _openMenuModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) {
        return const ModalMenu();
      },
    );
  }

  int index = 0;

  final screens = [
    const HomePage(),
    ChatScreen(),
    const SearchPage(),
    const TrabalhosScreen(),
    const ProfilePage(),
  ];

  late int theme;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  Widget build(BuildContext context) {
    readTheme();

    int status = context.watch<StatusFreeUser>().getStatus;
    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;
    Color secundaryColor = status == 0
        ? context.watch<TemaApp>().getSecundaryColorUser
        : context.watch<TemaApp>().getSecundaryColorFree;

    final items = <Widget>[
      const Icon(
        Icons.home,
        size: 30,
        color: Color.fromARGB(255, 250, 253, 255),
      ),
      const Icon(
        Icons.chat,
        size: 30,
        color: Color.fromARGB(255, 250, 253, 255),
      ),
      const Icon(
        Icons.search,
        size: 30,
        color: Color.fromARGB(255, 250, 253, 255),
      ),
      const Icon(
        Icons.archive,
        size: 30,
        color: Color.fromARGB(255, 250, 253, 255),
      ),
      const Icon(
        Icons.account_circle,
        size: 30,
        color: Color.fromARGB(255, 250, 253, 255),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: index == 4
            ? [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: theme == 0 ? primaryColor : Colors.white,
                    size: 28,
                  ),
                ),
                IconButton(
                  onPressed: () => _openMenuModal(context),
                  icon: Icon(
                    Icons.menu,
                    color: theme == 0 ? primaryColor : Colors.white,
                    size: 28,
                  ),
                )
              ]
            : [
                IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.notifications,
                    color: theme == 0 ? primaryColor : Colors.white,
                    size: 28,
                  ),
                ),
              ],
        leading: null,
        centerTitle: true,
        backgroundColor: theme == 0 ? Colors.white : secundaryColor,
        title: Image.asset(
          status == 0
              ? theme == 0
                  ? 'assets/images/bicoslogo_azul.png'
                  : 'assets/images/bicoslogo.png'
              : theme == 0
                  ? 'assets/images/bicoslogo_verde.png'
                  : 'assets/images/bicoslogo.png',
          fit: BoxFit.contain,
          height: 22,
        ),
        elevation: 1,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: theme == 0 ? primaryColor : secundaryColor,
        backgroundColor: (theme == 0 ? secundaryColor : primaryColor),
        height: 57,
        index: index,
        items: items,
        onTap: (index) => setState(() => this.index = index),
      ),
      body: IndexedStack(
        index: index,
        children: screens,
      ),
    );
  }
}
