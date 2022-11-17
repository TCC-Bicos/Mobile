class User {
  final int idUser;
  final String NomeUser;
  final String CPFUser;
  final String EmailUser;
  final String TelUser;
  final String DataNascUser;
  final String GeneroUser;
  final String SenhaUser;
  final String ImgUser;
  final String DescUser;
  final String StatusUser;

  const User({
    required this.idUser,
    required this.NomeUser,
    required this.CPFUser,
    required this.EmailUser,
    required this.TelUser,
    required this.DataNascUser,
    required this.GeneroUser,
    required this.SenhaUser,
    required this.ImgUser,
    required this.DescUser,
    required this.StatusUser,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idUser: json['User']['idUser'],
      NomeUser: json['User']['NomeUser'],
      CPFUser: json['User']['CPFUser'],
      EmailUser: json['User']['EmailUser'],
      TelUser: json['User']['TelUser'],
      DataNascUser: json['User']['DataNascUser'],
      GeneroUser: json['User']['GeneroUser'],
      SenhaUser: json['User']['SenhaUser'],
      DescUser: json['User']['DescUser'],
      ImgUser: json['User']['ImgUser'],
      StatusUser: json['User']['statusUser'],
    );
  }
}
