import 'package:flutter_bloc_tdd/src/core/usecase/usecase.dart';
import 'package:flutter_bloc_tdd/src/core/utils/typedef.dart';
import 'package:flutter_bloc_tdd/src/domain/entities/user.dart';
import 'package:flutter_bloc_tdd/src/domain/repository/auth_repo.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  const GetUsers(this._repository);

  final AuthRepo _repository;

  @override
  ResultFuture<List<User>> call() async => _repository.getUsers();
}
