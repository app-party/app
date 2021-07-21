import 'package:dartz/dartz.dart';
import 'package:party_app/features/profile/domain/entities/edit_profile.dart';
import 'package:party_app/features/profile/ports/repositories/profile_repository.dart';
import 'package:party_app/global/error/failures.dart';
import 'package:party_app/global/usecase/usecase.dart';

class UpdateProfileUS extends UseCase<void, EditProfile> {
  final ProfileRepository repository;

  UpdateProfileUS(this.repository);

  @override
  Future<Either<Failure, void>> call(EditProfile params) {
    return repository.update(params);
  }
}
