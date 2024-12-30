/// code : 1
/// message : "OTP sent to your email"
/// data : {"message":"OTP sent to your email testuser12345@mailinator.com"}

class ForgotPasswordResponse {
  ForgotPasswordResponse({
    num? code,
    String? message,
    Data? data,
  }) {
    _code = code;
    _message = message;
    _data = data;
  }

  ForgotPasswordResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? _code;
  String? _message;
  Data? _data;

  ForgotPasswordResponse copyWith({
    num? code,
    String? message,
    Data? data,
  }) =>
      ForgotPasswordResponse(
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

/// message : "OTP sent to your email testuser12345@mailinator.com"

class Data {
  Data({
    String? message,
  }) {
    _message = message;
  }

  Data.fromJson(dynamic json) {
    _message = json['message'];
  }

  String? _message;

  Data copyWith({
    String? message,
  }) =>
      Data(
        message: message ?? _message,
      );

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    return map;
  }
}
