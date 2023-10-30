import 'package:flutter_bloc_tdd/src/core/utils/typedef.dart';
import 'package:flutter_bloc_tdd/src/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<void> createUser({
    required String name,
    required String avatar,
    required String createdAt,
  });

  ResultFuture<List<User>> getUsers();
}
