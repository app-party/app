import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:oauth_dio/oauth_dio.dart';
import 'package:party_app/global/api/api.dart';
import 'package:party_app/global/error/failures.dart';

import 'auth_service.dart';

class HttpDataSource {
  final Dio client;

  HttpDataSource(String route, this.client) {
    this.client.options = BaseOptions(
      baseUrl: "${API.path}$route",
    );
    this.client.interceptors.add(BearerInterceptor(AuthService().oauth));
  }

  Future<Either<Failure, Map<String, dynamic>?>> findById(
    String? path,
  ) async {
    try {
      final response = await client.get("/$path");

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(ServerFailure(response.data["message"]));
      }
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        return Left(ServerFailure(err.message));
      }
      return Left(ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE));
    }
  }

  Future<Either<Failure, bool?>> exists({String? path}) async {
    try {
      final response = await client.get("/$path");
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(ServerFailure(response.data["message"]));
      }
    } catch (e) {
      if (e is DioError) {
        DioError err = e;

        if (err.response!.statusCode == 400 &&
            err.response!.data["message"] == "Has no quiz found for you") {
          return Right(false);
        }
      }
      return Left(ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> findAll(
      {String path = "", Map<String, dynamic>? query}) async {
    try {
      final response = await client.get(path, queryParameters: query);

      if (response.statusCode == 200 && response.statusCode! < 400) {
        return Right(_listfy(response.data));
      }
      return Left(
          ServerFailure(FailuresMessages.HTTP_FAILUES[response.statusCode!]));
    } catch (e) {
      if (e is DioError) {
        DioError err = e;

        return Left(ServerFailure(err.response!.data["message"]));
      }
      return Left(ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE));
    }
  }

  Future<Either<Failure, dynamic>> create(Map<String, dynamic>? data,
      {String path = ''}) async {
    try {
      final response = await client.post(path, data: data);

      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        return Right(response.data);
      } else {
        return Left(ServerFailure(response.data["message"]));
      }
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        return Left(ServerFailure(err.response!.data["message"]));
      }
      return Left(ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE));
    }
  }

  Future<Either<Failure, dynamic>> update(Map<String, dynamic> data,
      {String path = ''}) async {
    try {
      final response = await client.patch(path, data: data);

      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        return Right(response.data);
      } else {
        return Left(
            ServerFailure(FailuresMessages.HTTP_FAILUES[response.statusCode!]));
      }
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        return Left(ServerFailure(err.message));
      }
      return Left(ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE));
    }
  }

  Future<Either<Failure, String?>> delete(String? path) async {
    try {
      final response = await client.delete("/$path");

      if (response.statusCode! >= 200 && response.statusCode! < 400) {
        return Right(response.data);
      } else {
        return Left(
            ServerFailure(FailuresMessages.HTTP_FAILUES[response.statusCode!]));
      }
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        return Left(ServerFailure(err.message));
      }
      return Left(ServerFailure(FailuresMessages.SERVER_CONNECTION_FAILURE));
    }
  }

  List<Map<String, dynamic>> _listfy(List l) {
    List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    l.forEach((e) => list.add(e));

    return list;
  }
}
