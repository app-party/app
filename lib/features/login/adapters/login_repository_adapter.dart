import 'package:dio/dio.dart';
import 'package:party_app/features/login/adapters/dto/login_request.dart';
import 'package:party_app/features/login/datasourcers/login_data_source.dart';
import 'package:party_app/features/login/domain/entities/login_user.dart';
import 'package:dartz/dartz.dart';
import 'package:party_app/features/login/ports/repositories/login_repository.dart';
import 'package:party_app/global/error/failures.dart';

class LoginRepositoryAdapter extends LoginRepository {
  final LoginDataSource dataSource = LoginDataSource();

  @override
  Future<Either<Failure, String>> login(LoginUser user) async {
    try {
      final response = await dataSource.create(LoginRequest.toMap(user));

      if (response.isLeft()) {
        return Left(ServerFailure((response as Left).value.message));
      }

      return Right((response as Right).value["accessToken"]);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        return Left(ServerFailure(_listfy(err.response!.data["errors"])));
      }
      return Left(ServerFailure([FailuresMessages.SERVER_CONNECTION_FAILURE]));
    }
  }

  List<T> _listfy<T>(List l) {
    List<T> list = <T>[];
    l.forEach((e) => list.add(e));

    return list;
  }
}
