import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
    return ListView(
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
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(48, 65, 124, 175),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 3,
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Pesquisar',
                            hintStyle: const TextStyle(fontSize: 16),
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
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Você visitou:',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 38, 92),
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
                                size: MediaQuery.of(context).size.width * 0.17,
                                color: Colors.blue,
                              ),
                              Text(
                                'Você ainda não visitou\n nenhum anúncio',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blueGrey[800],
                                ),
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
                          fillColor: const Color.fromARGB(48, 65, 124, 175),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Container(
                              color: Colors.blue[800],
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
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.blue,
                            ),
                          ),
                          hintText: 'Pesquisar',
                          hintStyle: const TextStyle(fontSize: 16),
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                : const SizedBox(),
      ],
    );
  }
}
