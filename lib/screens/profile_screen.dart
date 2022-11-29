import 'package:bicos_app/model/freelancer.dart';
import 'package:bicos_app/utils/freelancer_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bicos_app/model/cliente.dart';
import 'package:bicos_app/utils/user_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../components/profile-edit/button_widget.dart';
import '../components/profile-edit/profile_widget.dart';
import '../utils/app_routes.dart';
import '../utils/statusFree_User.dart';
import '../utils/tema.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  late int status;
  late int theme;
  late User user;
  late Freelancer freelancer;

  readTheme() {
    theme = context.watch<TemaApp>().temaClaroEscuro;
  }

  @override
  void initState() {
    super.initState();
    status = StatusFreeUser.getStatus();
    user = UserPreferences.getUser();
    freelancer = FreelancerPreferences.getFreelancer();
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

    final List<String> imgList = [
      'https://www.agenciamaya.com.br/blog/wp-content/uploads/2018/04/Untitled-8-1024x549.png',
      'https://eletronica1etec.files.wordpress.com/2016/07/sem-tc3adtulo.jpg',
      'https://www.agenciamaya.com.br/blog/wp-content/uploads/2018/04/Untitled-7-1024x549.png',
      'https://res.cloudinary.com/dte7upwcr/image/upload/blog/blog2/modelos-de-sites/image_10-modelos-de-sites-futurio.jpg',
      'https://www.agenciamaya.com.br/blog/wp-content/uploads/2018/04/Untitled-6-1024x549.png',
    ];
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'Projeto ${imgList.indexOf(item) + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();

    super.build(context);

    return Scaffold(
      backgroundColor: status == 0
          ? context.watch<TemaApp>().getBackgroundColorUser
          : context.watch<TemaApp>().getBackgroundColorFree,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: ProfileWidget(
              imagePath: status == 0 ? user.ImgUser : freelancer.ImgFr,
              onClicked: () async {
                await Navigator.of(context).pushNamed(AppRoutes.editProfile);
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 24),
          status == 0
              ? buildNameUser(user, theme == 0 ? secundaryColor : primaryColor)
              : buildNameFr(
                  freelancer, theme == 0 ? secundaryColor : primaryColor),
          const SizedBox(height: 48),
          status == 0 ? buildAboutUser(user) : buildAboutFr(freelancer),
          const SizedBox(height: 48),
          status == 0
              ? SizedBox()
              : Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      initialPage: 0,
                      autoPlay: false,
                    ),
                    items: imageSliders,
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildNameFr(Freelancer freelancer, color) => Column(
        children: [
          Text(
            freelancer.NomeFr,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: color),
          ),
          const SizedBox(height: 4),
        ],
      );

  Widget buildNameUser(User user, color) => Column(
        children: [
          Text(
            user.NomeUser,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: color),
          ),
          const SizedBox(height: 4),
        ],
      );

  Widget buildAboutFr(Freelancer freelancer) {
    Color textColor = context.watch<TemaApp>().getTextColorFree;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sobre:',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 16),
          Text(
            maxLines: 7,
            freelancer.DescFr,
            style: TextStyle(fontSize: 16, height: 1.4, color: textColor),
          )
        ],
      ),
    );
  }

  Widget buildAboutUser(User user) {
    Color textColor = context.watch<TemaApp>().getTextColorUser;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sobre:',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 16),
          Text(
            maxLines: 7,
            user.DescUser,
            style: TextStyle(fontSize: 16, height: 1.4, color: textColor),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
