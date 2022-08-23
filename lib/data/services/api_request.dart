import 'package:dio/dio.dart';
import 'package:flutter_template/data/responses/token_response.dart';
import 'package:flutter_template/utils/constants.dart' as constants;

import 'api_helper.dart';

class ApiRequest {
  final _api = ApiHelper();

  Future<TokenResponse> doLogin({
    required String username,
    required String password,
  }) async {
    try {
      final response = await ApiHelper.getToken(
        username: username,
        password: password,
      );
      return TokenResponse.fromJson(response?.data);
    } catch (error) {
      rethrow;
    }
  }

  //example request
  /*Future<Response> getData() async {
    try {
      final response = await _api.post(
        '${constants.apiUrl}example',
        params,
        basic: true,
      );
      return Response.fromJson(response?.data);
    } catch (error) {
      rethrow;
    }
  }*/
}
