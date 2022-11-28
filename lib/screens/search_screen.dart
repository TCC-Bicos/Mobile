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

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  static const historyLength = 15;

  List<String> _searchHistory = [];

  late List<String> filteredSearchHistory;
  late String selectedTerm;
  late int status;

  @override
  void initState() {
    super.initState();
    status = StatusFreeUser.getStatus();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  List<String> filterSearchTerms({
    required String? filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  int index = 0;

  void clearText() {
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
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

    super.build(context);

    return Container(
      height: MediaQuery.of(context).size.height - 113,
      color: status == 0
          ? context.watch<TemaApp>().getBackgroundColorUser
          : context.watch<TemaApp>().getBackgroundColorFree,
      child: SingleChildScrollView(
        child: index == 0
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
                                size: MediaQuery.of(context).size.width * 0.17,
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
                        onChanged: (query) {
                          setState(() {
                            filteredSearchHistory =
                                filterSearchTerms(filter: query);
                          });
                        },
                        onFieldSubmitted: (query) {
                          setState(() {
                            addSearchTerm(query);
                            selectedTerm = query;
                          });
                          searchController.clear();
                          FocusScope.of(context).unfocus();
                        },
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
                                  searchController.clear();
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
                      Builder(
                        builder: (context) {
                          if (filteredSearchHistory.isEmpty &&
                              searchController.text.isEmpty) {
                            return Container(
                              height: MediaQuery.of(context).size.height - 185,
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_rounded,
                                    color: primaryColor,
                                    size: MediaQuery.of(context).size.width *
                                        0.17,
                                  ),
                                  Text(
                                    'Comece a pesquisar',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14, color: secTextColor),
                                  ),
                                ],
                              ),
                            );
                          } else if (filteredSearchHistory.isEmpty) {
                            return ListTile(
                              title: Text(
                                searchController.text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                              leading: Icon(
                                Icons.search,
                                color: textColor,
                              ),
                              onTap: () {
                                setState(() {
                                  addSearchTerm(searchController.text);
                                  selectedTerm = searchController.text;
                                });
                                FocusScope.of(context).unfocus();
                              },
                            );
                          } else {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: filteredSearchHistory
                                  .map(
                                    (term) => ListTile(
                                      title: Text(
                                        term,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: textColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      leading: Icon(
                                        Icons.history,
                                        color: textColor,
                                      ),
                                      trailing: IconButton(
                                        icon:
                                            Icon(Icons.clear, color: textColor),
                                        onPressed: () {
                                          setState(() {
                                            deleteSearchTerm(term);
                                          });
                                        },
                                      ),
                                      onTap: () {
                                        setState(() {
                                          putSearchTermFirst(term);
                                          selectedTerm = term;
                                        });
                                        FocusScope.of(context).unfocus();
                                      },
                                    ),
                                  )
                                  .toList(),
                            );
                          }
                        },
                      ),
                    ],
                  )
                : const SizedBox(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
