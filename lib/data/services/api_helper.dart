import 'package:dio/dio.dart';
import 'package:flutter_template/utils/shared_prefs.dart';
import 'package:flutter_template/data/services/interceptor.dart' as interceptor;
import 'package:flutter_template/utils/constants.dart' as constants;

class ApiHelper {
  static final BaseOptions _opts = BaseOptions(
    baseUrl: constants.siteUrl,
    //responseType: ResponseType.json,
    connectTimeout: constants.defaultRequestTimeout,
    receiveTimeout: constants.defaultRequestTimeout,
  );
  static String? token;
  static final _tokenDio = createDio();
  static final _dio = createDio();
  static final _basicDio = createDio();
  static final Dio _api = interceptor.addInterceptors(_dio, false);
  static final Dio _basic = interceptor.addInterceptors(_basicDio, true);
  static const int deleteSuccessCode = 204;  //success, no content

  static Dio createDio() {
    return Dio(_opts);
  }

  static Future<Response?> getRefreshToken() async {
    final String? refreshToken = await SharedPrefs.getRefreshToken();
    return _tokenDio.post(
      constants.authUrl,
      data: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
        'client_id': 'dieffetech',
        'client_secret': 'Abdks8j3r8nr',
      },
    );
  }

  static Future<Response?> getToken({
    required String username,
    required String password,
  }) async {
    return _tokenDio.post(
      constants.authUrl,
      data: {
        'grant_type': 'password',
        'username': username,
        'password': password,
        'client_id': 'dieffetech',
        'client_secret': 'Abdks8j3r8nr',
      },
    );
  }

  //CRUD: read
  Future<Response?> get(String url, {Map<String, dynamic>? query, bool basic = false}) {
    return basic
        ? _basic.get(url, queryParameters: query)
        : _api.get(url, queryParameters: query);
  }

  //CRUD: create
  Future<Response?> post(String url, dynamic data, {bool basic = false}) async {
    return basic
        ? await _basic.post(url, data: data)
        : await _api.post(url, data: data);
  }

  //CRUD: update/replace entire entity
  Future<Response?> put(String url, dynamic data, {bool basic = false}) async {
    return basic
        ? await _basic.put(url, data: data)
        : await _api.put(url, data: data);
  }

  //CRUD: update partially
  Future<Response?> patch(String url, dynamic data, {bool basic = false}) async {
    return basic
        ? await _basic.patch(url, data: data)
        : await _api.patch(url, data: data);
  }

  //CRUD: delete
  Future<Response?> delete(String url, {bool basic = false}) async {
    return basic ? _basic.delete(url) : _api.delete(url);
  }
}
