import 'package:dartz/dartz.dart';
import 'package:party_app/features/signup/domain/entities/signup_user.dart';
import 'package:party_app/global/error/failures.dart';

abstract class SignupRepository {
  Future<Either<Failure, String>> createUser({required SignupUser user});
}
