import 'package:deeper_riverpod_education/src/features/postcard/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user.dart';

abstract class UserDatasource {
  Future<User?> getUserData();
  Future<void> saveUserData(UserModel userdata);
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
  Future<void> saveUserData(UserModel userdata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', userdata.name);

    await prefs.setString('birthDate', userdata.birthDate);
  }

  @override
  Future<void> removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('birthDate');
  }
}
