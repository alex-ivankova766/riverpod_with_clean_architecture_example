import '../../domain/entities/user.dart';

class UserModel {
  const UserModel({
    required this.name,
    required this.birthDate,
  });
  final String name;
  final String birthDate;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      birthDate: json['birthDate'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      name: user.name.value,
      birthDate: user.birthDate.toIso8601String(),
    );
  }

  User toEntity() {
    return User(
      name: Name.dirty(name),
      birthDate: DateTime.parse(birthDate),
    );
  }
}
