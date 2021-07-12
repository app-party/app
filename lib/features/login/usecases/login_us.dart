import 'package:dartz/dartz.dart';
import 'package:party_app/features/login/domain/entities/login_user.dart';
import 'package:party_app/features/login/ports/repositories/login_repository.dart';
import 'package:party_app/global/error/failures.dart';
import 'package:party_app/global/usecase/usecase.dart';

class LoginUS extends UseCase<String, LoginUser> {
  final LoginRepository repository;

  LoginUS(this.repository);

  @override
  Future<Either<Failure, String>> call(LoginUser params) {
    return repository.login(params);
  }
}
