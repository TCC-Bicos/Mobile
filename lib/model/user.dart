class User {
  final String imagePath;
  final String name;
  final String profissao;
  final String about;

  const User({
    required this.imagePath,
    required this.name,
    required this.profissao,
    required this.about,
  });

  User copy({
    String? imagePath,
    String? name,
    String? profissao,
    String? password,
    String? about,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        profissao: profissao ?? this.profissao,
        about: about ?? this.about,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        imagePath: json['imagePath'],
        name: json['name'],
        profissao: json['profissão'],
        about: json['about'],
      );
  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'profissão': profissao,
        'about': about,
      };
}
