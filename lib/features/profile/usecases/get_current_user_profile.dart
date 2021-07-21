import 'package:dartz/dartz.dart';
import 'package:party_app/features/profile/domain/entities/profile.dart';
import 'package:party_app/features/profile/ports/repositories/profile_repository.dart';
import 'package:party_app/global/error/failures.dart';
import 'package:party_app/global/usecase/usecase.dart';

class GetCurrentUserProfile extends UseCase<Profile, NoParams> {
  final ProfileRepository repository;

  GetCurrentUserProfile(this.repository);

  @override
  Future<Either<Failure, Profile>> call(NoParams params) {
    return repository.getMyProfile();
  }
}
