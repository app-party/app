import 'package:dartz/dartz.dart';
import 'package:party_app/features/signup/adapters/dto/create_user_request.dart';
import 'package:party_app/features/signup/datasourcers/signup_data_source.dart';
import 'package:party_app/features/signup/domain/entities/signup_user.dart';
import 'package:party_app/features/signup/ports/repositories/signup_repository.dart';
import 'package:party_app/global/error/exceptions.dart';
import 'package:party_app/global/error/failures.dart';

class SignupRepositoryAdapter extends SignupRepository {
  final dataSource = SignupDataSource();

  @override
  Future<Either<Failure, String>> createUser({required SignupUser user}) async {
    try {
      final response = await dataSource.create(CreateUserRequest.toMap(user));

      if (response.isLeft()) {
        return Left((response as Left).value);
      }

      return Right((response as Right).value["id"]);
    } on ServerException {
      return Left(ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE));
    }
  }
}
