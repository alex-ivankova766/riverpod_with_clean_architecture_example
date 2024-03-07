import '../entities/user.dart';

abstract class UserDataRepository {
  Future<void> getUserData();
  Future<void> saveUserData(User userdata);
  void removeUserData();
}
