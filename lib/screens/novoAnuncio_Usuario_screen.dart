import 'dart:io';
import 'package:bicos_app/model/servico.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/anunUserProvider.dart';
import '../providers/servicosProvider.dart';
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

  bool _isLoading = true;

  late List<TipoServico> _servicos;
  late int theme;

  int? _dropdownCargovalue;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ServicosProvider>(context, listen: false)
          .loadServicos()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    readTheme();
    _servicos = Provider.of<ServicosProvider>(context).getServicos();

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
      body: _isLoading
          ? Center(
              child: Column(
              children: const [
                SizedBox(
                  height: 30,
                ),
                CircularProgressIndicator(),
              ],
            ))
          : ListView(
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
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Dê um título ao anúncio";
                                }
                                return null;
                              },
                              cursorColor: primaryColor,
                              controller: titleController,
                              maxLength: 50,
                              decoration: InputDecoration(
                                counterStyle: TextStyle(color: textColor),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: textColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintText: 'Título do projeto',
                                hintStyle: TextStyle(
                                    fontSize: 16, color: secTextColor),
                                contentPadding: const EdgeInsets.only(
                                  top: 2,
                                  bottom: 2,
                                  left: 15,
                                  right: 15,
                                ),
                              ),
                              style: TextStyle(fontSize: 16, color: textColor),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 150),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Dê um descrição ao anúncio";
                                  }
                                  return null;
                                },
                                cursorColor: primaryColor,
                                controller: descController,
                                maxLength: 500,
                                maxLines: null,
                                decoration: InputDecoration(
                                  counterStyle: TextStyle(color: textColor),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: primaryColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: textColor),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  hintText: 'Descrição',
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: secTextColor),
                                  contentPadding: const EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                    left: 15,
                                    right: 15,
                                  ),
                                ),
                                style:
                                    TextStyle(fontSize: 16, color: textColor),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Insira um valor para remuneração";
                                }
                                return null;
                              },
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
                                  borderSide:
                                      BorderSide(width: 3, color: primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: textColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintText: 'Remuneração',
                                hintStyle: TextStyle(
                                    fontSize: 16, color: secTextColor),
                                contentPadding: const EdgeInsets.only(
                                  top: 2,
                                  bottom: 2,
                                  left: 15,
                                  right: 15,
                                ),
                              ),
                              style: TextStyle(fontSize: 16, color: textColor),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Descreva os requisitos";
                                }
                                return null;
                              },
                              cursorColor: primaryColor,
                              controller: requisitosController,
                              decoration: InputDecoration(
                                counterStyle: TextStyle(color: textColor),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: textColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintText: 'Requisitos',
                                hintStyle: TextStyle(
                                    fontSize: 16, color: secTextColor),
                                contentPadding: const EdgeInsets.only(
                                  top: 2,
                                  bottom: 2,
                                  left: 15,
                                  right: 15,
                                ),
                              ),
                              style: TextStyle(fontSize: 16, color: textColor),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                            ),
                            DropdownButtonFormField(
                              validator: (value) {
                                if (value == null) {
                                  return "Selecione o tipo desse serviço";
                                }
                                return null;
                              },
                              value: _dropdownCargovalue,
                              dropdownColor: secundaryColor,
                              focusColor: secundaryColor,
                              menuMaxHeight: 300,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: textColor,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 3, color: primaryColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(width: 1, color: textColor),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: secTextColor,
                                ),
                                hintText: 'Tipo do serviço',
                              ),
                              items: _servicos
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e.idTipoServ,
                                      child: Text(
                                        e.NomeServ,
                                        style: TextStyle(
                                            fontSize: 16, color: textColor),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _dropdownCargovalue = value as int;
                                });
                              },
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.035,
                            ),
                            InkWell(
                              onTap: selecionarImagem,
                              child: Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: textColor,
                                    ),
                                  ),
                                  child: imagemAnuncioUsuario == null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add_a_photo,
                                              color: secTextColor,
                                              size: 60,
                                            ),
                                            Text(
                                              'Carregar imagem',
                                              style: TextStyle(
                                                color: secTextColor,
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
                                      if (_formkey.currentState!.validate()) {
                                        context
                                            .read<AnunUserProvider>()
                                            .addAnunUsuario(
                                                titleController.text,
                                                descController.text,
                                                precoController.text,
                                                requisitosController.text,
                                                imagemAnuncioUsuario == null
                                                    ? imagemAnuncioUsuario!.path
                                                    : 'assets/images/testeImagemAnun.png',
                                                _dropdownCargovalue!,
                                                context);
                                      }
                                    },
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              theme == 0
                                                  ? Colors.white
                                                  : backColor),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 24, 145, 250)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
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
