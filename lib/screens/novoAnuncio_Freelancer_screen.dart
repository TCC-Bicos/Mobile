import 'dart:io';

import 'package:bicos_app/components/trabalhos/anuncio_Freelancer/botao_criarNovoAnuncio_Freelancer.dart';
import 'package:bicos_app/utils/tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NovoAnuncioFreelancer extends StatefulWidget {
  const NovoAnuncioFreelancer({Key? key}) : super(key: key);

  @override
  State<NovoAnuncioFreelancer> createState() => _NovoAnuncioFreelancerState();
}

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({required this.maxDigits});
  final int maxDigits;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class _NovoAnuncioFreelancerState extends State<NovoAnuncioFreelancer> {
  XFile? imagemAnuncioFreelancer;

  late int theme;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  Widget build(BuildContext context) {
    readTheme();

    Color primaryColor = context.watch<TemaApp>().getPrimaryColorFree;
    Color secundaryColor = context.watch<TemaApp>().getSecundaryColorFree;
    Color textColor = context.watch<TemaApp>().getTextColorFree;
    Color secTextColor = context.watch<TemaApp>().getSecundaryTextColor;
    Color backColor = context.watch<TemaApp>().getBackgroundColorFree;

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: theme == 0 ? primaryColor : Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: theme == 0 ? Colors.white : secundaryColor,
        title: Image.asset(
          theme == 0
              ? 'assets/images/bicoslogo_verde.png'
              : 'assets/images/bicoslogo.png',
          fit: BoxFit.contain,
          height: 22,
        ),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Text(
                'Novo anúncio',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  color: textColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                  bottom: 40,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: primaryColor,
                      maxLength: 50,
                      decoration: InputDecoration(
                        counterStyle: TextStyle(color: textColor),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: textColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: 'Título do anúncio',
                        hintStyle: TextStyle(fontSize: 16, color: textColor),
                        contentPadding: const EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          left: 15,
                          right: 15,
                        ),
                      ),
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: TextFormField(
                        cursorColor: primaryColor,
                        maxLength: 500,
                        maxLines: null,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(color: textColor),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: primaryColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: textColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: 'Descrição',
                          hintStyle: TextStyle(fontSize: 16, color: textColor),
                          contentPadding: const EdgeInsets.only(
                            top: 2,
                            bottom: 2,
                            left: 15,
                            right: 15,
                          ),
                        ),
                        style: TextStyle(fontSize: 16, color: textColor),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      cursorColor: primaryColor,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter(maxDigits: 8)
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterStyle: TextStyle(color: textColor),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: textColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: 'Valor do serviço',
                        hintStyle: TextStyle(fontSize: 16, color: textColor),
                        contentPadding: const EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          left: 15,
                          right: 15,
                        ),
                      ),
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: selecionarImagem,
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: textColor,
                            ),
                          ),
                          child: imagemAnuncioFreelancer == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_a_photo,
                                      color: textColor,
                                      size: 60,
                                    ),
                                    Text(
                                      'Carregar imagem',
                                      style: TextStyle(
                                        color: textColor,
                                      ),
                                    ),
                                  ],
                                )
                              : Image.file(
                                  File(imagemAnuncioFreelancer!.path),
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const CriarNovoAnuncioFreelancerBotao(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  selecionarImagem() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          imagemAnuncioFreelancer = file;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
