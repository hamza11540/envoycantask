import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

import '../failure/failure.dart';


abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params prams);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params prams);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
class IdParams extends Equatable {
  final String? id;

  const IdParams({this.id});

  @override
  List<Object> get props => [id!];
}
