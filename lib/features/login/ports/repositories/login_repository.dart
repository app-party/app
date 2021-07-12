import 'package:dartz/dartz.dart';
import 'package:party_app/features/login/domain/entities/login_user.dart';
import 'package:party_app/global/error/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> login(LoginUser user);
}
