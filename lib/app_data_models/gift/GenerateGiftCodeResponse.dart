/// code : 1
/// message : "Gift Code Generated Successfully"
/// data : {"code":"5mzb6tk4"}

class GenerateGiftCodeResponse {
  GenerateGiftCodeResponse({
      num? code, 
      String? message, 
      Data? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  GenerateGiftCodeResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _message;
  Data? _data;
GenerateGiftCodeResponse copyWith({  num? code,
  String? message,
  Data? data,
}) => GenerateGiftCodeResponse(  code: code ?? _code,
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

/// code : "5mzb6tk4"

class Data {
  Data({
      String? code,}){
    _code = code;
}

  Data.fromJson(dynamic json) {
    _code = json['code'];
  }
  String? _code;
Data copyWith({  String? code,
}) => Data(  code: code ?? _code,
);
  String? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    return map;
  }

}