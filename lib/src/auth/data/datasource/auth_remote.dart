import 'dart:convert';

import 'package:flutter_bloc_tdd/src/auth/data/models/user_model.dart';
import 'package:flutter_bloc_tdd/src/core/utils/constant.dart';
import 'package:flutter_bloc_tdd/src/core/utils/typedef.dart';
import 'package:http/http.dart' as http;
import '../../../core/errors/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt});

  Future<List<UserModel>> getUsers();
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImp(this._client);

  final http.Client _client;

  @override
  Future<void> createUser(
      {required String name,
      required String avatar,
      required String createdAt}) async {
    try {
      final result = await _client.post(Uri.parse('$kBaseUrl/users'),
          body: jsonEncode({
            'name': name,
            'avatar': avatar,
            'createdAt': createdAt,
          }),
          headers: {
            'Content-Type': 'application/json',
          });

      if (result.statusCode != 201 && result.statusCode != 200) {
        throw APIException(message: result.body, statusCode: result.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 400);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(Uri.parse('$kBaseUrl/users'));

      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((e) => UserModel.fromMap(e))
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 500);
    }
  }
}
