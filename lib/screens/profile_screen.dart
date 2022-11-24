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
  late User user;
  late Freelancer freelancer;

  @override
  void initState() {
    super.initState();
    status = StatusFreeUser.getStatus();
    user = UserPreferences.getUser();
    freelancer = FreelancerPreferences.getFreelancer();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = status == 0
        ? context.watch<TemaApp>().getPrimaryColorUser
        : context.watch<TemaApp>().getPrimaryColorFree;

    final List<String> imgList = [
      'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
      'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
      'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
      'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
      'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
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
                            'No. ${imgList.indexOf(item)} image',
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
              ? buildNameUser(user, primaryColor)
              : buildNameFr(freelancer, primaryColor),
          const SizedBox(height: 24),
          Center(child: buildMessageButton()),
          const SizedBox(height: 48),
          status == 0 ? buildAboutUser(user) : buildAboutFr(freelancer),
          const SizedBox(height: 48),
          Container(
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
        ],
      );

  Widget buildNameUser(User user, color) => Column(
        children: [
          Text(
            user.NomeUser,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
        ],
      );

  Widget buildMessageButton() =>
      ButtonWidget(text: 'Enviar Mensagem', onClicked: () {});

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
