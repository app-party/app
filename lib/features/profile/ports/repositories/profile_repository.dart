import 'package:dartz/dartz.dart';
import 'package:party_app/features/profile/domain/entities/edit_profile.dart';
import 'package:party_app/features/profile/domain/entities/profile.dart';
import 'package:party_app/global/error/failures.dart';
import 'package:party_app/global/utils/listfy.dart';

abstract class ProfileRepository extends Listfy {
  Future<Either<Failure, Profile>> getMyProfile();

  Future<Either<Failure, void>> update(EditProfile profile);
}
