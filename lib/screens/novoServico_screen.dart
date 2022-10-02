import 'dart:io';

import 'package:bicos_app/components/trabalhos/servicos/botao_criarNovoServico.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class NovoServico extends StatefulWidget {
  const NovoServico({Key? key}) : super(key: key);

  @override
  State<NovoServico> createState() => _NovoServicoState();
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "pt_Br");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class _NovoServicoState extends State<NovoServico> {
  XFile? imagemServico;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 250, 253, 255),
        title: Image.asset(
          'assets/images/bicoslogo_azul.png',
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
              const Text(
                'Novo serviço',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  color: Color.fromARGB(255, 0, 38, 92),
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
                      maxLength: 50,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: 'Título do serviço',
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
                    const SizedBox(
                      height: 15,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: TextFormField(
                        maxLength: 500,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: 'Descrição do serviço',
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
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyInputFormatter()
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: 'Valor do serviço',
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
                              color: const Color.fromARGB(255, 141, 141, 141),
                            ),
                          ),
                          child: imagemServico == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.add_a_photo,
                                      color: Color.fromARGB(255, 136, 136, 136),
                                      size: 60,
                                    ),
                                    Text(
                                      'Carregar imagem',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 141, 141, 141),
                                      ),
                                    ),
                                  ],
                                )
                              : Image.file(
                                  File(imagemServico!.path),
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const CriarNovoServicoBotao(),
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
          imagemServico = file;
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
