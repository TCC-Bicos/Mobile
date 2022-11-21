class TipoServico {
  final String NomeServ;
  final String CategoriaServ;

  const TipoServico({
    required this.NomeServ,
    required this.CategoriaServ,
  });

  TipoServico copy({
    String? NomeServ,
    String? CategoriaServ,
  }) =>
      TipoServico(
        NomeServ: NomeServ ?? this.NomeServ,
        CategoriaServ: CategoriaServ ?? this.CategoriaServ,
      );

  static TipoServico fromJson(Map<String, dynamic> json) => TipoServico(
        NomeServ: json['NomeServ'],
        CategoriaServ: json['CategoriaServ'],
      );
  Map<String, dynamic> toJson() => {
        'NomeServ': NomeServ,
        'CategoriaServ': CategoriaServ,
      };
}
