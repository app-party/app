import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:party_app/global/api/api.dart';
import 'package:party_app/global/error/failures.dart';
import 'package:party_app/global/utils/listfy.dart';

class HttpDataSource extends Listfy {
  final Dio client;

  HttpDataSource(String route, this.client) {
    this.client.options = BaseOptions(
      baseUrl: "${API.path}$route",
    );
    this.client.interceptors.add(_AuthInterceptor());
    this.client.interceptors.add(RequestInterceptor());
  }

  Future<Either<Failure, Map<String, dynamic>?>> findById(
      {String? path}) async {
    try {
      final response = await client.get(path ?? "");

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(ServerFailure(response.data["message"]));
      }
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        return Left(
            ServerFailure(toList<String>(err.response!.data["errors"])));
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
            ServerFailure(toList<String>(err.response!.data["errors"])));
      }
      return Left(ServerFailure([FailuresMessages.SERVER_CONNECTION_FAILURE]));
    }
  }

  Future<Either<Failure, List<Map<String, dynamic>>>> findAll(
      {String path = "", Map<String, dynamic>? query}) async {
    try {
      final response = await client.get(path, queryParameters: query);

      if (response.statusCode == 200 && response.statusCode! < 400) {
        return Right(toList<Map<String, dynamic>>(response.data));
      }
      return Left(
          ServerFailure(FailuresMessages.HTTP_FAILUES[response.statusCode!]));
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        return Left(
            ServerFailure(toList<String>(err.response!.data["errors"])));
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
            ServerFailure(toList<String>(err.response!.data["errors"])));
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
            ServerFailure(toList<String>(err.response!.data["errors"])));
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
            ServerFailure(toList<String>(err.response!.data["errors"])));
      }
      return Left(ServerFailure([FailuresMessages.SERVER_CONNECTION_FAILURE]));
    }
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

class RequestInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handle) async {
    print("===REQUEST===");
    print(options.data);
    print(options.path);
    print(options.headers);

    return handle.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("===RESPONSE===");
    print(response.data);
    print(response.realUri);
    print(response.headers);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("===ERROR===");
    print(err.response!.statusCode);
    print("${err.requestOptions.baseUrl} -- ${err.requestOptions.uri}");
    print(err.response!.data["errors"]);
    super.onError(err, handler);
  }
}
