/// code : 1
/// message : "success message"
/// data : {"usersCount":30418,"tripsCount":31910}

class GetTripStatsResponse {
  GetTripStatsResponse({
      num? code, 
      String? message, 
      Data? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  GetTripStatsResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _message;
  Data? _data;
GetTripStatsResponse copyWith({  num? code,
  String? message,
  Data? data,
}) => GetTripStatsResponse(  code: code ?? _code,
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

/// usersCount : 30418
/// tripsCount : 31910

class Data {
  Data({
      num? usersCount, 
      num? tripsCount,}){
    _usersCount = usersCount;
    _tripsCount = tripsCount;
}

  Data.fromJson(dynamic json) {
    _usersCount = json['usersCount'];
    _tripsCount = json['tripsCount'];
  }
  num? _usersCount;
  num? _tripsCount;
Data copyWith({  num? usersCount,
  num? tripsCount,
}) => Data(  usersCount: usersCount ?? _usersCount,
  tripsCount: tripsCount ?? _tripsCount,
);
  num? get usersCount => _usersCount;
  num? get tripsCount => _tripsCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['usersCount'] = _usersCount;
    map['tripsCount'] = _tripsCount;
    return map;
  }

}