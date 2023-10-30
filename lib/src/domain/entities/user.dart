import 'package:equatable/equatable.dart';

// only act as a blueprint, no data, no methods
class User extends Equatable {
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  //this required, follow the constructor
  const User.empty()
      : this(
          id: "1",
          name: '',
          avatar: '',
          createdAt: '',
        );

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [id, createdAt, name, avatar];

  @override
  String toString() {
    return 'User(id: $id, name: $name, avatar: $avatar)';
  }

  // @override
  // bool operator ==(Object other) {
  //   return identical(this, other) ||
  //       other is User && runtimeType == other.runtimeType && id == other.id;
  // }

  // @override
  // int get hashCode => id.hashCode;
}
