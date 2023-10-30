import 'dart:convert';

import 'package:flutter_bloc_tdd/src/core/utils/typedef.dart';
import 'package:flutter_bloc_tdd/src/domain/entities/user.dart';

// act as a child for User
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.createdAt,
  });

  const UserModel.empty()
      : this(
          id: "1",
          name: '',
          avatar: '',
          createdAt: '',
        );

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
          avatar: map['avatar'] as String,
          createdAt: map['createdAt'] as String,
          id: map['id'] as String,
          name: map['name'] as String,
        );

  // Use copyWith method to create a new instance with updated values
  UserModel copyWith({
    String? avatar,
    String? createdAt,
    String? id,
    String? name,
  }) {
    return UserModel(
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  DataMap toMap() => {
        'avatar': avatar,
        'createdAt': createdAt,
        'id': id,
        'name': name,
      };

  String toJson() => jsonEncode(toMap());

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, avatar: $avatar, createdAt: $createdAt)';
  }
}
