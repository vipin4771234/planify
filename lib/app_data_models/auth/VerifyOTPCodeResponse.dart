/// code : 1
/// message : "Successfully Verified"
/// data : {"verificationToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndvZGF0b2tpQGdtYWlsLmNvbSIsImlhdCI6MTY4MjQ5MDI5NSwiZXhwIjoxNjgyNDkwNTk1fQ.9v2Y9ftvvfD49uZOyuYMM39fMqV7167Sv7u2O321U5A"}

class VerifyOtpCodeResponse {
  VerifyOtpCodeResponse({
    num? code,
    String? message,
    Data? data,
  }) {
    _code = code;
    _message = message;
    _data = data;
  }

  VerifyOtpCodeResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? _code;
  String? _message;
  Data? _data;

  VerifyOtpCodeResponse copyWith({
    num? code,
    String? message,
    Data? data,
  }) =>
      VerifyOtpCodeResponse(
        code: code ?? _code,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get code => _code;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// verificationToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6IndvZGF0b2tpQGdtYWlsLmNvbSIsImlhdCI6MTY4MjQ5MDI5NSwiZXhwIjoxNjgyNDkwNTk1fQ.9v2Y9ftvvfD49uZOyuYMM39fMqV7167Sv7u2O321U5A"

class Data {
  Data({
    String? verificationToken,
  }) {
    _verificationToken = verificationToken;
  }

  Data.fromJson(dynamic json) {
    _verificationToken = json['verificationToken'];
  }

  String? _verificationToken;

  Data copyWith({
    String? verificationToken,
  }) =>
      Data(
        verificationToken: verificationToken ?? _verificationToken,
      );

  String? get verificationToken => _verificationToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['verificationToken'] = _verificationToken;
    return map;
  }
}
