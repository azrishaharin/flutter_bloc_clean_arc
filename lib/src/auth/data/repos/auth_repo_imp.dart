import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_tdd/src/auth/data/datasource/auth_remote.dart';
import 'package:flutter_bloc_tdd/src/core/errors/exceptions.dart';
import 'package:flutter_bloc_tdd/src/core/errors/failure.dart';
import 'package:flutter_bloc_tdd/src/core/utils/typedef.dart';
import 'package:flutter_bloc_tdd/src/domain/entities/user.dart';
import 'package:flutter_bloc_tdd/src/domain/repository/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  const AuthRepoImp(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  // Dependency Injection - inject dependencies to class if got multiple usecase
  // become testable code because the class was injected

  @override

  //if Future<void> always return null
  ResultVoid createUser(
      {required String name,
      required String avatar,
      required String createdAt}) async {
    try {
      await _remoteDataSource.createUser(
        name: name,
        avatar: avatar,
        createdAt: createdAt,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final users = await _remoteDataSource.getUsers();
      return Right(users);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
