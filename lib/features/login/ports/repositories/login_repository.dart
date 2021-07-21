import 'package:dartz/dartz.dart';
import 'package:party_app/features/login/domain/entities/login_user.dart';
import 'package:party_app/global/error/failures.dart';
import 'package:party_app/global/utils/listfy.dart';

abstract class LoginRepository extends Listfy {
  Future<Either<Failure, String>> login(LoginUser user);
}
