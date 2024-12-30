/// code : 1
/// message : "My Notifications found successfully"
/// data : {"myNotifications":[{"_id":"6459dfb2cbb1fb5bb61640b3","user":{"_id":"6456337bd8e4366cf78aa0ab","firstName":"Test","lastName":"User","email":"testuser123456@mailinator.com","password":"$2b$12$HFE2V7y4/5gvqv0C5ypLQeU62KZCom/iT4GqeAsrLPymocNBJf6oG","user_channel_type":"tiktok","currency":"usd","createdAt":"2023-05-06T11:01:15.317Z","updatedAt":"2023-05-06T11:01:15.317Z","__v":0},"topic":"testuser12345","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-05-09T05:52:10.634Z","__v":0},{"_id":"6459dfc2cbb1fb5bb61640b8","user":{"_id":"6456337bd8e4366cf78aa0ab","firstName":"Test","lastName":"User","email":"testuser123456@mailinator.com","password":"$2b$12$HFE2V7y4/5gvqv0C5ypLQeU62KZCom/iT4GqeAsrLPymocNBJf6oG","user_channel_type":"tiktok","currency":"usd","createdAt":"2023-05-06T11:01:15.317Z","updatedAt":"2023-05-06T11:01:15.317Z","__v":0},"topic":"planify","title":"Planify","message":"This is Test Notification","createdAt":"2023-05-09T05:52:10.634Z","__v":0}]}

class GetMyNotificationResponse {
  GetMyNotificationResponse({
      num? code, 
      String? message, 
      Data? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  GetMyNotificationResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _message;
  Data? _data;
GetMyNotificationResponse copyWith({  num? code,
  String? message,
  Data? data,
}) => GetMyNotificationResponse(  code: code ?? _code,
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

/// myNotifications : [{"_id":"6459dfb2cbb1fb5bb61640b3","user":{"_id":"6456337bd8e4366cf78aa0ab","firstName":"Test","lastName":"User","email":"testuser123456@mailinator.com","password":"$2b$12$HFE2V7y4/5gvqv0C5ypLQeU62KZCom/iT4GqeAsrLPymocNBJf6oG","user_channel_type":"tiktok","currency":"usd","createdAt":"2023-05-06T11:01:15.317Z","updatedAt":"2023-05-06T11:01:15.317Z","__v":0},"topic":"testuser12345","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-05-09T05:52:10.634Z","__v":0},{"_id":"6459dfc2cbb1fb5bb61640b8","user":{"_id":"6456337bd8e4366cf78aa0ab","firstName":"Test","lastName":"User","email":"testuser123456@mailinator.com","password":"$2b$12$HFE2V7y4/5gvqv0C5ypLQeU62KZCom/iT4GqeAsrLPymocNBJf6oG","user_channel_type":"tiktok","currency":"usd","createdAt":"2023-05-06T11:01:15.317Z","updatedAt":"2023-05-06T11:01:15.317Z","__v":0},"topic":"planify","title":"Planify","message":"This is Test Notification","createdAt":"2023-05-09T05:52:10.634Z","__v":0}]

class Data {
  Data({
      List<MyNotifications>? myNotifications,}){
    _myNotifications = myNotifications;
}

  Data.fromJson(dynamic json) {
    if (json['myNotifications'] != null) {
      _myNotifications = [];
      json['myNotifications'].forEach((v) {
        _myNotifications?.add(MyNotifications.fromJson(v));
      });
    }
  }
  List<MyNotifications>? _myNotifications;
Data copyWith({  List<MyNotifications>? myNotifications,
}) => Data(  myNotifications: myNotifications ?? _myNotifications,
);
  List<MyNotifications>? get myNotifications => _myNotifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_myNotifications != null) {
      map['myNotifications'] = _myNotifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6459dfb2cbb1fb5bb61640b3"
/// user : {"_id":"6456337bd8e4366cf78aa0ab","firstName":"Test","lastName":"User","email":"testuser123456@mailinator.com","password":"$2b$12$HFE2V7y4/5gvqv0C5ypLQeU62KZCom/iT4GqeAsrLPymocNBJf6oG","user_channel_type":"tiktok","currency":"usd","createdAt":"2023-05-06T11:01:15.317Z","updatedAt":"2023-05-06T11:01:15.317Z","__v":0}
/// topic : "testuser12345"
/// title : "Test Notification"
/// message : "This is Test Notification"
/// createdAt : "2023-05-09T05:52:10.634Z"
/// __v : 0

class MyNotifications {
  MyNotifications({
      String? id, 
      User? user, 
      String? topic, 
      String? title, 
      String? message, 
      String? createdAt, 
      num? v,}){
    _id = id;
    _user = user;
    _topic = topic;
    _title = title;
    _message = message;
    _createdAt = createdAt;
    _v = v;
}

  MyNotifications.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _topic = json['topic'];
    _title = json['title'];
    _message = json['message'];
    _createdAt = json['createdAt'];
    _v = json['__v'];
  }
  String? _id;
  User? _user;
  String? _topic;
  String? _title;
  String? _message;
  String? _createdAt;
  num? _v;
MyNotifications copyWith({  String? id,
  User? user,
  String? topic,
  String? title,
  String? message,
  String? createdAt,
  num? v,
}) => MyNotifications(  id: id ?? _id,
  user: user ?? _user,
  topic: topic ?? _topic,
  title: title ?? _title,
  message: message ?? _message,
  createdAt: createdAt ?? _createdAt,
  v: v ?? _v,
);
  String? get id => _id;
  User? get user => _user;
  String? get topic => _topic;
  String? get title => _title;
  String? get message => _message;
  String? get createdAt => _createdAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['topic'] = _topic;
    map['title'] = _title;
    map['message'] = _message;
    map['createdAt'] = _createdAt;
    map['__v'] = _v;
    return map;
  }

}

/// _id : "6456337bd8e4366cf78aa0ab"
/// firstName : "Test"
/// lastName : "User"
/// email : "testuser123456@mailinator.com"
/// password : "$2b$12$HFE2V7y4/5gvqv0C5ypLQeU62KZCom/iT4GqeAsrLPymocNBJf6oG"
/// user_channel_type : "tiktok"
/// currency : "usd"
/// createdAt : "2023-05-06T11:01:15.317Z"
/// updatedAt : "2023-05-06T11:01:15.317Z"
/// __v : 0

class User {
  User({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? email, 
      String? password, 
      String? userChannelType, 
      String? currency, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _password = password;
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
    _password = json['password'];
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
  String? _password;
  String? _userChannelType;
  String? _currency;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
User copyWith({  String? id,
  String? firstName,
  String? lastName,
  String? email,
  String? password,
  String? userChannelType,
  String? currency,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => User(  id: id ?? _id,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  password: password ?? _password,
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
  String? get password => _password;
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
    map['password'] = _password;
    map['user_channel_type'] = _userChannelType;
    map['currency'] = _currency;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}