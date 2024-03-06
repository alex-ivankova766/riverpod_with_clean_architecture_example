import 'dart:async';

import 'package:deeper_riverpod_education/src/features/postcard/data/datasources/user_local_datasource.dart';
import 'package:deeper_riverpod_education/src/features/postcard/domain/repositories/user_data_repository.dart';
import 'package:deeper_riverpod_education/src/shared/domain/entities/user.dart';
import 'package:flutter/material.dart';

class UserDataRepositoryImpl extends UserDataRepository with ChangeNotifier {
  UserDataRepositoryImpl(this.userLocalDatasource) {
    getUserData();
  }
  final UserLocalDatasource userLocalDatasource;
  User? user;

  @override
  void removeUserData() {
    user = null;
    notifyListeners();
    userLocalDatasource.removeUserData();
  }

  @override
  Future<void> getUserData() async {
    User? userFromLocalData = await userLocalDatasource.getUserData();
    if (userFromLocalData == null) {
      return;
    }
    user = userFromLocalData;
    notifyListeners();
  }

  @override
  Future<void> saveUserData(User userdata) {
    user = userdata;
    notifyListeners();
    return userLocalDatasource.saveUserData(userdata);
  }
}
