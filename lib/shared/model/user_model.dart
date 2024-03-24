class UserModel {
  final String id;
  final String nomeCompleto;
  final String email;
  final String password;
  final String? oldPassword;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.nomeCompleto,
    required this.email,
    required this.password,
    this.oldPassword,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nomeCompleto: json['nome_completo'],
      email: json['email'],
      password: json['password'],
      oldPassword: json['old_password'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
