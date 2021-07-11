import 'package:dartz/dartz.dart';
import 'package:party_app/features/signup/domain/entities/signup_user.dart';
import 'package:party_app/features/signup/ports/repositories/signup_repository.dart';
import 'package:party_app/global/error/failures.dart';
import 'package:party_app/global/usecase/usecase.dart';

class CreateUserUS extends UseCase<String, SignupUser> {
  final SignupRepository repository;

  CreateUserUS(this.repository);

  @override
  Future<Either<Failure, String>> call(SignupUser params) {
    return repository.createUser(user: params);
  }
}
