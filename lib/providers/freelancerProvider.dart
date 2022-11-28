import 'package:bicos_app/model/freelancer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_routes.dart';
import '../utils/freelancer_preferences.dart';

class FreelancerProvider with ChangeNotifier {
  late Freelancer freelancer;

  Future<dynamic> loginFreelancer(String cpf, String senha, context) async {
    try {
      var response = await Dio()
          .get('http://10.0.2.2:8000/api/loginFreelancer/$cpf/$senha');
      if (response.data['status'] == '200') {
        if (response.data['loginResult'] == '1') {
          freelancer = Freelancer(
            idFr: response.data['freelancer']['idFr'] as int,
            CompetenciasFr: response.data['freelancer']['CompetenciasFr'],
            NomeFr: response.data['freelancer']['NomeFr'],
            CPFFr: response.data['freelancer']['CPFFr'],
            EmailFr: response.data['freelancer']['EmailFr'],
            TelFr: response.data['freelancer']['TelFr'],
            DataNascFr: response.data['freelancer']['DataNascFr'],
            GeneroFr: response.data['freelancer']['GeneroFr'],
            SenhaFr: response.data['freelancer']['SenhaFr'],
            DescFr: response.data['freelancer']['DescFr'],
            ImgFr: response.data['freelancer']['ImgFr'],
            StatusFr: response.data['freelancer']['StatusFr'],
          );
          FreelancerPreferences.setFreelancer(freelancer);
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.navigationbar, (route) => false);
          notifyListeners();
        }
      } else {
        print(response.data['loginResult'].toString());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> addFreelancer(
      String CompetenciasFr,
      String NomeFr,
      String CPFFr,
      String EmailFr,
      String TelFr,
      String DataNascFr,
      String GeneroFr,
      String SenhaFr,
      String DescFr,
      String ImgFr,
      context) async {
    try {
      var response = await Dio().post('http://10.0.2.2:8000/api/addFreelancer',
          data: {
            'CompetenciasFr': CompetenciasFr,
            'NomeFr': NomeFr,
            'CPFFr': CPFFr,
            'EmailFr': EmailFr,
            'TelFr': TelFr,
            'DataNascFr': DataNascFr,
            'GeneroFr': GeneroFr,
            'SenhaFr': SenhaFr,
            'DescFr': DescFr,
            'ImgFr': ImgFr,
            'StatusFr': '1',
          },
          options: Options(headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          }));
      if (response.data['status'] == '200') {
        Navigator.of(context).pushNamed(AppRoutes.opening);
        Fluttertoast.showToast(
          msg: 'Conta criada com sucesso',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
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
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> updateFreelancer(
      int idFr,
      String CompetenciasFr,
      String NomeFr,
      String CPFFr,
      String EmailFr,
      String TelFr,
      String DataNascFr,
      String GeneroFr,
      String SenhaFr,
      String DescFr,
      String ImgFr,
      String StatusFr,
      context) async {
    try {
      var response =
          await Dio().put('http://10.0.2.2:8000/api/updateFreelancer/$idFr',
              data: {
                'CompetenciasFr': CompetenciasFr,
                'NomeFr': NomeFr,
                'CPFFr': CPFFr,
                'EmailFr': EmailFr,
                'TelFr': TelFr,
                'DataNascFr': DataNascFr,
                'GeneroFr': GeneroFr,
                'SenhaFr': SenhaFr,
                'DescFr': DescFr,
                'ImgFr': ImgFr,
                'StatusFr': StatusFr,
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
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> checkPass(
      String cpf, String senha, String novaSenha, int id, context) async {
    try {
      var response = await Dio()
          .get('http://10.0.2.2:8000/api/loginFreelancer/$cpf/$senha');
      if (response.data['status'] == '200') {
        if (response.data['loginResult'] == '1') {
          updateSenhaFreelancer(novaSenha, id, context);
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Senha incorreta',
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> updateSenhaFreelancer(
      String novaSenha, int id, context) async {
    try {
      freelancer = FreelancerPreferences.getFreelancer();
      var response = await Dio()
          .put('http://10.0.2.2:8000/api/updateFreelancer/$id', data: {
        'idFr': freelancer.idFr,
        'NomeFr': freelancer.NomeFr,
        'CPFFr': freelancer.CPFFr,
        'EmailFr': freelancer.EmailFr,
        'TelFr': freelancer.TelFr,
        'DataNascFr': freelancer.DataNascFr,
        'GeneroFr': freelancer.GeneroFr,
        'SenhaFr': novaSenha,
        'DescFr': freelancer.DescFr,
        'ImgFr': freelancer.ImgFr,
        'StatusFr': freelancer.StatusFr,
      });
      if (response.data['status'] == '200') {
        freelancer = Freelancer(
          idFr: freelancer.idFr,
          CompetenciasFr: freelancer.CompetenciasFr,
          NomeFr: freelancer.NomeFr,
          CPFFr: freelancer.CPFFr,
          EmailFr: freelancer.EmailFr,
          TelFr: freelancer.TelFr,
          DataNascFr: freelancer.DataNascFr,
          GeneroFr: freelancer.GeneroFr,
          SenhaFr: novaSenha,
          DescFr: freelancer.DescFr,
          ImgFr: freelancer.ImgFr,
          StatusFr: freelancer.StatusFr,
        );
        FreelancerPreferences.setFreelancer(freelancer);
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
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> updateEmailFreelancer(String emailFr, int id, context) async {
    try {
      freelancer = FreelancerPreferences.getFreelancer();
      var response =
          await Dio().put('http://10.0.2.2:8000/api/updateFreelancer/$id',
              data: {
                'CompetenciasFr': freelancer.CompetenciasFr,
                'NomeFr': freelancer.NomeFr,
                'CPFFr': freelancer.CPFFr,
                'EmailFr': emailFr,
                'TelFr': freelancer.TelFr,
                'DataNascFr': freelancer.DataNascFr,
                'GeneroFr': freelancer.GeneroFr,
                'SenhaFr': freelancer.SenhaFr,
                'DescFr': freelancer.DescFr,
                'ImgFr': freelancer.ImgFr,
                'StatusFr': freelancer.StatusFr,
              },
              options: Options(headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              }));
      if (response.data['status'] == '200') {
        freelancer = Freelancer(
          idFr: freelancer.idFr,
          CompetenciasFr: freelancer.CompetenciasFr,
          NomeFr: freelancer.NomeFr,
          CPFFr: freelancer.CPFFr,
          EmailFr: emailFr,
          TelFr: freelancer.TelFr,
          DataNascFr: freelancer.DataNascFr,
          GeneroFr: freelancer.GeneroFr,
          SenhaFr: freelancer.SenhaFr,
          DescFr: freelancer.DescFr,
          ImgFr: freelancer.ImgFr,
          StatusFr: freelancer.StatusFr,
        );
        FreelancerPreferences.setFreelancer(freelancer);
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
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> updateTelFreelancer(String telFr, int id, context) async {
    try {
      freelancer = FreelancerPreferences.getFreelancer();
      var response = await Dio()
          .put('http://10.0.2.2:8000/api/updateFreelancer/$id', data: {
        'CompetenciasFr': freelancer.CompetenciasFr,
        'NomeFr': freelancer.NomeFr,
        'CPFFr': freelancer.CPFFr,
        'EmailFr': freelancer.EmailFr,
        'TelFr': telFr,
        'DataNascFr': freelancer.DataNascFr,
        'GeneroFr': freelancer.GeneroFr,
        'SenhaFr': freelancer.SenhaFr,
        'DescFr': freelancer.DescFr,
        'ImgFr': freelancer.ImgFr,
        'StatusFr': freelancer.StatusFr,
      });
      if (response.data['status'] == '200') {
        freelancer = Freelancer(
          idFr: freelancer.idFr,
          CompetenciasFr: freelancer.CompetenciasFr,
          NomeFr: freelancer.NomeFr,
          CPFFr: freelancer.CPFFr,
          EmailFr: freelancer.EmailFr,
          TelFr: telFr,
          DataNascFr: freelancer.DataNascFr,
          GeneroFr: freelancer.GeneroFr,
          SenhaFr: freelancer.SenhaFr,
          DescFr: freelancer.DescFr,
          ImgFr: freelancer.ImgFr,
          StatusFr: freelancer.StatusFr,
        );
        FreelancerPreferences.setFreelancer(freelancer);
        Fluttertoast.showToast(
          msg: response.data['message'],
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
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
    } catch (e) {
      print(e);
    }
  }
}
