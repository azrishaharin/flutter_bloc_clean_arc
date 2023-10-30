import 'dart:convert';

import 'package:flutter_bloc_tdd/src/auth/data/datasource/auth_remote.dart';
import 'package:flutter_bloc_tdd/src/auth/data/models/user_model.dart';
import 'package:flutter_bloc_tdd/src/core/errors/exceptions.dart';
import 'package:flutter_bloc_tdd/src/core/utils/constant.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late AuthRemoteDataSourceImp dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = AuthRemoteDataSourceImp(mockHttpClient);
    registerFallbackValue(
        Uri.parse('https://65365b01bb226bb85dd1f887.mockapi.io'));
  });

  group('createUser', () {
    test('should perform a post request', () async {
      // Arrange
      when(() => mockHttpClient.post(any(), body: any(named: "body")))
          .thenAnswer(
              (_) async => http.Response('User created successfully', 201));

      // Act
      final methodCall = dataSource.createUser;

      // Assert
      expect(methodCall(name: 'name', avatar: 'avatar', createdAt: 'createdAt'),
          completes);
      verify(() => mockHttpClient.post(
            Uri.parse('$kBaseUrl/users'),
            body: jsonEncode({
              'name': 'name',
              'avatar': 'avatar',
              'createdAt': 'createdAt',
            }),
          )).called(1);

      verifyNoMoreInteractions(mockHttpClient);
    });

    test(
        'should return a [Failure] when [AuthRemoteDataSource.createUser] returns a failure',
        () async {
      // Arrange
      when(() => mockHttpClient.post(any(), body: any(named: "body")))
          .thenAnswer((_) async => http.Response('Invalid email address', 400));

      // Act
      final methodCall = dataSource.createUser(
        name: 'name',
        avatar: 'avatar',
        createdAt: 'createdAt',
      );

      // Assert
      expect(
          () => methodCall,
          throwsA(const APIException(
              message: 'Invalid email address', statusCode: 400)));
      verify(() => mockHttpClient.post(
            Uri.parse('$kBaseUrl/users'),
            body: jsonEncode({
              'name': 'name',
              'avatar': 'avatar',
              'createdAt': 'createdAt',
            }),
          )).called(1);

      verifyNoMoreInteractions(mockHttpClient);
    });
  });

  group('getUsers', () {
    const tUsers = [UserModel.empty()];
    test('should perform a get request', () async {
      // Arrange
      when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200));

      // Act
      final result = await dataSource.getUsers();

      // Assert
      expect(result, tUsers);
      verify(() => mockHttpClient.get(Uri.parse('$kBaseUrl/users'))).called(1);
      verifyNoMoreInteractions(mockHttpClient);
    });

    test(
        'should return a [Failure] when [AuthRemoteDataSource.getUsers] returns a failure',
        () {
      // Arrange
      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response('Something went wrong', 500));
      // Act
      final result = dataSource.getUsers();
      // Assert
      expect(
          () => result,
          throwsA(const APIException(
              message: 'Something went wrong', statusCode: 500)));

      verify(() => mockHttpClient.get(Uri.parse('$kBaseUrl/users'))).called(1);
      verifyNoMoreInteractions(mockHttpClient);
    });
  });
}
