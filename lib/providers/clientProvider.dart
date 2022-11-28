import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/cliente.dart';
import '../utils/app_routes.dart';
import '../utils/user_preferences.dart';

class ClienteProvider with ChangeNotifier {
  late User user;

  Future<dynamic> loginUser(String email, String senha, context) async {
    try {
      var response = await Dio()
          .get('http://10.0.2.2:8000/api/loginUsuario/$email/$senha');
      if (response.data['status'] == '200') {
        if (response.data['loginResult'] == '1') {
          user = User(
            idUser: response.data['user']['idUser'] as int,
            NomeUser: response.data['user']['NomeUser'],
            CPFUser: response.data['user']['CPFUser'],
            EmailUser: response.data['user']['EmailUser'],
            TelUser: response.data['user']['TelUser'],
            DataNascUser: response.data['user']['DataNascUser'],
            GeneroUser: response.data['user']['GeneroUser'],
            SenhaUser: response.data['user']['SenhaUser'],
            DescUser: response.data['user']['DescUser'],
            ImgUser: response.data['user']['ImgUser'],
            StatusUser: response.data['user']['StatusUser'],
          );
          UserPreferences.setUser(user);
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.navigationbar, (route) => false);
          notifyListeners();
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Email ou senha incorretos',
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

  Future<dynamic> addUser(
      String NomeUser,
      String CPFUser,
      String EmailUser,
      String TelUser,
      String DataNascUser,
      String GeneroUser,
      String SenhaUser,
      String DescUser,
      String ImgUser,
      context) async {
    try {
      var response = await Dio().post('http://10.0.2.2:8000/api/addUsuario',
          data: {
            'NomeUser': NomeUser,
            'CPFUser': CPFUser,
            'EmailUser': EmailUser,
            'TelUser': TelUser,
            'DataNascUser': DataNascUser,
            'GeneroUser': GeneroUser,
            'SenhaUser': SenhaUser,
            'DescUser': DescUser,
            'ImgUser': ImgUser,
            'StatusUser': '1',
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

  Future<dynamic> updateUser(
      int idUser,
      String NomeUser,
      String CPFUser,
      String EmailUser,
      String TelUser,
      String DataNascUser,
      String GeneroUser,
      String SenhaUser,
      String DescUser,
      String ImgUser,
      String StatusUser,
      context) async {
    try {
      var response = await Dio()
          .put('http://10.0.2.2:8000/api/updateUsuario/$idUser', data: {
        'idUser': idUser,
        'NomeUser': NomeUser,
        'CPFUser': CPFUser,
        'EmailUser': EmailUser,
        'TelUser': TelUser,
        'DataNascUser': DataNascUser,
        'GeneroUser': GeneroUser,
        'SenhaUser': SenhaUser,
        'DescUser': DescUser,
        'ImgUser': ImgUser,
        'StatusUser': StatusUser,
      });
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
      String email, String senha, String novaSenha, int id, context) async {
    try {
      var response = await Dio()
          .get('http://10.0.2.2:8000/api/loginUsuario/$email/$senha');
      if (response.data['status'] == '200') {
        if (response.data['loginResult'] == '1') {
          updateSenhaUser(novaSenha, id, context);
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

  Future<dynamic> updateSenhaUser(String novaSenha, int id, context) async {
    try {
      user = UserPreferences.getUser();
      var response =
          await Dio().put('http://10.0.2.2:8000/api/updateUsuario/$id', data: {
        'idUser': user.idUser,
        'NomeUser': user.NomeUser,
        'CPFUser': user.CPFUser,
        'EmailUser': user.EmailUser,
        'TelUser': user.TelUser,
        'DataNascUser': user.DataNascUser,
        'GeneroUser': user.GeneroUser,
        'SenhaUser': novaSenha,
        'DescUser': user.DescUser,
        'ImgUser': user.ImgUser,
        'StatusUser': user.StatusUser,
      });
      if (response.data['status'] == '200') {
        user = User(
          idUser: user.idUser,
          NomeUser: user.NomeUser,
          CPFUser: user.CPFUser,
          EmailUser: user.EmailUser,
          TelUser: user.TelUser,
          DataNascUser: user.DataNascUser,
          GeneroUser: user.GeneroUser,
          SenhaUser: novaSenha,
          DescUser: user.DescUser,
          ImgUser: user.ImgUser,
          StatusUser: user.StatusUser,
        );
        UserPreferences.setUser(user);
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

  Future<dynamic> updateEmailUser(String emailUser, int id, context) async {
    try {
      user = UserPreferences.getUser();
      var response =
          await Dio().put('http://10.0.2.2:8000/api/updateUsuario/$id', data: {
        'idUser': user.idUser,
        'NomeUser': user.NomeUser,
        'CPFUser': user.CPFUser,
        'EmailUser': emailUser,
        'TelUser': user.TelUser,
        'DataNascUser': user.DataNascUser,
        'GeneroUser': user.GeneroUser,
        'SenhaUser': user.SenhaUser,
        'DescUser': user.DescUser,
        'ImgUser': user.ImgUser,
        'StatusUser': user.StatusUser,
      });
      if (response.data['status'] == '200') {
        user = User(
          idUser: user.idUser,
          NomeUser: user.NomeUser,
          CPFUser: user.CPFUser,
          EmailUser: emailUser,
          TelUser: user.TelUser,
          DataNascUser: user.DataNascUser,
          GeneroUser: user.GeneroUser,
          SenhaUser: user.SenhaUser,
          DescUser: user.DescUser,
          ImgUser: user.ImgUser,
          StatusUser: user.StatusUser,
        );
        UserPreferences.setUser(user);
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

  Future<dynamic> updateTelUser(String telUser, int id, context) async {
    try {
      user = UserPreferences.getUser();
      var response =
          await Dio().put('http://10.0.2.2:8000/api/updateUsuario/$id', data: {
        'idUser': user.idUser,
        'NomeUser': user.NomeUser,
        'CPFUser': user.CPFUser,
        'EmailUser': user.EmailUser,
        'TelUser': telUser,
        'DataNascUser': user.DataNascUser,
        'GeneroUser': user.GeneroUser,
        'SenhaUser': user.SenhaUser,
        'DescUser': user.DescUser,
        'ImgUser': user.ImgUser,
        'StatusUser': user.StatusUser,
      });
      if (response.data['status'] == '200') {
        user = User(
          idUser: user.idUser,
          NomeUser: user.NomeUser,
          CPFUser: user.CPFUser,
          EmailUser: user.EmailUser,
          TelUser: telUser,
          DataNascUser: user.DataNascUser,
          GeneroUser: user.GeneroUser,
          SenhaUser: user.SenhaUser,
          DescUser: user.DescUser,
          ImgUser: user.ImgUser,
          StatusUser: user.StatusUser,
        );
        UserPreferences.setUser(user);
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
