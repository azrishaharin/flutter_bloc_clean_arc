import 'package:flutter_bloc_tdd/src/auth/data/datasource/auth_remote.dart';
import 'package:flutter_bloc_tdd/src/auth/data/repos/auth_repo_imp.dart';
import 'package:flutter_bloc_tdd/src/domain/repository/auth_repo.dart';
import 'package:flutter_bloc_tdd/src/domain/usecases/create_user.dart';
import 'package:flutter_bloc_tdd/src/domain/usecases/get_users.dart';
import 'package:flutter_bloc_tdd/src/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
      () => AuthenticationBloc(createUser: sl(), getUsers: sl()));

  //Use cases
  sl.registerLazySingleton(() => CreateUser(sl()));
  sl.registerLazySingleton(() => GetUsers(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImp(sl()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(sl()));

  // External
  sl.registerLazySingleton(http.Client.new);
}
