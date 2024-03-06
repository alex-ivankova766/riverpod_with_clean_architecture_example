import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/domain/entities/user.dart';

abstract class UserDatasource {
  Future<User?> getUserData();
  Future<void> saveUserData(User userdata);
  Future<void> removeUserData();
}

class UserLocalDatasource extends UserDatasource {
  UserLocalDatasource();

  @override
  Future<User?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? name = prefs.getString('name');
    if (name == null) {
      return null;
    }
    final String? birthDateString = prefs.getString('birthDate');
    if (birthDateString == null) {
      return null;
    }
    final DateTime birthDate = DateTime.parse(birthDateString);
    return User(name: Name.dirty(name), birthDate: birthDate);
  }

  @override
  Future<void> saveUserData(User userdata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', userdata.name.value);

    await prefs.setString('birthDate', userdata.birthDate.toIso8601String());
  }

  @override
  Future<void> removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('birthDate');
  }
}
