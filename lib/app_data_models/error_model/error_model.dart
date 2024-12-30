/// code : 0
/// server_status : "development"
/// data_status : "fake"
/// message : "video not found"
/// data : {"message":"video not found"}

class ErrorResponse {
  ErrorResponse({
    num? code,
    String? serverStatus,
    String? dataStatus,
    String? message,
    Data? data,
  }) {
    _code = code;
    _serverStatus = serverStatus;
    _dataStatus = dataStatus;
    _message = message;
    _data = data;
  }

  ErrorResponse.fromJson(dynamic json) {
    _code = json['code'];
    _serverStatus = json['server_status'];
    _dataStatus = json['data_status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? _code;
  String? _serverStatus;
  String? _dataStatus;
  String? _message;
  Data? _data;

  ErrorResponse copyWith({
    num? code,
    String? serverStatus,
    String? dataStatus,
    String? message,
    Data? data,
  }) =>
      ErrorResponse(
        code: code ?? _code,
        serverStatus: serverStatus ?? _serverStatus,
        dataStatus: dataStatus ?? _dataStatus,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get code => _code;

  String? get serverStatus => _serverStatus;

  String? get dataStatus => _dataStatus;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['server_status'] = _serverStatus;
    map['data_status'] = _dataStatus;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// message : "video not found"

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
