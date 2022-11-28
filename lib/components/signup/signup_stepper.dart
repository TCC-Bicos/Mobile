import 'dart:io';

import 'package:bicos_app/model/servico.dart';
import 'package:bicos_app/providers/servicosProvider.dart';
import 'package:brasil_fields/brasil_fields.dart' as brasil_fields;
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:provider/provider.dart';

import '../../providers/clientProvider.dart';
import '../../providers/freelancerProvider.dart';

class SignupStepper extends StatefulWidget {
  SignupStepper({Key? key}) : super(key: key);

  @override
  State<SignupStepper> createState() => _SignupStepperState();

  static final now = DateTime.now();

  final dropdownDatePicker = DropdownDatePicker(
    firstDate: ValidDate(day: 1, month: 1, year: now.year - 100),
    lastDate: ValidDate(day: now.day, month: now.month, year: now.year),
    dropdownColor: Colors.blue[200],
    underLine: const Text(''),
    dateHint: const DateHint(day: 'dia', month: 'mês', year: 'ano'),
    ascending: false,
    textStyle: const TextStyle(
      fontSize: 16,
    ),
    dateFormat: DateFormat.dmy,
  );
}

class _SignupStepperState extends State<SignupStepper> {
  int currentStep = 0;
  int verificaData = 0;
  int hasImage = 0;

  final String _fotoPadrao = 'assets/images/standardProfilePic.png';
  String _armazenaFoto = '';
  String? _dropdownvalue, _armazenaGenero;
  late String _date;
  int? _dropdownCargovalue;
  Object? _usuariovalue = 'cliente';

  CountryCode? countryCode;

  final TextEditingController _compController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _telController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmsenhaController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey3 = GlobalKey<FormState>();

  bool _isLoading = true;

  late FlCountryCodePicker countryPicker;

  final maskFormatter = MaskTextInputFormatter(mask: "+55 (##) #########");

  @override
  Widget build(BuildContext context) {
    return Stepper(
      physics: const ClampingScrollPhysics(),
      currentStep: currentStep,
      steps: getSteps(),
      onStepContinue: () {
        final isLastStep = currentStep == getSteps().length - 1;
        setState(
          () {
            if (currentStep == 2) {
              if (_formkey3.currentState!.validate()) {
                currentStep += 1;
              } else {
                return;
              }
            } else if (currentStep == 0) {
              _date = widget.dropdownDatePicker.getDate('-');
              if (_formkey.currentState!.validate() &&
                  !RegExp('null').hasMatch(_date)) {
                currentStep += 1;
                if (verificaData >= 1) {
                  verificaData = 0;
                }
              } else {
                if (RegExp('null').hasMatch(_date)) {
                  verificaData = 1;
                }
                return;
              }
            } else if (currentStep == 1) {
              if (_formkey2.currentState!.validate()) {
                currentStep += 1;
              } else {
                return;
              }
            } else if (isLastStep) {
              String year = _date.substring(6);
              String day = _date.substring(0, 2);
              String month = _date.substring(3, 5);
              String date = '$year-$month-$day';
              _usuariovalue == 'cliente'
                  ? context.read<ClienteProvider>().addUser(
                      _nomeController.text,
                      _cpfController.text,
                      _emailController.text,
                      _telController.text,
                      date,
                      _armazenaGenero!,
                      _senhaController.text,
                      _descController.text,
                      hasImage == 0 ? _fotoPadrao : _armazenaFoto,
                      context)
                  : context.read<FreelancerProvider>().addFreelancer(
                      _compController.text,
                      _nomeController.text,
                      _cpfController.text,
                      _emailController.text,
                      _telController.text,
                      date,
                      _armazenaGenero!,
                      _senhaController.text,
                      _descController.text,
                      hasImage == 0 ? _fotoPadrao : _armazenaFoto,
                      context);
            }
          },
        );
      },
      onStepTapped: (step) => setState(() {
        if (currentStep == 2) {
          if (step == 0 || step == 1) {
            _formkey3.currentState!.validate();
            currentStep = step;
          } else if (step == 3) {
            if (_formkey3.currentState!.validate()) {
              currentStep = step;
            }
          } else if (step == 2) {
            _formkey3.currentState!.validate();
          } else {
            return;
          }
        } else if (currentStep == 0) {
          _date = widget.dropdownDatePicker.getDate('-');
          if (_formkey.currentState!.validate()) {
            if (step == 1) {
              currentStep = step;
            } else if (step == 2) {
              if (_formkey2.currentState!.validate()) {
                currentStep = step;
              } else {
                return;
              }
            } else if (step == 3) {
              if (_formkey2.currentState!.validate() &&
                  _formkey3.currentState!.validate()) {
                currentStep = step;
              } else {
                return;
              }
            }
          } else {
            if (RegExp('null').hasMatch(_date)) {
              verificaData = 1;
            }
            return;
          }
        } else if (currentStep == 1) {
          if (step == 0) {
            _formkey2.currentState!.validate();
            currentStep = step;
          } else if (step == 1) {
            _formkey2.currentState!.validate();
          } else if (step == 2) {
            if (_formkey2.currentState!.validate()) {
              currentStep = step;
            } else {
              return;
            }
          } else if (step == 3) {
            if (_formkey2.currentState!.validate() &&
                _formkey3.currentState!.validate()) {
              currentStep = step;
            } else {
              return;
            }
          } else {
            return;
          }
        } else if (currentStep == 3) {
          currentStep = step;
        }
      }),
      onStepCancel: currentStep == 0
          ? null
          : () => setState(
                () {
                  currentStep -= 1;
                },
              ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Etapa 1'),
          content: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  child: TextFormField(
                    controller: _nomeController,
                    decoration: const InputDecoration(
                      hintText: 'Nome completo',
                      hintStyle: TextStyle(fontSize: 16),
                    ),
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira um nome";
                      }
                      if (!RegExp('[a-zA-Z]').hasMatch(value)) {
                        return 'Insira um nome válido';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _cpfController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      brasil_fields.CpfInputFormatter(),
                    ],
                    decoration: const InputDecoration(
                      hintText: 'CPF',
                      hintStyle: TextStyle(fontSize: 16),
                    ),
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira um CPF";
                      }
                      if (!CPFValidator.isValid(value)) {
                        return "Insira um CPF válido";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                TextFormField(
                  inputFormatters: [
                    maskFormatter,
                  ],
                  controller: _telController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira um número de telefone";
                    } else if (!RegExp(r'(^(\d{2})\D*(\d{5}|\d{4})\D*(\d{4})$)')
                        .hasMatch(_telController.text
                            .replaceAll(' ', '')
                            .replaceAll('-', '')
                            .replaceAll('(', '')
                            .replaceAll(')', '')
                            .substring(3))) {
                      return "Insira um número de telefone válido";
                    }
                  },
                  style: const TextStyle(fontSize: 16),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'Telefone',
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                DropdownButtonFormField<String>(
                  value: _dropdownvalue,
                  hint: const Text(
                    'Gênero',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 104, 111, 118),
                    ),
                  ),
                  onChanged: (dropdownvalue) => setState(() => {
                        _dropdownvalue = dropdownvalue,
                        _armazenaGenero = dropdownvalue?.substring(0, 1),
                      }),
                  validator: (value) =>
                      value == null ? 'Selecione um gênero' : null,
                  items: ['Masculino', 'Feminino', 'Outro', 'Prefiro não dizer']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                verificaData == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Data de nascimento: ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 104, 111, 118),
                            ),
                          ),
                          widget.dropdownDatePicker,
                        ],
                      )
                    : Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Data de nascimento: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 104, 111, 118),
                                ),
                              ),
                              widget.dropdownDatePicker,
                            ],
                          ),
                          Column(
                            children: const [
                              Text(
                                'Insira uma data',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 211, 48, 48),
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Etapa 2'),
          content: Form(
            key: _formkey2,
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'cliente',
                      groupValue: _usuariovalue,
                      onChanged: ((value) {
                        setState(() {
                          _usuariovalue = value!;
                        });
                      }),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const Text(
                      'Cliente',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 104, 111, 118),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 'freelancer',
                      groupValue: _usuariovalue,
                      onChanged: ((value) {
                        setState(() {
                          _usuariovalue = value!;
                        });
                      }),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const Text(
                      'Freelancer',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 104, 111, 118),
                      ),
                    ),
                  ],
                ),
                _usuariovalue == 'cliente'
                    ? const SizedBox()
                    : Column(
                        children: [
                          SizedBox(
                            child: TextFormField(
                              controller: _compController,
                              decoration: const InputDecoration(
                                hintText: 'Competências',
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: const TextStyle(fontSize: 16),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Insira suas competências";
                                }
                              },
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text('Etapa 3'),
          content: Form(
            key: _formkey3,
            child: Column(
              children: [
                SizedBox(
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
                      hintStyle: TextStyle(fontSize: 16),
                    ),
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira um E-mail';
                      }
                      if (!RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value)) {
                        return 'Por favor insira um E-mail válido';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _senhaController,
                    decoration: const InputDecoration(
                      hintText: 'Senha',
                      hintStyle: TextStyle(fontSize: 16),
                      errorMaxLines: 4,
                    ),
                    style: const TextStyle(fontSize: 16),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira uma senha';
                      }
                      if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(value)) {
                        return 'A senha deve conter pelo menos 8 carateres, letra maiúscula e minúscula, caractere especial e número';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _confirmsenhaController,
                    decoration: const InputDecoration(
                      hintText: 'Confirmar senha',
                      hintStyle: TextStyle(fontSize: 16),
                    ),
                    style: const TextStyle(fontSize: 16),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor confirme a senha';
                      }
                      if (_senhaController.text !=
                          _confirmsenhaController.text) {
                        return 'As senhas devem ser iguais';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: const Text('Etapa 4'),
          content: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Foto de Perfil ',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const Text(
                    '(opcional)',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 104, 111, 118),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  buildImage(),
                  Positioned(
                      bottom: 0,
                      right: 4,
                      child:
                          buildEditIcon(Theme.of(context).colorScheme.primary)),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                child: TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    hintText: 'Descrição de perfil (opcional)',
                    hintStyle: TextStyle(fontSize: 16),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ];

  void dropdownCallback(String? selectedvalue) {
    if (selectedvalue is String) {
      setState(() {
        _dropdownvalue = selectedvalue;
      });
    }
  }

  Widget buildImage() {
    final img = FileImage(File(_armazenaFoto));
    final imgSt = Image.asset(_fotoPadrao);

    return hasImage == 0
        ? ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: imgSt.image,
                fit: BoxFit.cover,
                width: 128,
                height: 128,
                child: InkWell(
                  onTap: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image == null) return;
                    final directory = await getApplicationDocumentsDirectory();
                    final name = path.basename(image.path);
                    final imageFile = File('${directory.path}/$name');
                    final newImage =
                        await File(image.path).copy(imageFile.path);
                    setState(() {
                      _armazenaFoto = newImage.path;
                      hasImage += 1;
                    });
                  },
                ),
              ),
            ),
          )
        : ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: img,
                fit: BoxFit.cover,
                width: 128,
                height: 128,
                child: InkWell(
                  onTap: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image == null) return;
                    final directory = await getApplicationDocumentsDirectory();
                    final name = path.basename(image.path);
                    final imageFile = File('${directory.path}/$name');
                    final newImage =
                        await File(image.path).copy(imageFile.path);
                    setState(() {
                      _armazenaFoto = newImage.path;
                      hasImage += 1;
                    });
                  },
                ),
              ),
            ),
          );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle(
          {required Widget child, required double all, required Color color}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
