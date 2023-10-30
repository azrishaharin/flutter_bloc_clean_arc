import 'dart:convert';

import 'package:flutter_bloc_tdd/src/auth/data/models/user_model.dart';
import 'package:flutter_bloc_tdd/src/core/utils/typedef.dart';
import 'package:flutter_bloc_tdd/src/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  test('should be a subclass of User', () {
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      final result = UserModel.fromMap(tMap);
      expect(result, tModel);
    });
  });
  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      final result = UserModel.fromJson(tJson);
      expect(result, tModel);
    });
  });

  group('toMap', () {
    test('should return a [DataMap] with the right data', () {
      final result = tModel.toMap();
      expect(result, tMap);
    });
  });
  group('toJson', () {
    test('should return a [UserModel] data as a json', () {
      final result = tModel.toJson();
      expect(result, tJson);
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with the different data', () {
      final result = tModel.copyWith(name: "Jackie");
      expect(result.name, "Jackie");
      expect(result, isNot(tModel));
    });
  });
}
