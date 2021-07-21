import 'package:dio/dio.dart';
import 'package:party_app/global/service/http_data_source.dart';

class ProfileDataSource extends HttpDataSource {
  ProfileDataSource() : super("profiles", Dio());
}
