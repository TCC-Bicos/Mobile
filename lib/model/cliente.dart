import 'package:dropdown_date_picker/dropdown_date_picker.dart';

class Cliente {
  final int idCliente;
  final String nomeCliente;
  final String cpfCliente;
  final String emailCliente;
  final String telefoneCliente;
  final String nascimentoCliente;
  final String generoCliente;
  final String senhaCliente;
  final String imagemCliente;
  final String statusCliente;
  // final String sobreCliente;

  const Cliente({
    required this.idCliente,
    required this.nomeCliente,
    required this.cpfCliente,
    required this.emailCliente,
    required this.telefoneCliente,
    required this.nascimentoCliente,
    required this.generoCliente,
    required this.senhaCliente,
    required this.imagemCliente,
    required this.statusCliente,
    // required this.sobreCliente,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      idCliente: json['cliente']['idCliente'],
      nomeCliente: json['cliente']['nomeCliente'],
      cpfCliente: json['cliente']['cpfCliente'],
      emailCliente: json['cliente']['emailCliente'],
      telefoneCliente: json['cliente']['telefoneCliente'],
      nascimentoCliente: json['cliente']['nascimentoCliente'],
      generoCliente: json['cliente']['generoCliente'],
      senhaCliente: json['cliente']['senhaCliente'],
      imagemCliente: json['cliente']['imagemCliente'],
      statusCliente: json['cliente']['statusCliente'],
      // sobreCliente: json['cliente']['sobreCliente'],
    );
  }
}
