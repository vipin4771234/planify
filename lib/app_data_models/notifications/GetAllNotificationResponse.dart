/// code : 1
/// message : "Notifications found successfully"
/// data : {"notifications":[{"_id":"644335844f8b691e6646771e","user":"64330a63572969ff51173504","topic":"testuser12345","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-22T01:14:05.870Z","__v":0},{"_id":"64476a12728a965cb595b863","user":"64330a63572969ff51173504","topic":"testuser12345","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T05:48:57.856Z","__v":0},{"_id":"64476bf88df7ce2535cccaa1","user":"64330a63572969ff51173504","topic":"testuser12345","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T05:58:06.773Z","__v":0},{"_id":"64476c2e166a77aac3ce440f","user":"64330a63572969ff51173504","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T05:58:53.108Z","__v":0},{"_id":"64476e51bd827a52e3e7abeb","user":"64330a63572969ff51173504","topic":"planify","title":"Server Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:00:24.044Z","__v":0},{"_id":"64476ec2bd827a52e3e7abf1","user":"64330a63572969ff51173504","topic":"planify","title":"Server Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:00:24.044Z","__v":0},{"_id":"64476efebd827a52e3e7abf6","user":"64330a63572969ff51173504","topic":"planify","title":"Server Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:00:24.044Z","__v":0},{"_id":"644770297c13ae49c54ebed8","user":"64330a63572969ff51173504","topic":"planify","title":"Server Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:15:53.176Z","__v":0},{"_id":"644778eca96a201748e93c61","user":"64330a63572969ff51173504","topic":"testuser12345","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:52:13.577Z","__v":0},{"_id":"64477bb5b152f6e6545516a1","user":"6434e2aa7ae6609b47ae13a8","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:50:23.899Z","__v":0},{"_id":"64477bf3b152f6e6545516af","user":"6434e2aa7ae6609b47ae13a8","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:50:23.899Z","__v":0},{"_id":"64477c45b152f6e6545516bb","user":"6434e2aa7ae6609b47ae13a8","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:50:23.899Z","__v":0},{"_id":"644a2f68daf82446a6a7c0db","user":"64330a63572969ff51173504","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-27T07:44:33.655Z","__v":0},{"_id":"644a2fa2daf82446a6a7c0e0","user":"64330a63572969ff51173504","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-27T07:44:33.655Z","__v":0}]}

class GetAllNotificationResponse {
  GetAllNotificationResponse({
    num? code,
    String? message,
    Data? data,
  }) {
    _code = code;
    _message = message;
    _data = data;
  }

  GetAllNotificationResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? _code;
  String? _message;
  Data? _data;

  GetAllNotificationResponse copyWith({
    num? code,
    String? message,
    Data? data,
  }) =>
      GetAllNotificationResponse(
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

/// notifications : [{"_id":"644335844f8b691e6646771e","user":"64330a63572969ff51173504","topic":"testuser12345","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-22T01:14:05.870Z","__v":0},{"_id":"64476a12728a965cb595b863","user":"64330a63572969ff51173504","topic":"testuser12345","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T05:48:57.856Z","__v":0},{"_id":"64476bf88df7ce2535cccaa1","user":"64330a63572969ff51173504","topic":"testuser12345","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T05:58:06.773Z","__v":0},{"_id":"64476c2e166a77aac3ce440f","user":"64330a63572969ff51173504","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T05:58:53.108Z","__v":0},{"_id":"64476e51bd827a52e3e7abeb","user":"64330a63572969ff51173504","topic":"planify","title":"Server Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:00:24.044Z","__v":0},{"_id":"64476ec2bd827a52e3e7abf1","user":"64330a63572969ff51173504","topic":"planify","title":"Server Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:00:24.044Z","__v":0},{"_id":"64476efebd827a52e3e7abf6","user":"64330a63572969ff51173504","topic":"planify","title":"Server Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:00:24.044Z","__v":0},{"_id":"644770297c13ae49c54ebed8","user":"64330a63572969ff51173504","topic":"planify","title":"Server Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:15:53.176Z","__v":0},{"_id":"644778eca96a201748e93c61","user":"64330a63572969ff51173504","topic":"testuser12345","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:52:13.577Z","__v":0},{"_id":"64477bb5b152f6e6545516a1","user":"6434e2aa7ae6609b47ae13a8","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:50:23.899Z","__v":0},{"_id":"64477bf3b152f6e6545516af","user":"6434e2aa7ae6609b47ae13a8","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:50:23.899Z","__v":0},{"_id":"64477c45b152f6e6545516bb","user":"6434e2aa7ae6609b47ae13a8","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-25T06:50:23.899Z","__v":0},{"_id":"644a2f68daf82446a6a7c0db","user":"64330a63572969ff51173504","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-27T07:44:33.655Z","__v":0},{"_id":"644a2fa2daf82446a6a7c0e0","user":"64330a63572969ff51173504","topic":"planify","title":"Test Notification","message":"This is Test Notification","createdAt":"2023-04-27T07:44:33.655Z","__v":0}]

class Data {
  Data({
    List<Notifications>? notifications,
  }) {
    _notifications = notifications;
  }

  Data.fromJson(dynamic json) {
    if (json['notifications'] != null) {
      _notifications = [];
      json['notifications'].forEach((v) {
        _notifications?.add(Notifications.fromJson(v));
      });
    }
  }

  List<Notifications>? _notifications;

  Data copyWith({
    List<Notifications>? notifications,
  }) =>
      Data(
        notifications: notifications ?? _notifications,
      );

  List<Notifications>? get notifications => _notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_notifications != null) {
      map['notifications'] = _notifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "644335844f8b691e6646771e"
/// user : "64330a63572969ff51173504"
/// topic : "testuser12345"
/// title : "Test Notification"
/// message : "This is Test Notification"
/// createdAt : "2023-04-22T01:14:05.870Z"
/// __v : 0

class Notifications {
  Notifications({
    String? id,
    String? user,
    String? topic,
    String? title,
    String? message,
    String? createdAt,
    num? v,
  }) {
    _id = id;
    _user = user;
    _topic = topic;
    _title = title;
    _message = message;
    _createdAt = createdAt;
    _v = v;
  }

  Notifications.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    _topic = json['topic'];
    _title = json['title'];
    _message = json['message'];
    _createdAt = json['createdAt'];
    _v = json['__v'];
  }

  String? _id;
  String? _user;
  String? _topic;
  String? _title;
  String? _message;
  String? _createdAt;
  num? _v;

  Notifications copyWith({
    String? id,
    String? user,
    String? topic,
    String? title,
    String? message,
    String? createdAt,
    num? v,
  }) =>
      Notifications(
        id: id ?? _id,
        user: user ?? _user,
        topic: topic ?? _topic,
        title: title ?? _title,
        message: message ?? _message,
        createdAt: createdAt ?? _createdAt,
        v: v ?? _v,
      );

  String? get id => _id;

  String? get user => _user;

  String? get topic => _topic;

  String? get title => _title;

  String? get message => _message;

  String? get createdAt => _createdAt;

  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user'] = _user;
    map['topic'] = _topic;
    map['title'] = _title;
    map['message'] = _message;
    map['createdAt'] = _createdAt;
    map['__v'] = _v;
    return map;
  }
}
