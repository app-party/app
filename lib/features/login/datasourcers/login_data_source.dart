import 'package:dio/dio.dart';
import 'package:party_app/global/service/http_data_source.dart';

class LoginDataSource extends HttpDataSource {
  LoginDataSource() : super("login", Dio());
}
