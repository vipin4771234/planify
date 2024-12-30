/// code : 0
/// message : "Trips are not available"
/// data : {"message":"Trips are not available","isUnlimitedPlan":false}

class CheckAvailableTripErrorResponse {
  CheckAvailableTripErrorResponse({
      num? code, 
      String? message, 
      Data? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  CheckAvailableTripErrorResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _message;
  Data? _data;
CheckAvailableTripErrorResponse copyWith({  num? code,
  String? message,
  Data? data,
}) => CheckAvailableTripErrorResponse(  code: code ?? _code,
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

/// message : "Trips are not available"
/// isUnlimitedPlan : false

class Data {
  Data({
      String? message, 
      bool? isUnlimitedPlan,}){
    _message = message;
    _isUnlimitedPlan = isUnlimitedPlan;
}

  Data.fromJson(dynamic json) {
    _message = json['message'];
    _isUnlimitedPlan = json['isUnlimitedPlan'];
  }
  String? _message;
  bool? _isUnlimitedPlan;
Data copyWith({  String? message,
  bool? isUnlimitedPlan,
}) => Data(  message: message ?? _message,
  isUnlimitedPlan: isUnlimitedPlan ?? _isUnlimitedPlan,
);
  String? get message => _message;
  bool? get isUnlimitedPlan => _isUnlimitedPlan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['isUnlimitedPlan'] = _isUnlimitedPlan;
    return map;
  }

}