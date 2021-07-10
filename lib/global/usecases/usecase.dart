import 'package:dartz/dartz.dart';
import 'package:party_app/global/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call({Params? params});
}

class NoParams {}
