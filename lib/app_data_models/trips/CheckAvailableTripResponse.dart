/// code : 1
/// message : "Trips are available"
/// data : {"availableTripsCount":41,"isUnlimitedPlan":true}

class CheckAvailableTripResponse {
  CheckAvailableTripResponse({
      num? code, 
      String? message, 
      Data? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  CheckAvailableTripResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _message;
  Data? _data;
CheckAvailableTripResponse copyWith({  num? code,
  String? message,
  Data? data,
}) => CheckAvailableTripResponse(  code: code ?? _code,
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

/// availableTripsCount : 41
/// isUnlimitedPlan : true

class Data {
  Data({
      num? availableTripsCount, 
      bool? isUnlimitedPlan,}){
    _availableTripsCount = availableTripsCount;
    _isUnlimitedPlan = isUnlimitedPlan;
}

  Data.fromJson(dynamic json) {
    _availableTripsCount = json['availableTripsCount'];
    _isUnlimitedPlan = json['isUnlimitedPlan'];
  }
  num? _availableTripsCount;
  bool? _isUnlimitedPlan;
Data copyWith({  num? availableTripsCount,
  bool? isUnlimitedPlan,
}) => Data(  availableTripsCount: availableTripsCount ?? _availableTripsCount,
  isUnlimitedPlan: isUnlimitedPlan ?? _isUnlimitedPlan,
);
  num? get availableTripsCount => _availableTripsCount;
  bool? get isUnlimitedPlan => _isUnlimitedPlan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['availableTripsCount'] = _availableTripsCount;
    map['isUnlimitedPlan'] = _isUnlimitedPlan;
    return map;
  }

}