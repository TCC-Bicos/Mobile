import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/anunUserProvider.dart';
import '../utils/tema.dart';

class NovoAnuncioUsuario extends StatefulWidget {
  const NovoAnuncioUsuario({Key? key}) : super(key: key);

  @override
  State<NovoAnuncioUsuario> createState() => _NovoAnuncioUsuarioState();
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

class _NovoAnuncioUsuarioState extends State<NovoAnuncioUsuario> {
  XFile? imagemAnuncioUsuario;

  final titleController = TextEditingController();
  final descController = TextEditingController();
  final precoController = TextEditingController();
  final requisitosController = TextEditingController();

  AnunUserProvider _anunUserProvider = AnunUserProvider();

  late int theme;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  Widget build(BuildContext context) {
    readTheme();

    Color primaryColor = context.watch<TemaApp>().getPrimaryColorUser;
    Color secundaryColor = context.watch<TemaApp>().getSecundaryColorUser;
    Color textColor = context.watch<TemaApp>().getTextColorUser;
    Color secTextColor = context.watch<TemaApp>().getSecundaryTextColor;
    Color backColor = context.watch<TemaApp>().getBackgroundColorUser;

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme == 0 ? primaryColor : Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: theme == 0 ? Colors.white : secundaryColor,
        title: Image.asset(
          theme == 0
              ? 'assets/images/bicoslogo_azul.png'
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
                      controller: titleController,
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
                        hintText: 'Título do projeto',
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
                        controller: descController,
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
                      controller: precoController,
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
                        hintText: 'Remuneração',
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
                    TextFormField(
                      cursorColor: primaryColor,
                      controller: requisitosController,
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
                        hintText: 'Requisitos',
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
                          child: imagemAnuncioUsuario == null
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
                                  File(imagemAnuncioUsuario!.path),
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: 220,
                          child: TextButton(
                            onPressed: () {
                              _anunUserProvider.addAnunUsuario(
                                  titleController.text,
                                  descController.text,
                                  precoController.text,
                                  requisitosController.text,
                                  '',
                                  context);
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  theme == 0 ? Colors.white : backColor),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 24, 145, 250)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: primaryColor),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Criar anúncio',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
          imagemAnuncioUsuario = file;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
