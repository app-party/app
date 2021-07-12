import 'package:dartz/dartz.dart';
import 'package:party_app/features/signup/domain/entities/pin_code.dart';
import 'package:party_app/features/signup/ports/repositories/signup_repository.dart';
import 'package:party_app/global/error/failures.dart';
import 'package:party_app/global/usecase/usecase.dart';

class EnableUserUS extends UseCase<void, PinCode> {
  final SignupRepository repository;

  EnableUserUS(this.repository);

  @override
  Future<Either<Failure, void>> call(PinCode params) {
    return repository.enableUser(params);
  }
}
