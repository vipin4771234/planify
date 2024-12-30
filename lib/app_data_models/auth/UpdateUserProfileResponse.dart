/// code : 1
/// message : "Currency Updated Successfully"
/// data : {"user":{"_id":"646069d9f4bb8d3693452e42","firstName":"Thor","lastName":"Thunder","email":"testuser123456@mailinator.com","user_channel_type":"tiktok","currency":"euro","createdAt":"2023-05-14T04:55:53.084Z","updatedAt":"2023-05-14T04:55:53.084Z","__v":0}}

class UpdateUserProfileResponse {
  UpdateUserProfileResponse({
      num? code, 
      String? message, 
      Data? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  UpdateUserProfileResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _message;
  Data? _data;
UpdateUserProfileResponse copyWith({  num? code,
  String? message,
  Data? data,
}) => UpdateUserProfileResponse(  code: code ?? _code,
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

/// user : {"_id":"646069d9f4bb8d3693452e42","firstName":"Thor","lastName":"Thunder","email":"testuser123456@mailinator.com","user_channel_type":"tiktok","currency":"euro","createdAt":"2023-05-14T04:55:53.084Z","updatedAt":"2023-05-14T04:55:53.084Z","__v":0}

class Data {
  Data({
      User? user,}){
    _user = user;
}

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? _user;
Data copyWith({  User? user,
}) => Data(  user: user ?? _user,
);
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// _id : "646069d9f4bb8d3693452e42"
/// firstName : "Thor"
/// lastName : "Thunder"
/// email : "testuser123456@mailinator.com"
/// user_channel_type : "tiktok"
/// currency : "euro"
/// createdAt : "2023-05-14T04:55:53.084Z"
/// updatedAt : "2023-05-14T04:55:53.084Z"
/// __v : 0

class User {
  User({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? userChannelType, 
      String? currency, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _userChannelType = userChannelType;
    _currency = currency;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _email = json['email'];
    _userChannelType = json['user_channel_type'];
    _currency = json['currency'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _userChannelType;
  String? _currency;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
User copyWith({  String? id,
  String? firstName,
  String? lastName,
  String? email,
  String? userChannelType,
  String? currency,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => User(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  userChannelType: userChannelType ?? _userChannelType,
  currency: currency ?? _currency,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get userChannelType => _userChannelType;
  String? get currency => _currency;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['user_channel_type'] = _userChannelType;
    map['currency'] = _currency;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}