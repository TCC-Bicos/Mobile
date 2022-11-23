import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/freelancer.dart';

class FreelancerPreferences {
  static late SharedPreferences sharedPreferences;

  static const _keyFr = 'user';
  static const myFreelancer = Freelancer(
    idFr: 0,
    CompetenciasFr: 'CompetenciasFr',
    NomeFr: 'NomeFr',
    CPFFr: 'CPFFr',
    EmailFr: 'EmailFr',
    TelFr: 'TelFr',
    DataNascFr: 'DataNascFr',
    GeneroFr: 'GeneroFr',
    SenhaFr: 'SenhaFr',
    DescFr: 'DescFr',
    ImgFr: '',
    StatusFr: '1',
  );

  static Future init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static Future setFreelancer(Freelancer freelancer) async {
    final json = jsonEncode(freelancer.toJson());

    await sharedPreferences.setString(_keyFr, json);
  }

  static Freelancer getFreelancer() {
    final json = sharedPreferences.getString(_keyFr);

    return json == null ? myFreelancer : Freelancer.fromJson(jsonDecode(json));
  }

  static Future deslogar() async {
    final json = jsonEncode(myFreelancer.toJson());

    await sharedPreferences.setString(_keyFr, json);
  }
}
