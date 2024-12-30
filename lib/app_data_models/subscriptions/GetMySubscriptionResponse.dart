/// code : 1
/// message : "My Subscription found successfully"
/// data : [{"_id":"64763ade7a8bd95df3b44879","user":{"_id":"64763ac17a8bd95df3b44871","email":"thor@gmail.com","password":"$2b$12$55bAXiWRsXyZPJGpSQVVlO4dbmV0PWGipOdeg8EtWheNMSjf4rKce","user_channel_type":"tiktok","currency":"usd","createdAt":"2023-05-30T18:04:49.916Z","updatedAt":"2023-05-30T18:04:49.916Z","__v":0,"firstName":"Thor","lastName":"Asgard"},"subscriptionPlan":{"_id":"646ee780e076be9266892a1f","price":29.95,"currency":"$","discount":70,"discountType":"percentage","numberOfTripsAllowed":50,"numberOfItterationsPerTrip":10,"description":"FREE Trips for 1 Year ","isDisabled":false,"vendorProductId":"in_app_planify_8999_1y"},"purchaseId":"b271726c-543b-4e5d-9902-fd9ea3d93285","store":"app_store","vendorProductId":"in_app_planify_8999_1y","vendorTransactionId":"2000000339539183","purchasedAt":"2023-05-29T06:04:54.000Z","isSandbox":true,"isRefund":false,"isConsumable":true,"isActive":false,"activatedAt":"2023-04-21T06:56:46.000Z","renewedAt":"2023-05-16T17:45:22.000Z","expiresAt":"2023-05-16T18:45:22.000Z","willRenew":false,"unsubscribedAt":"2023-05-16T18:45:22.000Z","__v":0},{"_id":"64763d6622ed2cc401033ab2","user":{"_id":"64763ac17a8bd95df3b44871","email":"thor@gmail.com","password":"$2b$12$55bAXiWRsXyZPJGpSQVVlO4dbmV0PWGipOdeg8EtWheNMSjf4rKce","user_channel_type":"tiktok","currency":"usd","createdAt":"2023-05-30T18:04:49.916Z","updatedAt":"2023-05-30T18:04:49.916Z","__v":0,"firstName":"Thor","lastName":"Asgard"},"subscriptionPlan":{"_id":"646ee780e076be9266892a1f","price":29.95,"currency":"$","discount":70,"discountType":"percentage","numberOfTripsAllowed":50,"numberOfItterationsPerTrip":10,"description":"FREE Trips for 1 Year ","isDisabled":false,"vendorProductId":"in_app_planify_8999_1y"},"purchaseId":"b271726c-543b-4e5d-9902-fd9ea3d93285","store":"app_store","vendorProductId":"in_app_planify_8999_1y","vendorTransactionId":"2000000339539183","purchasedAt":"2023-05-29T06:04:54.000Z","isSandbox":true,"isRefund":false,"isConsumable":true,"isActive":false,"activatedAt":"2023-04-21T06:56:46.000Z","renewedAt":"2023-05-16T17:45:22.000Z","expiresAt":"2023-05-16T18:45:22.000Z","willRenew":false,"unsubscribedAt":"2023-05-16T18:45:22.000Z","__v":0},{"_id":"647640981b5c7c04e0edc01d","user":{"_id":"64763ac17a8bd95df3b44871","email":"thor@gmail.com","password":"$2b$12$55bAXiWRsXyZPJGpSQVVlO4dbmV0PWGipOdeg8EtWheNMSjf4rKce","user_channel_type":"tiktok","currency":"usd","createdAt":"2023-05-30T18:04:49.916Z","updatedAt":"2023-05-30T18:04:49.916Z","__v":0,"firstName":"Thor","lastName":"Asgard"},"subscriptionPlan":{"_id":"646ee780e076be9266892a1f","price":29.95,"currency":"$","discount":70,"discountType":"percentage","numberOfTripsAllowed":50,"numberOfItterationsPerTrip":10,"description":"FREE Trips for 1 Year ","isDisabled":false,"vendorProductId":"in_app_planify_8999_1y"},"purchaseId":"386b2147-e6d7-4e49-b939-f109e7345ef2","store":"play_store","vendorProductId":"in_app_planify_8999_1y","vendorTransactionId":"GPA.3369-7082-0629-42093","purchasedAt":"2023-05-30T18:20:19.000Z","isSandbox":true,"isRefund":false,"isConsumable":false,"isActive":false,"activatedAt":null,"renewedAt":null,"expiresAt":null,"willRenew":false,"unsubscribedAt":null,"__v":0}]

class GetMySubscriptionResponse {
  GetMySubscriptionResponse({
      num? code, 
      String? message, 
      List<Data>? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  GetMySubscriptionResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _code;
  String? _message;
  List<Data>? _data;
GetMySubscriptionResponse copyWith({  num? code,
  String? message,
  List<Data>? data,
}) => GetMySubscriptionResponse(  code: code ?? _code,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get code => _code;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "64763ade7a8bd95df3b44879"
/// user : {"_id":"64763ac17a8bd95df3b44871","email":"thor@gmail.com","password":"$2b$12$55bAXiWRsXyZPJGpSQVVlO4dbmV0PWGipOdeg8EtWheNMSjf4rKce","user_channel_type":"tiktok","currency":"usd","createdAt":"2023-05-30T18:04:49.916Z","updatedAt":"2023-05-30T18:04:49.916Z","__v":0,"firstName":"Thor","lastName":"Asgard"}
/// subscriptionPlan : {"_id":"646ee780e076be9266892a1f","price":29.95,"currency":"$","discount":70,"discountType":"percentage","numberOfTripsAllowed":50,"numberOfItterationsPerTrip":10,"description":"FREE Trips for 1 Year ","isDisabled":false,"vendorProductId":"in_app_planify_8999_1y"}
/// purchaseId : "b271726c-543b-4e5d-9902-fd9ea3d93285"
/// store : "app_store"
/// vendorProductId : "in_app_planify_8999_1y"
/// vendorTransactionId : "2000000339539183"
/// purchasedAt : "2023-05-29T06:04:54.000Z"
/// isSandbox : true
/// isRefund : false
/// isConsumable : true
/// isActive : false
/// activatedAt : "2023-04-21T06:56:46.000Z"
/// renewedAt : "2023-05-16T17:45:22.000Z"
/// expiresAt : "2023-05-16T18:45:22.000Z"
/// willRenew : false
/// unsubscribedAt : "2023-05-16T18:45:22.000Z"
/// __v : 0

class Data {
  Data({
      String? id, 
      User? user, 
      SubscriptionPlan? subscriptionPlan, 
      String? purchaseId, 
      String? store, 
      String? vendorProductId, 
      String? vendorTransactionId, 
      String? purchasedAt, 
      bool? isSandbox, 
      bool? isRefund, 
      bool? isConsumable, 
      bool? isActive, 
      String? activatedAt, 
      String? renewedAt, 
      String? expiresAt, 
      bool? willRenew, 
      String? unsubscribedAt, 
      num? v,}){
    _id = id;
    _user = user;
    _subscriptionPlan = subscriptionPlan;
    _purchaseId = purchaseId;
    _store = store;
    _vendorProductId = vendorProductId;
    _vendorTransactionId = vendorTransactionId;
    _purchasedAt = purchasedAt;
    _isSandbox = isSandbox;
    _isRefund = isRefund;
    _isConsumable = isConsumable;
    _isActive = isActive;
    _activatedAt = activatedAt;
    _renewedAt = renewedAt;
    _expiresAt = expiresAt;
    _willRenew = willRenew;
    _unsubscribedAt = unsubscribedAt;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _subscriptionPlan = json['subscriptionPlan'] != null ? SubscriptionPlan.fromJson(json['subscriptionPlan']) : null;
    _purchaseId = json['purchaseId'];
    _store = json['store'];
    _vendorProductId = json['vendorProductId'];
    _vendorTransactionId = json['vendorTransactionId'];
    _purchasedAt = json['purchasedAt'];
    _isSandbox = json['isSandbox'];
    _isRefund = json['isRefund'];
    _isConsumable = json['isConsumable'];
    _isActive = json['isActive'];
    _activatedAt = json['activatedAt'];
    _renewedAt = json['renewedAt'];
    _expiresAt = json['expiresAt'];
    _willRenew = json['willRenew'];
    _unsubscribedAt = json['unsubscribedAt'];
    _v = json['__v'];
  }
  String? _id;
  User? _user;
  SubscriptionPlan? _subscriptionPlan;
  String? _purchaseId;
  String? _store;
  String? _vendorProductId;
  String? _vendorTransactionId;
  String? _purchasedAt;
  bool? _isSandbox;
  bool? _isRefund;
  bool? _isConsumable;
  bool? _isActive;
  String? _activatedAt;
  String? _renewedAt;
  String? _expiresAt;
  bool? _willRenew;
  String? _unsubscribedAt;
  num? _v;
Data copyWith({  String? id,
  User? user,
  SubscriptionPlan? subscriptionPlan,
  String? purchaseId,
  String? store,
  String? vendorProductId,
  String? vendorTransactionId,
  String? purchasedAt,
  bool? isSandbox,
  bool? isRefund,
  bool? isConsumable,
  bool? isActive,
  String? activatedAt,
  String? renewedAt,
  String? expiresAt,
  bool? willRenew,
  String? unsubscribedAt,
  num? v,
}) => Data(  id: id ?? _id,
  user: user ?? _user,
  subscriptionPlan: subscriptionPlan ?? _subscriptionPlan,
  purchaseId: purchaseId ?? _purchaseId,
  store: store ?? _store,
  vendorProductId: vendorProductId ?? _vendorProductId,
  vendorTransactionId: vendorTransactionId ?? _vendorTransactionId,
  purchasedAt: purchasedAt ?? _purchasedAt,
  isSandbox: isSandbox ?? _isSandbox,
  isRefund: isRefund ?? _isRefund,
  isConsumable: isConsumable ?? _isConsumable,
  isActive: isActive ?? _isActive,
  activatedAt: activatedAt ?? _activatedAt,
  renewedAt: renewedAt ?? _renewedAt,
  expiresAt: expiresAt ?? _expiresAt,
  willRenew: willRenew ?? _willRenew,
  unsubscribedAt: unsubscribedAt ?? _unsubscribedAt,
  v: v ?? _v,
);
  String? get id => _id;
  User? get user => _user;
  SubscriptionPlan? get subscriptionPlan => _subscriptionPlan;
  String? get purchaseId => _purchaseId;
  String? get store => _store;
  String? get vendorProductId => _vendorProductId;
  String? get vendorTransactionId => _vendorTransactionId;
  String? get purchasedAt => _purchasedAt;
  bool? get isSandbox => _isSandbox;
  bool? get isRefund => _isRefund;
  bool? get isConsumable => _isConsumable;
  bool? get isActive => _isActive;
  String? get activatedAt => _activatedAt;
  String? get renewedAt => _renewedAt;
  String? get expiresAt => _expiresAt;
  bool? get willRenew => _willRenew;
  String? get unsubscribedAt => _unsubscribedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_subscriptionPlan != null) {
      map['subscriptionPlan'] = _subscriptionPlan?.toJson();
    }
    map['purchaseId'] = _purchaseId;
    map['store'] = _store;
    map['vendorProductId'] = _vendorProductId;
    map['vendorTransactionId'] = _vendorTransactionId;
    map['purchasedAt'] = _purchasedAt;
    map['isSandbox'] = _isSandbox;
    map['isRefund'] = _isRefund;
    map['isConsumable'] = _isConsumable;
    map['isActive'] = _isActive;
    map['activatedAt'] = _activatedAt;
    map['renewedAt'] = _renewedAt;
    map['expiresAt'] = _expiresAt;
    map['willRenew'] = _willRenew;
    map['unsubscribedAt'] = _unsubscribedAt;
    map['__v'] = _v;
    return map;
  }

}

/// _id : "646ee780e076be9266892a1f"
/// price : 29.95
/// currency : "$"
/// discount : 70
/// discountType : "percentage"
/// numberOfTripsAllowed : 50
/// numberOfItterationsPerTrip : 10
/// description : "FREE Trips for 1 Year "
/// isDisabled : false
/// vendorProductId : "in_app_planify_8999_1y"

class SubscriptionPlan {
  SubscriptionPlan({
      String? id, 
      num? price, 
      String? currency, 
      num? discount, 
      String? discountType, 
      num? numberOfTripsAllowed, 
      num? numberOfItterationsPerTrip, 
      String? description, 
      bool? isDisabled, 
      String? vendorProductId,}){
    _id = id;
    _price = price;
    _currency = currency;
    _discount = discount;
    _discountType = discountType;
    _numberOfTripsAllowed = numberOfTripsAllowed;
    _numberOfItterationsPerTrip = numberOfItterationsPerTrip;
    _description = description;
    _isDisabled = isDisabled;
    _vendorProductId = vendorProductId;
}

  SubscriptionPlan.fromJson(dynamic json) {
    _id = json['_id'];
    _price = json['price'];
    _currency = json['currency'];
    _discount = json['discount'];
    _discountType = json['discountType'];
    _numberOfTripsAllowed = json['numberOfTripsAllowed'];
    _numberOfItterationsPerTrip = json['numberOfItterationsPerTrip'];
    _description = json['description'];
    _isDisabled = json['isDisabled'];
    _vendorProductId = json['vendorProductId'];
  }
  String? _id;
  num? _price;
  String? _currency;
  num? _discount;
  String? _discountType;
  num? _numberOfTripsAllowed;
  num? _numberOfItterationsPerTrip;
  String? _description;
  bool? _isDisabled;
  String? _vendorProductId;
SubscriptionPlan copyWith({  String? id,
  num? price,
  String? currency,
  num? discount,
  String? discountType,
  num? numberOfTripsAllowed,
  num? numberOfItterationsPerTrip,
  String? description,
  bool? isDisabled,
  String? vendorProductId,
}) => SubscriptionPlan(  id: id ?? _id,
  price: price ?? _price,
  currency: currency ?? _currency,
  discount: discount ?? _discount,
  discountType: discountType ?? _discountType,
  numberOfTripsAllowed: numberOfTripsAllowed ?? _numberOfTripsAllowed,
  numberOfItterationsPerTrip: numberOfItterationsPerTrip ?? _numberOfItterationsPerTrip,
  description: description ?? _description,
  isDisabled: isDisabled ?? _isDisabled,
  vendorProductId: vendorProductId ?? _vendorProductId,
);
  String? get id => _id;
  num? get price => _price;
  String? get currency => _currency;
  num? get discount => _discount;
  String? get discountType => _discountType;
  num? get numberOfTripsAllowed => _numberOfTripsAllowed;
  num? get numberOfItterationsPerTrip => _numberOfItterationsPerTrip;
  String? get description => _description;
  bool? get isDisabled => _isDisabled;
  String? get vendorProductId => _vendorProductId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['price'] = _price;
    map['currency'] = _currency;
    map['discount'] = _discount;
    map['discountType'] = _discountType;
    map['numberOfTripsAllowed'] = _numberOfTripsAllowed;
    map['numberOfItterationsPerTrip'] = _numberOfItterationsPerTrip;
    map['description'] = _description;
    map['isDisabled'] = _isDisabled;
    map['vendorProductId'] = _vendorProductId;
    return map;
  }

}

/// _id : "64763ac17a8bd95df3b44871"
/// email : "thor@gmail.com"
/// password : "$2b$12$55bAXiWRsXyZPJGpSQVVlO4dbmV0PWGipOdeg8EtWheNMSjf4rKce"
/// user_channel_type : "tiktok"
/// currency : "usd"
/// createdAt : "2023-05-30T18:04:49.916Z"
/// updatedAt : "2023-05-30T18:04:49.916Z"
/// __v : 0
/// firstName : "Thor"
/// lastName : "Asgard"

class User {
  User({
      String? id, 
      String? email, 
      String? password, 
      String? userChannelType, 
      String? currency, 
      String? createdAt, 
      String? updatedAt, 
      num? v, 
      String? firstName, 
      String? lastName,}){
    _id = id;
    _email = email;
    _password = password;
    _userChannelType = userChannelType;
    _currency = currency;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _firstName = firstName;
    _lastName = lastName;
}

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _email = json['email'];
    _password = json['password'];
    _userChannelType = json['user_channel_type'];
    _currency = json['currency'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
  }
  String? _id;
  String? _email;
  String? _password;
  String? _userChannelType;
  String? _currency;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  String? _firstName;
  String? _lastName;
User copyWith({  String? id,
  String? email,
  String? password,
  String? userChannelType,
  String? currency,
  String? createdAt,
  String? updatedAt,
  num? v,
  String? firstName,
  String? lastName,
}) => User(  id: id ?? _id,
  email: email ?? _email,
  password: password ?? _password,
  userChannelType: userChannelType ?? _userChannelType,
  currency: currency ?? _currency,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
);
  String? get id => _id;
  String? get email => _email;
  String? get password => _password;
  String? get userChannelType => _userChannelType;
  String? get currency => _currency;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;
  String? get firstName => _firstName;
  String? get lastName => _lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['email'] = _email;
    map['password'] = _password;
    map['user_channel_type'] = _userChannelType;
    map['currency'] = _currency;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    return map;
  }

}