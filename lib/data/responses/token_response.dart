class TokenResponse {
  String? _accessToken;
  int? _expiresIn;
  String? _tokenType;
  String? _scope;
  String? _refreshToken;

  String? get accessToken => _accessToken;

  int? get expiresIn => _expiresIn;

  String? get tokenType => _tokenType;

  String? get scope => _scope;

  String? get refreshToken => _refreshToken;

  TokenResponse({
    String? accessToken,
    int? expiresIn,
    String? tokenType,
    String? scope,
    String? refreshToken,
  }) {
    _accessToken = accessToken;
    _expiresIn = expiresIn;
    _tokenType = tokenType;
    _scope = scope;
    _refreshToken = refreshToken;
  }

  TokenResponse.fromJson(Map<String, dynamic> json) {
    _accessToken = json['access_token'];
    _expiresIn = json['expires_in'];
    _tokenType = json['token_type'];
    _scope = json['scope'];
    _refreshToken = json['refresh_token'];
  }
}
