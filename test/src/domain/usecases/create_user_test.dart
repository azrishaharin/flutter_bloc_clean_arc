// What does the class depend on?
// Answer - AuthRepo
// How can we create a fake version of the dependency?
// Answer - Mocktail package
// How do we control what our dependency does?
// Answer - Using the Mocktail API's

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_tdd/src/domain/repository/auth_repo.dart';
import 'package:flutter_bloc_tdd/src/domain/usecases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authrepo.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthRepo repository;

  //setUp is called before each test
  setUp(() {
    //we dont want to use the real repository
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
    //use when to add datatype to any();
    // registerFallbackValue(class);
  });

  const params = CreateUserParams.empty();
  test(
    'should call the [AuthRepo.createUser]',
    () => () async {
      // Arrange
      when(() => repository.createUser(
                createdAt: any(named: 'createdAt'),
                name: any(named: 'name'),
                avatar: any(named: 'avatar'),
              ))
          .thenAnswer((_) async =>
              const Right(null)); //placing Right(null) for void functions

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => repository.createUser(
            createdAt: 'createdAt',
            name: 'name',
            avatar: 'avatar',
          )).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
