import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart' as brasil_fields;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dropdown_date_picker/dropdown_date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

import '../../utils/app_routes.dart';

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

  String _fotoPadrao = 'assets/images/standardProfilePic.png';
  String _armazenaFoto = '';
  String? _nome, _email, _cpf, _dropdownvalue, _armazenaGenero;
  Object? _usuariovalue = 'cliente';
  final TextEditingController _senha = TextEditingController();
  final TextEditingController _confirmsenha = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formkey3 = GlobalKey<FormState>();

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
            String getDate = widget.dropdownDatePicker.getDate('/');
            if (currentStep == 2) {
              if (_formkey3.currentState!.validate()) {
                currentStep += 1;
              } else {
                return;
              }
            } else if (currentStep == 0) {
              if (_formkey.currentState!.validate() &&
                  !RegExp('null').hasMatch(getDate)) {
                currentStep += 1;
                if (verificaData >= 1) {
                  verificaData = 0;
                }
              } else {
                if (RegExp('null').hasMatch(getDate)) {
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
              Navigator.of(context).pushNamed(AppRoutes.login);
            }
          },
        );
      },
      onStepTapped: (step) => setState(() {
        String getDate = widget.dropdownDatePicker.getDate('/');
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
            if (RegExp('null').hasMatch(getDate)) {
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
                    decoration: const InputDecoration(
                      hintText: 'Nome completo',
                      hintStyle: TextStyle(fontSize: 16),
                    ),
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por favor insira um nome";
                      }
                      if (!RegExp('[a-zA-Z]').hasMatch(value)) {
                        return 'Por favor insira um nome válido';
                      }
                      return null;
                    },
                    onSaved: (nome) {
                      _nome = nome!;
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(this.context).size.height * 0.02,
                ),
                SizedBox(
                  child: TextFormField(
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
                        return "Por favor insira um CPF";
                      }
                      if (!CPFValidator.isValid(value)) {
                        return "Por favor insira um CPF válido";
                      }
                      return null;
                    },
                    onSaved: (cpf) {
                      _cpf = cpf!;
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(this.context).size.height * 0.02,
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
                      value == null ? 'Por favor selecione um gênero' : null,
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
                  height: MediaQuery.of(this.context).size.height * 0.02,
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
                                'Por favor insira uma data',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 211, 48, 48),
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        ],
                      )
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
                      width: MediaQuery.of(this.context).size.height * 0.01,
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
                      width: MediaQuery.of(this.context).size.height * 0.01,
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
                          const SizedBox(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Profissão',
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(this.context).size.height * 0.02,
                          ),
                          const SizedBox(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Competências',
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: TextStyle(fontSize: 16),
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
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
                      hintStyle: TextStyle(fontSize: 16),
                    ),
                    style: const TextStyle(fontSize: 16),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor insira um E-mail';
                      }
                      if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                          .hasMatch(value)) {
                        return 'Por favor insira um E-mail válido';
                      }
                      return null;
                    },
                    onSaved: (email) {
                      _email = email;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _senha,
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
                        return 'A senha deve conter 8 carateres, letra maiúscula e minúscula, caractere especial e número';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(this.context).size.height * 0.02,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: _confirmsenha,
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
                      if (_senha.text != _confirmsenha.text) {
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
                    height: MediaQuery.of(this.context).size.height * 0.1,
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
                      child: buildEditIcon(
                          Theme.of(this.context).colorScheme.primary)),
                ],
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
                    final name = basename(image.path);
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
                    final name = basename(image.path);
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
