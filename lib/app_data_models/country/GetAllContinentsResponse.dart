/// code : 1
/// message : "Continents found successfully"
/// data : {"continents":[{"_id":"6434535065383f626c15f492","name":"Europe","abbreviation":"EU","__v":0},{"_id":"6434535065383f626c15f48f","name":"Africa","abbreviation":"AF","__v":0},{"_id":"6434535065383f626c15f495","name":"South America","abbreviation":"SA","__v":0},{"_id":"6434535065383f626c15f490","name":"Antarctica","abbreviation":"AN","__v":0},{"_id":"6434535065383f626c15f493","name":"North America","abbreviation":"NA","__v":0},{"_id":"6434535065383f626c15f491","name":"Asia","abbreviation":"AS","__v":0},{"_id":"6434535065383f626c15f494","name":"Oceania","abbreviation":"OC","__v":0}]}

class GetAllContinentsResponse {
  GetAllContinentsResponse({
      num? code, 
      String? message, 
      Data? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  GetAllContinentsResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _message;
  Data? _data;
GetAllContinentsResponse copyWith({  num? code,
  String? message,
  Data? data,
}) => GetAllContinentsResponse(  code: code ?? _code,
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

/// continents : [{"_id":"6434535065383f626c15f492","name":"Europe","abbreviation":"EU","__v":0},{"_id":"6434535065383f626c15f48f","name":"Africa","abbreviation":"AF","__v":0},{"_id":"6434535065383f626c15f495","name":"South America","abbreviation":"SA","__v":0},{"_id":"6434535065383f626c15f490","name":"Antarctica","abbreviation":"AN","__v":0},{"_id":"6434535065383f626c15f493","name":"North America","abbreviation":"NA","__v":0},{"_id":"6434535065383f626c15f491","name":"Asia","abbreviation":"AS","__v":0},{"_id":"6434535065383f626c15f494","name":"Oceania","abbreviation":"OC","__v":0}]

class Data {
  Data({
      List<Continents>? continents,}){
    _continents = continents;
}

  Data.fromJson(dynamic json) {
    if (json['continents'] != null) {
      _continents = [];
      json['continents'].forEach((v) {
        _continents?.add(Continents.fromJson(v));
      });
    }
  }
  List<Continents>? _continents;
Data copyWith({  List<Continents>? continents,
}) => Data(  continents: continents ?? _continents,
);
  List<Continents>? get continents => _continents;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_continents != null) {
      map['continents'] = _continents?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6434535065383f626c15f492"
/// name : "Europe"
/// abbreviation : "EU"
/// __v : 0

class Continents {
  Continents({
      String? id, 
      String? name, 
      String? abbreviation, 
      num? v,}){
    _id = id;
    _name = name;
    _abbreviation = abbreviation;
    _v = v;
}

  Continents.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _abbreviation = json['abbreviation'];
    _v = json['__v'];
  }
  String? _id;
  String? _name;
  String? _abbreviation;
  num? _v;
Continents copyWith({  String? id,
  String? name,
  String? abbreviation,
  num? v,
}) => Continents(  id: id ?? _id,
  name: name ?? _name,
  abbreviation: abbreviation ?? _abbreviation,
  v: v ?? _v,
);
  String? get id => _id;
  String? get name => _name;
  String? get abbreviation => _abbreviation;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['abbreviation'] = _abbreviation;
    map['__v'] = _v;
    return map;
  }

}