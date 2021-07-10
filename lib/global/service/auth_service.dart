import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:oauth_dio/oauth_dio.dart';
import 'package:party_app/global/api/api.dart';

class AuthService {
  final accessTokenKey = 'accessToken';
  final refreshTokenKey = 'refreshToken';

  late OAuth oauth;

  AuthService() {
    Dio client = Dio();
    // client.interceptors.add(EHInterceptor());

    oauth = OAuth(
        tokenUrl: "${API.path}oauth/token",
        clientId: "eduqhub_mobile_professor",
        clientSecret:
            "\$2a\$10\$4CvdsdqhNu/A1ERtlyqOYeSb@UjL7xCbPclZ7k3o6HvWw0oU3v1u",
        storage: AuthStorage(),
        dio: client,
        validator: (token) {
          var payload = Jwt.parseJwt(token.accessToken!);

          return Future.value(
              DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                  .isAfter(DateTime.now()));
        });
  }

  Future<OAuthToken> login(user, pass) async {
    return await oauth.requestTokenAndSave(PasswordGrant(
      username: user,
      password: pass,
    ));
  }
}

class AuthStorage extends OAuthStorage {
  final accessTokenKey = 'accessToken';
  final refreshTokenKey = 'refreshToken';

  final GetStorage _storage = GetStorage("token");
  // final ProfileBloc _profileBloc = BlocProvider.getBloc<ProfileBloc>();

  @override
  Future<void> clear() async {
    await _storage.erase();
  }

  @override
  Future<OAuthToken?> fetch() async {
    var accessToken = await _storage.read(accessTokenKey);
    var refreshToken = await _storage.read(refreshTokenKey);

    if (accessToken == null ||
        accessToken == "" ||
        refreshToken == null ||
        refreshToken == "") {
      await clear();
      return null;
    }

    // _profileBloc.profile =
    //     ProfileDTO.fromJson(Jwt.parseJwt(allData[accessTokenKey])["user"]);

    return OAuthToken.fromMap({
      "access_token": accessToken,
      "refresh_token": refreshToken,
      "expires_in":
          Jwt.getExpiryDate(accessToken)!.millisecondsSinceEpoch ~/ 1000,
    });
  }

  @override
  Future<OAuthToken> save(OAuthToken token) async {
    // _profileBloc.profile =
    //     ProfileDTO.fromJson(Jwt.parseJwt(token.accessToken)["user"]);

    await _storage.write(accessTokenKey, token.accessToken);
    await _storage.write(refreshTokenKey, token.refreshToken);
    return token;
  }
}

class GoogleGrantType extends OAuthGrantType {
  String? token;

  GoogleGrantType({this.token});

  @override
  RequestOptions handle(RequestOptions request) {
    // token.split("_").forEach((e) => print("_$e"));
    request.data = "grant_type=google&id_token=$token";
    return request;
  }
}

class AppleGrantType extends OAuthGrantType {
  String? token;

  AppleGrantType({this.token});

  @override
  RequestOptions handle(RequestOptions request) {
    // token.split("_").forEach((e) => print("_$e"));
    request.data = "grant_type=apple&id_token=$token";
    return request;
  }
}
