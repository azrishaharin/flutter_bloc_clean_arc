import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_tdd/src/auth/data/datasource/auth_remote.dart';
import 'package:flutter_bloc_tdd/src/auth/data/repos/auth_repo_imp.dart';
import 'package:flutter_bloc_tdd/src/core/errors/exceptions.dart';
import 'package:flutter_bloc_tdd/src/core/errors/failure.dart';
import 'package:flutter_bloc_tdd/src/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepoImp sut;

  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    sut = AuthRepoImp(mockAuthRemoteDataSource);
  });

  group(
    "createUser",
    () {
      test("should call the [AuthRemoteDataSource.createUser]", () async {
        when(() => mockAuthRemoteDataSource.createUser(
              name: any(named: "name"),
              avatar: any(named: "avatar"),
              createdAt: any(named: "createdAt"),
            )).thenAnswer((_) async => Future.value()); //Future.value = void

        final result = await sut.createUser(
          name: "name",
          avatar: "avatar",
          createdAt: "createdAt",
        );
        expect(result, const Right(null));
        verify(() => mockAuthRemoteDataSource.createUser(
            name: any(named: "name"),
            createdAt: any(named: "createdAt"),
            avatar: any(named: "avatar"))).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });

      test(
        "should return a [Failure] when [AuthRemoteDataSource.createUser] returns a failure",
        () async {
          // Arrange
          when(() => mockAuthRemoteDataSource.createUser(
                    name: any(named: "name"),
                    avatar: any(named: "avatar"),
                    createdAt: any(named: "createdAt"),
                  ))
              .thenThrow(const APIException(
                  message: 'Unknown Error Occurred',
                  statusCode: 500)); //Exception().value = void

          // Act
          final result = await sut.createUser(
            name: "name",
            avatar: "avatar",
            createdAt: "createdAt",
          );

          // Assert
          expect(
              result,
              const Left(ApiFailure(
                  message: "Unknown Error Occurred", statusCode: 500)));

          verify(() => mockAuthRemoteDataSource.createUser(
              name: any(named: "name"),
              createdAt: any(named: "createdAt"),
              avatar: any(named: "avatar"))).called(1);

          verifyNoMoreInteractions(mockAuthRemoteDataSource);
        },
      );
    },
  );

  group(
    "getUsers",
    () {
      test(
        "should call the [AuthRemoteDataSource.getUsers]",
        () async {
          // Arrange
          when(() => mockAuthRemoteDataSource.getUsers())
              .thenAnswer((_) async => Future.value([])); //Future.value = void

          // Act
          final result = await sut.getUsers();

          // Assert
          expect(
              result,
              isA<
                  Right<
                      dynamic,
                      List<
                          User>>>()); // expect result to be a Right<List<User>>
          verify(() => mockAuthRemoteDataSource.getUsers()).called(1);
          verifyNoMoreInteractions(mockAuthRemoteDataSource);
        },
      );

      test(
          "should return a [Failure] when [AuthRemoteDataSource.getUsers] returns a failure",
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.getUsers()).thenThrow(
            const APIException(
                message: 'Unknown Error Occurred', statusCode: 500));

        // Act
        final result = await sut.getUsers();

        // Assert
        expect(
            result,
            const Left(ApiFailure(
                message: "Unknown Error Occurred", statusCode: 500)));

        verify(() => mockAuthRemoteDataSource.getUsers()).called(1);

        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      });
    },
  );
}
