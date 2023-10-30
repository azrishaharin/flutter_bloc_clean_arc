import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_tdd/src/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = Future<Either<Failure, void>>;

typedef DataMap = Map<String, dynamic>;
