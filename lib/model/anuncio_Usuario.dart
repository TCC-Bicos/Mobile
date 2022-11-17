class AnuncioUsuario {
  final String TituloAnunUser;
  final String DescAnunUser;
  final String PrecoAnunUser;
  final String RequisitosAnunUser;
  final String ImgAnunUser;
  final String StatusAnunUser;
  final String DataAnunUser;
  final int idUserAnunUser;
  final String NomeServAnunUser;

  const AnuncioUsuario({
    required this.TituloAnunUser,
    required this.DescAnunUser,
    required this.PrecoAnunUser,
    required this.RequisitosAnunUser,
    required this.ImgAnunUser,
    required this.StatusAnunUser,
    required this.DataAnunUser,
    required this.idUserAnunUser,
    required this.NomeServAnunUser,
  });

  factory AnuncioUsuario.fromJson(Map<String, dynamic> json) {
    return AnuncioUsuario(
      TituloAnunUser: json['AnuncioUsuario']['TituloAnunUser'],
      DescAnunUser: json['AnuncioUsuario']['DescAnunUser'],
      PrecoAnunUser: json['AnuncioUsuario']['PrecoAnunUser'],
      RequisitosAnunUser: json['AnuncioUsuario']['RequisitosAnunUser'],
      ImgAnunUser: json['AnuncioUsuario']['ImgAnunUser'],
      StatusAnunUser: json['AnuncioUsuario']['StatusAnunUser'],
      DataAnunUser: json['AnuncioUsuario']['DataAnunUser'],
      idUserAnunUser: json['AnuncioUsuario']['idUserAnunUser'],
      NomeServAnunUser: json['AnuncioUsuario']['NomeServAnunUser'],
    );
  }
}
