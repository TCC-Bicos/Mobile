class AnuncioUsuario {
  final int idAnunUser;
  final String TituloAnunUser;
  final String DescAnunUser;
  final double PrecoAnunUser;
  final String RequisitosAnunUser;
  final String ImgAnunUser;
  final String StatusAnunUser;
  final String DataAnunUser;
  final int idUserAnunUser;
  final int idTipoServAnunUser;

  const AnuncioUsuario({
    required this.idAnunUser,
    required this.TituloAnunUser,
    required this.DescAnunUser,
    required this.PrecoAnunUser,
    required this.RequisitosAnunUser,
    required this.ImgAnunUser,
    required this.StatusAnunUser,
    required this.DataAnunUser,
    required this.idUserAnunUser,
    required this.idTipoServAnunUser,
  });
}
