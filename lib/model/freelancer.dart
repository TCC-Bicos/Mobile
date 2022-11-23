class Freelancer {
  final int idFr;
  final String CompetenciasFr;
  final String NomeFr;
  final String CPFFr;
  final String EmailFr;
  final String TelFr;
  final String DataNascFr;
  final String GeneroFr;
  final String SenhaFr;
  final String DescFr;
  final String ImgFr;
  final String StatusFr;

  const Freelancer({
    required this.idFr,
    required this.CompetenciasFr,
    required this.NomeFr,
    required this.CPFFr,
    required this.EmailFr,
    required this.TelFr,
    required this.DataNascFr,
    required this.GeneroFr,
    required this.SenhaFr,
    required this.DescFr,
    required this.ImgFr,
    required this.StatusFr,
  });

  Freelancer copy({
    int? idFr,
    String? CompetenciasFr,
    String? NomeFr,
    String? CPFFr,
    String? EmailFr,
    String? TelFr,
    String? DataNascFr,
    String? GeneroFr,
    String? SenhaFr,
    String? DescFr,
    String? ImgFr,
    String? StatusFr,
  }) =>
      Freelancer(
        idFr: idFr ?? this.idFr,
        CompetenciasFr: NomeFr ?? this.CompetenciasFr,
        NomeFr: NomeFr ?? this.NomeFr,
        CPFFr: CPFFr ?? this.CPFFr,
        EmailFr: EmailFr ?? this.EmailFr,
        TelFr: TelFr ?? this.TelFr,
        DataNascFr: DataNascFr ?? this.DataNascFr,
        GeneroFr: GeneroFr ?? this.GeneroFr,
        SenhaFr: SenhaFr ?? this.SenhaFr,
        DescFr: DescFr ?? this.DescFr,
        ImgFr: ImgFr ?? this.ImgFr,
        StatusFr: StatusFr ?? this.StatusFr,
      );

  static Freelancer fromJson(Map<String, dynamic> json) => Freelancer(
        idFr: json['idFr'],
        CompetenciasFr: json['CompetenciasFr'],
        NomeFr: json['NomeFr'],
        CPFFr: json['CPFFr'],
        EmailFr: json['EmailFr'],
        TelFr: json['TelFr'],
        DataNascFr: json['DataNascFr'],
        GeneroFr: json['GeneroFr'],
        SenhaFr: json['SenhaFr'],
        DescFr: json['DescFr'],
        ImgFr: json['ImgFr'],
        StatusFr: json['statusFr'],
      );
  Map<String, dynamic> toJson() => {
        'idFr': idFr,
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
      };
}
