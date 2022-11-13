import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../utils/statusFree_User.dart';
import '../utils/tema.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int index = 0;

  final searchController = TextEditingController();

  void clearText() {
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    int status = context.watch<StatusFreeUser>().getStatus;
    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;
    Color secundaryColor = status == 0
        ? context.watch<TemaApp>().getSecundaryColorUser
        : context.watch<TemaApp>().getSecundaryColorFree;
    Color textColor = status == 0
        ? context.watch<TemaApp>().getTextColorUser
        : context.watch<TemaApp>().getTextColorFree;
    Color secTextColor = context.watch<TemaApp>().getSecundaryTextColor;

    return Container(
      color: status == 0
          ? context.watch<TemaApp>().getBackgroundColorUser
          : context.watch<TemaApp>().getBackgroundColorFree,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          index == 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                            left: 20,
                          ),
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                index = 1;
                              });
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: primaryColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              filled: true,
                              fillColor: status == 0
                                  ? const Color.fromARGB(48, 65, 124, 175)
                                  : const Color.fromARGB(47, 65, 175, 70),
                              prefixIcon: Icon(
                                Icons.search,
                                color: primaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 3,
                                  color: primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Pesquisar',
                              hintStyle:
                                  TextStyle(fontSize: 16, color: secTextColor),
                              contentPadding: const EdgeInsets.only(
                                top: 2,
                                bottom: 2,
                                left: 15,
                                right: 15,
                              ),
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Você visitou:',
                              style: TextStyle(
                                fontSize: 18,
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6856,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.history,
                                  size:
                                      MediaQuery.of(context).size.width * 0.17,
                                  color: primaryColor,
                                ),
                                Text(
                                  'Você ainda não visitou\n nenhum anúncio',
                                  style: TextStyle(
                                      fontSize: 14, color: secTextColor),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : index == 1
                  ? Column(
                      children: [
                        TextFormField(
                          onTap: () {},
                          autofocus: true,
                          controller: searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: status == 0
                                ? const Color.fromARGB(48, 65, 124, 175)
                                : const Color.fromARGB(47, 65, 175, 70),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                color: secundaryColor,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      index = 0;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Color.fromARGB(255, 250, 253, 255),
                                  ),
                                ),
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: clearText,
                              icon: Icon(
                                Icons.clear,
                                color: primaryColor,
                              ),
                            ),
                            hintText: 'Pesquisar',
                            hintStyle:
                                TextStyle(fontSize: 16, color: secTextColor),
                          ),
                          style: TextStyle(fontSize: 16, color: textColor),
                        ),
                      ],
                    )
                  : const SizedBox(),
        ],
      ),
    );
  }
}
