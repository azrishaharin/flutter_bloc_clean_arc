import 'package:flutter_bloc_tdd/src/core/utils/typedef.dart';

abstract class UsecaseWithParams<T, Params> {
  const UsecaseWithParams();
  ResultFuture<T> call(Params params);
}

abstract class UsecaseWithoutParams<T> {
  const UsecaseWithoutParams();
  ResultFuture<T> call();
}
