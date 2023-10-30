import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_tdd/src/core/errors/exceptions.dart';
import 'package:flutter_bloc_tdd/src/core/errors/failure.dart';
import 'package:flutter_bloc_tdd/src/domain/usecases/create_user.dart';
import 'package:flutter_bloc_tdd/src/domain/usecases/get_users.dart';
import 'package:flutter_bloc_tdd/src/presentation/bloc/bloc/authentication_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationBloc bloc;

  const tCreateUserParams = CreateUserParams.empty();
  const tAPIFailure = ApiFailure(message: 'error', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    bloc = AuthenticationBloc(
      getUsers: getUsers,
      createUser: createUser,
    );
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => bloc.close());

  test('initial state should be [AuthenticationInitial]', () async {
    expect(bloc.state, const AuthenticationInitial());
  });

  group('createUser', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [CreatingUser, UserCreated] when [CreateUserEvent] is added.',
        build: () {
          when(() => createUser(any()))
              .thenAnswer((_) async => const Right(null));
          return bloc;
        },
        act: (bloc) => bloc.add(CreateUserEvent(
            createdAt: tCreateUserParams.createdAt,
            name: tCreateUserParams.name,
            avatar: tCreateUserParams.avatar)),
        expect: () =>
            const <AuthenticationState>[CreatingUser(), UserCreated()],
        verify: (bloc) {
          verify(() => createUser(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });

    blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationError] when [CreateUserEvent] is added.',
        build: () {
          when(() => createUser(any()))
              .thenAnswer((_) async => const Left(tAPIFailure));
          return bloc;
        },
        act: (bloc) => bloc.add(CreateUserEvent(
            createdAt: tCreateUserParams.createdAt,
            name: tCreateUserParams.name,
            avatar: tCreateUserParams.avatar)),
        expect: () => <AuthenticationState>[
              const CreatingUser(),
              AuthenticationError(tAPIFailure.errorMessage)
            ],
        verify: (bloc) {
          verify(() => createUser(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });
  });

  group('getUsers', () {
    blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [GettingUsers, UserLoaded] when [GetUsersEvent] is added.',
        build: () {
          when(() => getUsers()).thenAnswer((_) async => const Right([]));
          return bloc;
        },
        act: (bloc) => bloc.add(const GetUsersEvent()),
        expect: () =>
            const <AuthenticationState>[GettingUsers(), UserLoaded([])],
        verify: (bloc) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });

    blocTest<AuthenticationBloc, AuthenticationState>(
        'emits [AuthenticationError] when [GetUsersEvent] is added.',
        build: () {
          when(() => getUsers())
              .thenAnswer((_) async => const Left(tAPIFailure));
          return bloc;
        },
        act: (bloc) => bloc.add(const GetUsersEvent()),
        expect: () => <AuthenticationState>[
              const GettingUsers(),
              AuthenticationError(tAPIFailure.errorMessage)
            ],
        verify: (bloc) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });
  });
}
