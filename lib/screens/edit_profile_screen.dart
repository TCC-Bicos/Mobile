import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bicos_app/utils/user_preferences.dart';
import 'package:bicos_app/components/profile-edit/button_widget.dart';
import 'dart:io';
import '../components/profile-edit/editprofile_widget.dart';
import '../model/cliente.dart';
import '../components/profile-edit/textfield_widget.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: EditProfileWidget(
                imagePath: user.ImgUser,
                isEdit: true,
                onClicked: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image == null) return;
                  final directory = await getApplicationDocumentsDirectory();
                  final name = basename(image.path);
                  final imageFile = File('${directory.path}/$name');
                  final newImage = await File(image.path).copy(imageFile.path);
                  setState(() => user = user.copy(ImgUser: newImage.path));
                },
                onDeleted: () async {
                  setState(() => user = user.copy(ImgUser: ''));
                },
              ),
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Nome:',
              text: user.NomeUser,
              onChanged: (name) => user = user.copy(NomeUser: name),
            ),
            const SizedBox(height: 24),
            const SizedBox(height: 24),
            TextFieldWidget(
              label: 'Sobre:',
              text: user.DescUser,
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
