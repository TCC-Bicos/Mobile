import 'package:bicos_app/model/freelancer.dart';
import 'package:bicos_app/utils/freelancer_preferences.dart';
import 'package:bicos_app/utils/tema.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bicos_app/utils/user_preferences.dart';
import 'package:bicos_app/components/profile-edit/button_widget.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../components/profile-edit/editprofile_widget.dart';
import '../model/cliente.dart';
import '../components/profile-edit/textfield_widget.dart';
import 'package:path/path.dart' as path;

import '../utils/statusFree_User.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late int theme;
  late User user;
  late Freelancer freelancer;
  late int status;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  void initState() {
    super.initState();
    user = UserPreferences.getUser();
    freelancer = FreelancerPreferences.getFreelancer();
    status = StatusFreeUser.getStatus();
  }

  @override
  Widget build(BuildContext context) {
    readTheme();

    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;
    Color secundaryColor = status == 0
        ? context.watch<TemaApp>().getSecundaryColorUser
        : context.watch<TemaApp>().getSecundaryColorFree;
    Color textColor = status == 0
        ? context.watch<TemaApp>().getTextColorUser
        : context.watch<TemaApp>().getTextColorFree;
    Color backColor = status == 0
        ? context.watch<TemaApp>().getBackgroundColorUser
        : context.watch<TemaApp>().getBackgroundColorFree;
    Color darkBackColor = context.watch<TemaApp>().getDarkBackgroundColor;
    Color secTextColor = context.watch<TemaApp>().getSecundaryTextColor;

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
          status == 0
              ? theme == 0
                  ? 'assets/images/bicoslogo_azul.png'
                  : 'assets/images/bicoslogo.png'
              : theme == 0
                  ? 'assets/images/bicoslogo_verde.png'
                  : 'assets/images/bicoslogo.png',
          fit: BoxFit.contain,
          height: 22,
        ),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: EditProfileWidget(
              color: primaryColor,
              imagePath: status == 0 ? user.ImgUser : freelancer.ImgFr,
              isEdit: true,
              onClicked: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image == null) return;
                final directory = await getApplicationDocumentsDirectory();
                final name = path.basename(image.path);
                final imageFile = File('${directory.path}/$name');
                final newImage = await File(image.path).copy(imageFile.path);
                User usuario = User(
                  idUser: user.idUser,
                  NomeUser: user.NomeUser,
                  CPFUser: user.CPFUser,
                  EmailUser: user.EmailUser,
                  TelUser: user.TelUser,
                  DataNascUser: user.DataNascUser,
                  GeneroUser: user.GeneroUser,
                  SenhaUser: user.SenhaUser,
                  DescUser: user.DescUser,
                  ImgUser: newImage.path,
                  StatusUser: user.StatusUser,
                );
                Freelancer fr = Freelancer(
                  idFr: freelancer.idFr,
                  CompetenciasFr: freelancer.CompetenciasFr,
                  NomeFr: freelancer.NomeFr,
                  CPFFr: freelancer.CPFFr,
                  EmailFr: freelancer.EmailFr,
                  TelFr: freelancer.TelFr,
                  DataNascFr: freelancer.DataNascFr,
                  GeneroFr: freelancer.GeneroFr,
                  SenhaFr: freelancer.SenhaFr,
                  DescFr: freelancer.DescFr,
                  ImgFr: newImage.path,
                  StatusFr: freelancer.StatusFr,
                );

                setState(() {
                  status == 0
                      ? UserPreferences.setUser(usuario)
                      : FreelancerPreferences.setFreelancer(fr);
                });
              },
              onDeleted: () async {
                User usuario = User(
                  idUser: user.idUser,
                  NomeUser: user.NomeUser,
                  CPFUser: user.CPFUser,
                  EmailUser: user.EmailUser,
                  TelUser: user.TelUser,
                  DataNascUser: user.DataNascUser,
                  GeneroUser: user.GeneroUser,
                  SenhaUser: user.SenhaUser,
                  DescUser: user.DescUser,
                  ImgUser: '',
                  StatusUser: user.StatusUser,
                );
                Freelancer fr = Freelancer(
                  idFr: freelancer.idFr,
                  CompetenciasFr: freelancer.CompetenciasFr,
                  NomeFr: freelancer.NomeFr,
                  CPFFr: freelancer.CPFFr,
                  EmailFr: freelancer.EmailFr,
                  TelFr: freelancer.TelFr,
                  DataNascFr: freelancer.DataNascFr,
                  GeneroFr: freelancer.GeneroFr,
                  SenhaFr: freelancer.SenhaFr,
                  DescFr: freelancer.DescFr,
                  ImgFr: '',
                  StatusFr: freelancer.StatusFr,
                );
                setState(() => status == 0
                    ? UserPreferences.setUser(usuario)
                    : FreelancerPreferences.setFreelancer(fr));
              },
            ),
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
              label: 'Nome:',
              text: status == 0 ? user.NomeUser : freelancer.NomeFr,
              onChanged: (name) {
                User usuario = User(
                  idUser: user.idUser,
                  NomeUser: name,
                  CPFUser: user.CPFUser,
                  EmailUser: user.EmailUser,
                  TelUser: user.TelUser,
                  DataNascUser: user.DataNascUser,
                  GeneroUser: user.GeneroUser,
                  SenhaUser: user.SenhaUser,
                  DescUser: user.DescUser,
                  ImgUser: user.ImgUser,
                  StatusUser: user.StatusUser,
                );
                Freelancer fr = Freelancer(
                  idFr: freelancer.idFr,
                  CompetenciasFr: freelancer.CompetenciasFr,
                  NomeFr: name,
                  CPFFr: freelancer.CPFFr,
                  EmailFr: freelancer.EmailFr,
                  TelFr: freelancer.TelFr,
                  DataNascFr: freelancer.DataNascFr,
                  GeneroFr: freelancer.GeneroFr,
                  SenhaFr: freelancer.SenhaFr,
                  DescFr: freelancer.DescFr,
                  ImgFr: freelancer.ImgFr,
                  StatusFr: freelancer.StatusFr,
                );
                setState(() => status == 0
                    ? UserPreferences.setUser(usuario)
                    : FreelancerPreferences.setFreelancer(fr));
              }),
          const SizedBox(height: 24),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Sobre:',
            text: status == 0 ? user.DescUser : freelancer.DescFr,
            maxLines: 5,
            onChanged: (about) => user = user.copy(DescUser: about),
          ),
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: ButtonWidget(
                text: 'Salvar',
                onClicked: () {
                  UserPreferences.setUser(user);
                  Navigator.of(context).pop();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
