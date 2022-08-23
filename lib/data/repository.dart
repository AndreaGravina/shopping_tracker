import 'package:flutter_template/data/responses/token_response.dart';
import 'package:flutter_template/data/services/api_request.dart';

class Repository {
  final ApiRequest _apiRequest;

  const Repository(this._apiRequest);

  Future<TokenResponse> doLogin({
    required String username,
    required String password,
  }) async {
    try {
      return await _apiRequest.doLogin(username: username, password: password);
    } catch (error) {
      rethrow;
    }
  }

}