import 'package:deeper_riverpod_education/src/features/postcard/data/datasources/user_local_datasource.dart';
import 'package:deeper_riverpod_education/src/features/postcard/data/repositories/user_data_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDataProvider = ChangeNotifierProvider<UserDataRepositoryImpl>((ref) {
  return UserDataRepositoryImpl(UserLocalDatasource());
});
