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

  User copy({
    int? idUser,
    String? NomeUser,
    String? CPFUser,
    String? EmailUser,
    String? TelUser,
    String? DataNascUser,
    String? GeneroUser,
    String? SenhaUser,
    String? ImgUser,
    String? DescUser,
    String? StatusUser,
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        NomeUser: NomeUser ?? this.NomeUser,
        CPFUser: CPFUser ?? this.CPFUser,
        EmailUser: EmailUser ?? this.EmailUser,
        TelUser: TelUser ?? this.TelUser,
        DataNascUser: DataNascUser ?? this.DataNascUser,
        GeneroUser: GeneroUser ?? this.GeneroUser,
        SenhaUser: SenhaUser ?? this.SenhaUser,
        DescUser: DescUser ?? this.DescUser,
        ImgUser: ImgUser ?? this.ImgUser,
        StatusUser: StatusUser ?? this.StatusUser,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        idUser: json['idUser'],
        NomeUser: json['NomeUser'],
        CPFUser: json['CPFUser'],
        EmailUser: json['EmailUser'],
        TelUser: json['TelUser'],
        DataNascUser: json['DataNascUser'],
        GeneroUser: json['GeneroUser'],
        SenhaUser: json['SenhaUser'],
        DescUser: json['DescUser'],
        ImgUser: json['ImgUser'],
        StatusUser: json['statusUser'],
      );
  Map<String, dynamic> toJson() => {
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
      };
}
