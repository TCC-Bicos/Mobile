import 'dart:io';

import 'package:bicos_app/screens/chat_screen.dart';
import 'package:bicos_app/screens/profile_screen.dart';
import 'package:bicos_app/screens/trabalhos_screen.dart';
import 'package:bicos_app/screens/search_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';

import '../components/menu/modalMenu.dart';
import '../screens/home_screen.dart';

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
        return ModalMenu();
      },
    );
  }

  int index = 0;

  final screens = [
    const HomePage(),
    const ChatPage(),
    const SearchPage(),
    const TrabalhosScreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
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
        actions: index == 4
            ? [
                IconButton(
                  onPressed: () => _openMenuModal(context),
                  icon: Icon(Icons.menu, color: Theme.of(context).primaryColor),
                )
              ]
            : null,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Image.asset(
          'assets/images/bicoslogo_azul.png',
          fit: BoxFit.contain,
          height: 22,
        ),
        elevation: 1,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: (Colors.blue[800])!,
        height: 57,
        index: index,
        items: items,
        onTap: (index) => setState(() => this.index = index),
      ),
      body: screens[index],
    );
  }
}
