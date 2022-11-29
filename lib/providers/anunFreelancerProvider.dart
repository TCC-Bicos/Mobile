import 'package:bicos_app/model/anuncio_Freelancer.dart';
import 'package:bicos_app/model/freelancer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/freelancer_preferences.dart';
import '../utils/user_preferences.dart';

class AnunFreelancerProvider with ChangeNotifier {
  late Freelancer freelancer;

  List<AnuncioFreelancer> _anunciosMyFreelancer = [];
  List<AnuncioFreelancer> getAnunciosMyFreelancer() => _anunciosMyFreelancer;

  Future<dynamic> addAnunFreelancer(
    String titulo,
    String desc,
    String preco,
    String imgAnunFr,
    int idTipoFr,
    context,
  ) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var response =
          await Dio().post('http://10.0.2.2:8000/api/addAnunFreelancer',
              data: {
                'TituloAnunFr': titulo,
                'DescAnunFr': desc,
                'PrecoAnunFr':
                    preco.replaceAll('.', '').replaceAll(',', '.').substring(3),
                'ImgAnunFr': imgAnunFr,
                'StatusAnunFr': '1',
                'DataAnunFr': DateFormat('yyyy-MM-dd').format(DateTime.now()),
                'idFrAnunFr': FreelancerPreferences.getFreelancer().idFr,
                'idTipoServAnunFr': idTipoFr,
              },
              options: Options(headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              }));
      if (response.data['status'] == '200') {
        Fluttertoast.showToast(
          msg: response.data['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.of(context).pop();
      } else {
        Fluttertoast.showToast(
          msg: response.data['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> loadAnunMyFreelancer(int id) async {
    try {
      _anunciosMyFreelancer.clear();
      var response = await Dio()
          .get('http://10.0.2.2:8000/api/getAnunFreelancerByFreelancer/$id');
      if (response.data['status'] == '200') {
        response.data['anuncios'].forEach(
          (e) {
            AnuncioFreelancer anuncio = AnuncioFreelancer(
              idAnunFr: e['idAnunFr'],
              TituloAnunFr: e['TituloAnunFr'],
              DescAnunFr: e['DescAnunFr'],
              PrecoAnunFr: double.parse(e['PrecoAnunFr'].toString()),
              ImgAnunFr: e['ImgAnunFr'],
              StatusAnunFr: e['StatusAnunFr'],
              DataAnunFr: e['DataAnunFr'],
              idFrAnunFr: e['idFrAnunFr'],
              idTipoServAnunFr: e['idTipoServAnunFr'],
            );
            if (anuncio.StatusAnunFr == '1') {
              if (_anunciosMyFreelancer
                  .any((element) => element.idAnunFr == anuncio.idAnunFr)) {
                print('_');
              } else {
                _anunciosMyFreelancer.add(anuncio);
              }
            }
          },
        );
      } else {
        print(response.data['message'].toString());
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
