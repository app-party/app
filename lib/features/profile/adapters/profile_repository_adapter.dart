import 'package:dio/dio.dart';
import 'package:party_app/features/profile/adapters/dto/get_profile_response.dart';
import 'package:party_app/features/profile/adapters/dto/update_profile_request.dart';
import 'package:party_app/features/profile/datasourcers/profile_data_source.dart';
import 'package:party_app/features/profile/domain/entities/edit_profile.dart';
import 'package:party_app/features/profile/domain/entities/profile.dart';
import 'package:dartz/dartz.dart';
import 'package:party_app/features/profile/ports/repositories/profile_repository.dart';
import 'package:party_app/global/error/failures.dart';

class ProfileRepositoryAdapter extends ProfileRepository {
  final ProfileDataSource dataSource = ProfileDataSource();

  @override
  Future<Either<Failure, Profile>> getMyProfile() async {
    try {
      final response = await dataSource.findById();

      if (response.isLeft()) {
        return Left(ServerFailure((response as Left).value.message));
      }

      return Right(GetProfileResponse.toProfile((response as Right).value));
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        return Left(
            ServerFailure(toList<String>(err.response!.data["errors"])));
      }
      return Left(ServerFailure([FailuresMessages.SERVER_CONNECTION_FAILURE]));
    }
  }

  @override
  Future<Either<Failure, void>> update(EditProfile profile) async {
    final response =
        await dataSource.update(UpdateProfileRequest.toMap(profile));

    if (response.isLeft()) {
      return Left(ServerFailure((response as Left).value.message));
    }

    return Right(null);
  }
}
