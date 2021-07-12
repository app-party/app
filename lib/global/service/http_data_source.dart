import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_app/global/api/api.dart';
import 'package:party_app/global/error/failures.dart';

class HttpDataSource {
  final Dio client;

  HttpDataSource(String route, this.client) {
    this.client.options = BaseOptions(
      baseUrl: "${API.path}$route",
    );
    this.client.interceptors.add(_AuthInterceptor());
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
        return Left(
            ServerFailure(_listfy<String>(err.response!.data["errors"])));
      }
      return Left(ServerFailure([FailuresMessages.SERVER_CONNECTION_FAILURE]));
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
        return Left(
            ServerFailure(_listfy<String>(err.response!.data["errors"])));
      }
      return Left(ServerFailure([FailuresMessages.SERVER_CONNECTION_FAILURE]));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> findAll(
      {String path = "", Map<String, dynamic>? query}) async {
    try {
      final response = await client.get(path, queryParameters: query);

      if (response.statusCode == 200 && response.statusCode! < 400) {
        return Right(_listfy<Map<String, dynamic>>(response.data));
      }
      return Left(
          ServerFailure(FailuresMessages.HTTP_FAILUES[response.statusCode!]));
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        return Left(
            ServerFailure(_listfy<String>(err.response!.data["errors"])));
      }
      return Left(ServerFailure([FailuresMessages.SERVER_CONNECTION_FAILURE]));
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
        return Left(
            ServerFailure(_listfy<String>(err.response!.data["errors"])));
      }
      return Left(ServerFailure([FailuresMessages.SERVER_CONNECTION_FAILURE]));
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
        return Left(
            ServerFailure(_listfy<String>(err.response!.data["errors"])));
      }
      return Left(ServerFailure([FailuresMessages.SERVER_CONNECTION_FAILURE]));
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
        return Left(
            ServerFailure(_listfy<String>(err.response!.data["errors"])));
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

class _AuthInterceptor extends Interceptor {
  /// Add Bearer token to Authorization Header
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handle) async {
    final GetStorage _storage = GetStorage();
    final token = _storage.read<String>("accessToken");

    if (token != null) {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }

    return handle.next(options);
  }
}
