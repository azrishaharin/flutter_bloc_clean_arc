import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_tdd/src/core/usecase/usecase.dart';
import 'package:flutter_bloc_tdd/src/core/utils/typedef.dart';
import 'package:flutter_bloc_tdd/src/domain/repository/auth_repo.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  const CreateUser(this._repository);

  final AuthRepo _repository;

  @override
  ResultVoid call(CreateUserParams params) async => _repository.createUser(
      createdAt: params.createdAt, name: params.name, avatar: params.avatar);
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams.empty()
      : createdAt = '',
        name = '',
        avatar = '';

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
