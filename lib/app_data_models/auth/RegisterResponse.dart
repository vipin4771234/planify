/// code : 1
/// message : "User Created Successfully"
/// data : {"user":{"email":"testuser1234@mailinator.com","user_channel_type":"tiktok","currency":"usd","_id":"647e12e9d1b133c3924c33f2","createdAt":"2023-06-05T16:52:57.481Z","updatedAt":"2023-06-05T16:52:57.481Z","__v":0},"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3R1c2VyMTIzNEBtYWlsaW5hdG9yLmNvbSIsImlhdCI6MTY4NTk4Mzk3NywiZXhwIjoxNjg2MDcwMzc3fQ.Sn63tp8MCDmF1mKsaXMWceTaTMD61JFGf1PvtI05Sgw"}

class RegisterResponse {
  RegisterResponse({
    num? code,
    String? message,
    Data? data,
  }) {
    _code = code;
    _message = message;
    _data = data;
  }

  RegisterResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _message;
  Data? _data;
  RegisterResponse copyWith({
    num? code,
    String? message,
    Data? data,
  }) =>
      RegisterResponse(
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

/// user : {"email":"testuser1234@mailinator.com","user_channel_type":"tiktok","currency":"usd","_id":"647e12e9d1b133c3924c33f2","createdAt":"2023-06-05T16:52:57.481Z","updatedAt":"2023-06-05T16:52:57.481Z","__v":0}
/// accessToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3R1c2VyMTIzNEBtYWlsaW5hdG9yLmNvbSIsImlhdCI6MTY4NTk4Mzk3NywiZXhwIjoxNjg2MDcwMzc3fQ.Sn63tp8MCDmF1mKsaXMWceTaTMD61JFGf1PvtI05Sgw"

class Data {
  Data({
    User? user,
    String? accessToken,
  }) {
    _user = user;
    _accessToken = accessToken;
  }

  Data.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _accessToken = json['accessToken'];
  }
  User? _user;
  String? _accessToken;

  get message => null;
  Data copyWith({
    User? user,
    String? accessToken,
  }) =>
      Data(
        user: user ?? _user,
        accessToken: accessToken ?? _accessToken,
      );
  User? get user => _user;
  String? get accessToken => _accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['accessToken'] = _accessToken;
    return map;
  }
}

/// email : "testuser1234@mailinator.com"
/// user_channel_type : "tiktok"
/// currency : "usd"
/// _id : "647e12e9d1b133c3924c33f2"
/// createdAt : "2023-06-05T16:52:57.481Z"
/// updatedAt : "2023-06-05T16:52:57.481Z"
/// __v : 0

class User {
  User({
    String? email,
    String? userChannelType,
    String? currency,
    String? id,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) {
    _email = email;
    _userChannelType = userChannelType;
    _currency = currency;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  User.fromJson(dynamic json) {
    _email = json['email'];
    _userChannelType = json['user_channel_type'];
    _currency = json['currency'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _email;
  String? _userChannelType;
  String? _currency;
  String? _id;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  User copyWith({
    String? email,
    String? userChannelType,
    String? currency,
    String? id,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      User(
        email: email ?? _email,
        userChannelType: userChannelType ?? _userChannelType,
        currency: currency ?? _currency,
        id: id ?? _id,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
      );
  String? get email => _email;
  String? get userChannelType => _userChannelType;
  String? get currency => _currency;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['user_channel_type'] = _userChannelType;
    map['currency'] = _currency;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}
