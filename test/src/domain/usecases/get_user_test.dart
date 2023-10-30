import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_tdd/src/domain/repository/auth_repo.dart';
import 'package:flutter_bloc_tdd/src/domain/usecases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authrepo.mock.dart';

void main() {
  late GetUsers usecase;
  late AuthRepo repository;

  setUp(() => {
        repository = MockAuthRepo(),
        usecase = GetUsers(repository),
      });

  test(
    'should call the [AuthRepo.getUser]',
    () => () async {
      // Arrange
      when(() => repository.getUsers()).thenAnswer((_) async =>
          const Right([])); //placing Right(null) for void functions

      // Act
      final result = await usecase();

      // Assert
      expect(result, equals(const Right([])));
      verify(() => repository.getUsers()).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
