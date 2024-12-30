/// code : 1
/// message : "\"Rendering in progress, please try again shortly. Note: Rendering may take up to 1 minute to complete"
/// data : {"_id":"64a3bfe0a27bbf6917e515c6","isPublic":true,"budget":1000,"numberOfMembers":3,"numberOfDays":5,"companyOf":"Unknown","commuteType":"Public","departureLocation":"New York, USA","destination":"Rome, Italy","description":"This trip contributes to more sustainable future and reducing your environmental footprint. 😊","distance":6900,"fromDate":"2023-06-01T07:37:34.871Z","toDate":"2023-06-05T07:37:34.871Z","createdAt":"2023-07-04T06:44:48.858Z","updatedAt":"2023-07-04T06:44:48.858Z","shareCode":"cpvleh7h","iterationsRemaining":10,"tripItinerary":[{"_id":"64a3bfe1a27bbf6917e515c8","day":"1","title":"Explore Ancient Rome","activities":[{"title":"Visit the Colosseum","type":"Experience","period":"Morning","commutingTime":"30 minutes","price":16,"per":"per person","currency":"euro","url":"https://www.coopculture.it/en/colosseo-e-shop.cfm"},{"title":"Tour the Roman Forum","type":"Experience","period":"Afternoon","commutingTime":"10 minutes","price":16,"per":"per person","currency":"euro","url":"https://www.coopculture.it/en/colosseo-e-shop.cfm"},{"title":"Dinner at Roscioli","type":"Activity","period":"Evening","commutingTime":"20 minutes","price":60,"per":"per person","currency":"euro","url":"https://www.roscioli.com/"}],"trip":"64a3bfe0a27bbf6917e515c6","createdAt":"2023-07-04T06:44:49.615Z","updatedAt":"2023-07-04T06:44:49.615Z","__v":0},{"_id":"64a3bfe1a27bbf6917e515c9","day":"2","title":"Vatican City","activities":[{"title":"Visit the Vatican Museums","type":"Experience","period":"Morning","commutingTime":"30 minutes","price":17,"per":"per person","currency":"euro","url":"https://biglietteriamusei.vatican.va/musei/tickets/do?action=booking&codiceLivelloVis=5&step=0"},{"title":"Tour St. Peter's Basilica","type":"Experience","period":"Afternoon","commutingTime":"10 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.vaticancitytours.it/st-peters-basilica-tours.html"},{"title":"Dinner at La Pergola","type":"Activity","period":"Evening","commutingTime":"30 minutes","price":150,"per":"per person","currency":"euro","url":"https://www.romecavalieri.com/la-pergola/"}],"trip":"64a3bfe0a27bbf6917e515c6","createdAt":"2023-07-04T06:44:49.615Z","updatedAt":"2023-07-04T06:44:49.615Z","__v":0},{"_id":"64a3bfe1a27bbf6917e515ca","day":"3","title":"Trevi Fountain and Pantheon","activities":[{"title":"Visit the Trevi Fountain","type":"Natural Location","period":"Morning","commutingTime":"20 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.turismoroma.it/en/places/trevi-fountain"},{"title":"Tour the Pantheon","type":"Experience","period":"Afternoon","commutingTime":"10 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.turismoroma.it/en/places/pantheon"},{"title":"Dinner at Osteria del Pegno","type":"Activity","period":"Evening","commutingTime":"15 minutes","price":50,"per":"per person","currency":"euro","url":"https://osteriadelpegno.it/"}],"trip":"64a3bfe0a27bbf6917e515c6","createdAt":"2023-07-04T06:44:49.615Z","updatedAt":"2023-07-04T06:44:49.615Z","__v":0},{"_id":"64a3bfe1a27bbf6917e515cb","day":"4","title":"Trastevere and Villa Borghese","activities":[{"title":"Explore Trastevere","type":"Experience","period":"Morning","commutingTime":"20 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.turismoroma.it/en/places/trastevere"},{"title":"Visit Villa Borghese","type":"Natural Location","period":"Afternoon","commutingTime":"30 minutes","price":20,"per":"per person","currency":"euro","url":"https://www.galleriaborghese.it/en/"},{"title":"Dinner at Da Enzo al 29","type":"Activity","period":"Evening","commutingTime":"20 minutes","price":40,"per":"per person","currency":"euro","url":"https://www.daenzoal29.com/"}],"trip":"64a3bfe0a27bbf6917e515c6","createdAt":"2023-07-04T06:44:49.615Z","updatedAt":"2023-07-04T06:44:49.615Z","__v":0},{"_id":"64a3bfe1a27bbf6917e515cc","day":"5","title":"Piazza Navona and Campo de' Fiori","activities":[{"title":"Visit Piazza Navona","type":"Natural Location","period":"Morning","commutingTime":"10 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.turismoroma.it/en/places/piazza-navona"},{"title":"Explore Campo de' Fiori Market","type":"Experience","period":"Afternoon","commutingTime":"10 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.turismoroma.it/en/places/campo-de-fiori-market"},{"title":"Farewell Dinner at Il Pagliaccio","type":"Activity","period":"Evening","commutingTime":"15 minutes","price":120,"per":"per person","currency":"euro","url":"https://www.ristoranteilpagliaccio.com/"}],"trip":"64a3bfe0a27bbf6917e515c6","createdAt":"2023-07-04T06:44:49.615Z","updatedAt":"2023-07-04T06:44:49.615Z","__v":0}],"owner":{"_id":"64a3bcf4a27bbf6917e5155d","email":"testuser12345@mailinator.com","password":"$2b$12$MgMuo6/.2g82zYdG2YjPo.3ow28Dk4AT1DI.yJs/h6i4JL2kbAZpO","user_channel_type":"tiktok","currency":"euro","isActive":true,"createdAt":"2023-07-04T06:32:20.718Z","updatedAt":"2023-07-04T06:32:20.718Z","__v":0,"firstName":"Test","lastName":"User"},"__v":1}

class CreateTripResponse {
  CreateTripResponse({
      num? code, 
      String? message, 
      Data? data,}){
    _code = code;
    _message = message;
    _data = data;
}

  CreateTripResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _code;
  String? _message;
  Data? _data;
CreateTripResponse copyWith({  num? code,
  String? message,
  Data? data,
}) => CreateTripResponse(  code: code ?? _code,
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

/// _id : "64a3bfe0a27bbf6917e515c6"
/// isPublic : true
/// budget : 1000
/// numberOfMembers : 3
/// numberOfDays : 5
/// companyOf : "Unknown"
/// commuteType : "Public"
/// departureLocation : "New York, USA"
/// destination : "Rome, Italy"
/// description : "This trip contributes to more sustainable future and reducing your environmental footprint. 😊"
/// distance : 6900
/// fromDate : "2023-06-01T07:37:34.871Z"
/// toDate : "2023-06-05T07:37:34.871Z"
/// createdAt : "2023-07-04T06:44:48.858Z"
/// updatedAt : "2023-07-04T06:44:48.858Z"
/// shareCode : "cpvleh7h"
/// iterationsRemaining : 10
/// tripItinerary : [{"_id":"64a3bfe1a27bbf6917e515c8","day":"1","title":"Explore Ancient Rome","activities":[{"title":"Visit the Colosseum","type":"Experience","period":"Morning","commutingTime":"30 minutes","price":16,"per":"per person","currency":"euro","url":"https://www.coopculture.it/en/colosseo-e-shop.cfm"},{"title":"Tour the Roman Forum","type":"Experience","period":"Afternoon","commutingTime":"10 minutes","price":16,"per":"per person","currency":"euro","url":"https://www.coopculture.it/en/colosseo-e-shop.cfm"},{"title":"Dinner at Roscioli","type":"Activity","period":"Evening","commutingTime":"20 minutes","price":60,"per":"per person","currency":"euro","url":"https://www.roscioli.com/"}],"trip":"64a3bfe0a27bbf6917e515c6","createdAt":"2023-07-04T06:44:49.615Z","updatedAt":"2023-07-04T06:44:49.615Z","__v":0},{"_id":"64a3bfe1a27bbf6917e515c9","day":"2","title":"Vatican City","activities":[{"title":"Visit the Vatican Museums","type":"Experience","period":"Morning","commutingTime":"30 minutes","price":17,"per":"per person","currency":"euro","url":"https://biglietteriamusei.vatican.va/musei/tickets/do?action=booking&codiceLivelloVis=5&step=0"},{"title":"Tour St. Peter's Basilica","type":"Experience","period":"Afternoon","commutingTime":"10 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.vaticancitytours.it/st-peters-basilica-tours.html"},{"title":"Dinner at La Pergola","type":"Activity","period":"Evening","commutingTime":"30 minutes","price":150,"per":"per person","currency":"euro","url":"https://www.romecavalieri.com/la-pergola/"}],"trip":"64a3bfe0a27bbf6917e515c6","createdAt":"2023-07-04T06:44:49.615Z","updatedAt":"2023-07-04T06:44:49.615Z","__v":0},{"_id":"64a3bfe1a27bbf6917e515ca","day":"3","title":"Trevi Fountain and Pantheon","activities":[{"title":"Visit the Trevi Fountain","type":"Natural Location","period":"Morning","commutingTime":"20 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.turismoroma.it/en/places/trevi-fountain"},{"title":"Tour the Pantheon","type":"Experience","period":"Afternoon","commutingTime":"10 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.turismoroma.it/en/places/pantheon"},{"title":"Dinner at Osteria del Pegno","type":"Activity","period":"Evening","commutingTime":"15 minutes","price":50,"per":"per person","currency":"euro","url":"https://osteriadelpegno.it/"}],"trip":"64a3bfe0a27bbf6917e515c6","createdAt":"2023-07-04T06:44:49.615Z","updatedAt":"2023-07-04T06:44:49.615Z","__v":0},{"_id":"64a3bfe1a27bbf6917e515cb","day":"4","title":"Trastevere and Villa Borghese","activities":[{"title":"Explore Trastevere","type":"Experience","period":"Morning","commutingTime":"20 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.turismoroma.it/en/places/trastevere"},{"title":"Visit Villa Borghese","type":"Natural Location","period":"Afternoon","commutingTime":"30 minutes","price":20,"per":"per person","currency":"euro","url":"https://www.galleriaborghese.it/en/"},{"title":"Dinner at Da Enzo al 29","type":"Activity","period":"Evening","commutingTime":"20 minutes","price":40,"per":"per person","currency":"euro","url":"https://www.daenzoal29.com/"}],"trip":"64a3bfe0a27bbf6917e515c6","createdAt":"2023-07-04T06:44:49.615Z","updatedAt":"2023-07-04T06:44:49.615Z","__v":0},{"_id":"64a3bfe1a27bbf6917e515cc","day":"5","title":"Piazza Navona and Campo de' Fiori","activities":[{"title":"Visit Piazza Navona","type":"Natural Location","period":"Morning","commutingTime":"10 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.turismoroma.it/en/places/piazza-navona"},{"title":"Explore Campo de' Fiori Market","type":"Experience","period":"Afternoon","commutingTime":"10 minutes","price":0,"per":"per person","currency":"euro","url":"https://www.turismoroma.it/en/places/campo-de-fiori-market"},{"title":"Farewell Dinner at Il Pagliaccio","type":"Activity","period":"Evening","commutingTime":"15 minutes","price":120,"per":"per person","currency":"euro","url":"https://www.ristoranteilpagliaccio.com/"}],"trip":"64a3bfe0a27bbf6917e515c6","createdAt":"2023-07-04T06:44:49.615Z","updatedAt":"2023-07-04T06:44:49.615Z","__v":0}]
/// owner : {"_id":"64a3bcf4a27bbf6917e5155d","email":"testuser12345@mailinator.com","password":"$2b$12$MgMuo6/.2g82zYdG2YjPo.3ow28Dk4AT1DI.yJs/h6i4JL2kbAZpO","user_channel_type":"tiktok","currency":"euro","isActive":true,"createdAt":"2023-07-04T06:32:20.718Z","updatedAt":"2023-07-04T06:32:20.718Z","__v":0,"firstName":"Test","lastName":"User"}
/// __v : 1

class Data {
  Data({
      String? id, 
      bool? isPublic, 
      num? budget, 
      num? numberOfMembers, 
      num? numberOfDays, 
      String? companyOf, 
      String? commuteType, 
      String? departureLocation, 
      String? destination, 
      String? description, 
      num? distance, 
      String? fromDate, 
      String? toDate, 
      String? createdAt, 
      String? updatedAt, 
      String? shareCode, 
      num? iterationsRemaining, 
      List<TripItinerary>? tripItinerary, 
      Owner? owner, 
      num? v,}){
    _id = id;
    _isPublic = isPublic;
    _budget = budget;
    _numberOfMembers = numberOfMembers;
    _numberOfDays = numberOfDays;
    _companyOf = companyOf;
    _commuteType = commuteType;
    _departureLocation = departureLocation;
    _destination = destination;
    _description = description;
    _distance = distance;
    _fromDate = fromDate;
    _toDate = toDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _shareCode = shareCode;
    _iterationsRemaining = iterationsRemaining;
    _tripItinerary = tripItinerary;
    _owner = owner;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _isPublic = json['isPublic'];
    _budget = json['budget'];
    _numberOfMembers = json['numberOfMembers'];
    _numberOfDays = json['numberOfDays'];
    _companyOf = json['companyOf'];
    _commuteType = json['commuteType'];
    _departureLocation = json['departureLocation'];
    _destination = json['destination'];
    _description = json['description'];
    _distance = json['distance'];
    _fromDate = json['fromDate'];
    _toDate = json['toDate'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _shareCode = json['shareCode'];
    _iterationsRemaining = json['iterationsRemaining'];
    if (json['tripItinerary'] != null) {
      _tripItinerary = [];
      json['tripItinerary'].forEach((v) {
        _tripItinerary?.add(TripItinerary.fromJson(v));
      });
    }
    _owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    _v = json['__v'];
  }
  String? _id;
  bool? _isPublic;
  num? _budget;
  num? _numberOfMembers;
  num? _numberOfDays;
  String? _companyOf;
  String? _commuteType;
  String? _departureLocation;
  String? _destination;
  String? _description;
  num? _distance;
  String? _fromDate;
  String? _toDate;
  String? _createdAt;
  String? _updatedAt;
  String? _shareCode;
  num? _iterationsRemaining;
  List<TripItinerary>? _tripItinerary;
  Owner? _owner;
  num? _v;
Data copyWith({  String? id,
  bool? isPublic,
  num? budget,
  num? numberOfMembers,
  num? numberOfDays,
  String? companyOf,
  String? commuteType,
  String? departureLocation,
  String? destination,
  String? description,
  num? distance,
  String? fromDate,
  String? toDate,
  String? createdAt,
  String? updatedAt,
  String? shareCode,
  num? iterationsRemaining,
  List<TripItinerary>? tripItinerary,
  Owner? owner,
  num? v,
}) => Data(  id: id ?? _id,
  isPublic: isPublic ?? _isPublic,
  budget: budget ?? _budget,
  numberOfMembers: numberOfMembers ?? _numberOfMembers,
  numberOfDays: numberOfDays ?? _numberOfDays,
  companyOf: companyOf ?? _companyOf,
  commuteType: commuteType ?? _commuteType,
  departureLocation: departureLocation ?? _departureLocation,
  destination: destination ?? _destination,
  description: description ?? _description,
  distance: distance ?? _distance,
  fromDate: fromDate ?? _fromDate,
  toDate: toDate ?? _toDate,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  shareCode: shareCode ?? _shareCode,
  iterationsRemaining: iterationsRemaining ?? _iterationsRemaining,
  tripItinerary: tripItinerary ?? _tripItinerary,
  owner: owner ?? _owner,
  v: v ?? _v,
);
  String? get id => _id;
  bool? get isPublic => _isPublic;
  num? get budget => _budget;
  num? get numberOfMembers => _numberOfMembers;
  num? get numberOfDays => _numberOfDays;
  String? get companyOf => _companyOf;
  String? get commuteType => _commuteType;
  String? get departureLocation => _departureLocation;
  String? get destination => _destination;
  String? get description => _description;
  num? get distance => _distance;
  String? get fromDate => _fromDate;
  String? get toDate => _toDate;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get shareCode => _shareCode;
  num? get iterationsRemaining => _iterationsRemaining;
  List<TripItinerary>? get tripItinerary => _tripItinerary;
  Owner? get owner => _owner;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['isPublic'] = _isPublic;
    map['budget'] = _budget;
    map['numberOfMembers'] = _numberOfMembers;
    map['numberOfDays'] = _numberOfDays;
    map['companyOf'] = _companyOf;
    map['commuteType'] = _commuteType;
    map['departureLocation'] = _departureLocation;
    map['destination'] = _destination;
    map['description'] = _description;
    map['distance'] = _distance;
    map['fromDate'] = _fromDate;
    map['toDate'] = _toDate;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['shareCode'] = _shareCode;
    map['iterationsRemaining'] = _iterationsRemaining;
    if (_tripItinerary != null) {
      map['tripItinerary'] = _tripItinerary?.map((v) => v.toJson()).toList();
    }
    if (_owner != null) {
      map['owner'] = _owner?.toJson();
    }
    map['__v'] = _v;
    return map;
  }

}

/// _id : "64a3bcf4a27bbf6917e5155d"
/// email : "testuser12345@mailinator.com"
/// password : "$2b$12$MgMuo6/.2g82zYdG2YjPo.3ow28Dk4AT1DI.yJs/h6i4JL2kbAZpO"
/// user_channel_type : "tiktok"
/// currency : "euro"
/// isActive : true
/// createdAt : "2023-07-04T06:32:20.718Z"
/// updatedAt : "2023-07-04T06:32:20.718Z"
/// __v : 0
/// firstName : "Test"
/// lastName : "User"

class Owner {
  Owner({
      String? id, 
      String? email, 
      String? password, 
      String? userChannelType, 
      String? currency, 
      bool? isActive, 
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
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _firstName = firstName;
    _lastName = lastName;
}

  Owner.fromJson(dynamic json) {
    _id = json['_id'];
    _email = json['email'];
    _password = json['password'];
    _userChannelType = json['user_channel_type'];
    _currency = json['currency'];
    _isActive = json['isActive'];
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
  bool? _isActive;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  String? _firstName;
  String? _lastName;
Owner copyWith({  String? id,
  String? email,
  String? password,
  String? userChannelType,
  String? currency,
  bool? isActive,
  String? createdAt,
  String? updatedAt,
  num? v,
  String? firstName,
  String? lastName,
}) => Owner(  id: id ?? _id,
  email: email ?? _email,
  password: password ?? _password,
  userChannelType: userChannelType ?? _userChannelType,
  currency: currency ?? _currency,
  isActive: isActive ?? _isActive,
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
  bool? get isActive => _isActive;
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
    map['isActive'] = _isActive;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    return map;
  }

}

/// _id : "64a3bfe1a27bbf6917e515c8"
/// day : "1"
/// title : "Explore Ancient Rome"
/// activities : [{"title":"Visit the Colosseum","type":"Experience","period":"Morning","commutingTime":"30 minutes","price":16,"per":"per person","currency":"euro","url":"https://www.coopculture.it/en/colosseo-e-shop.cfm"},{"title":"Tour the Roman Forum","type":"Experience","period":"Afternoon","commutingTime":"10 minutes","price":16,"per":"per person","currency":"euro","url":"https://www.coopculture.it/en/colosseo-e-shop.cfm"},{"title":"Dinner at Roscioli","type":"Activity","period":"Evening","commutingTime":"20 minutes","price":60,"per":"per person","currency":"euro","url":"https://www.roscioli.com/"}]
/// trip : "64a3bfe0a27bbf6917e515c6"
/// createdAt : "2023-07-04T06:44:49.615Z"
/// updatedAt : "2023-07-04T06:44:49.615Z"
/// __v : 0

class TripItinerary {
  TripItinerary({
      String? id, 
      String? day, 
      String? title, 
      List<Activities>? activities, 
      String? trip, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _day = day;
    _title = title;
    _activities = activities;
    _trip = trip;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  TripItinerary.fromJson(dynamic json) {
    _id = json['_id'];
    _day = json['day'];
    _title = json['title'];
    if (json['activities'] != null) {
      _activities = [];
      json['activities'].forEach((v) {
        _activities?.add(Activities.fromJson(v));
      });
    }
    _trip = json['trip'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _day;
  String? _title;
  List<Activities>? _activities;
  String? _trip;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
TripItinerary copyWith({  String? id,
  String? day,
  String? title,
  List<Activities>? activities,
  String? trip,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => TripItinerary(  id: id ?? _id,
  day: day ?? _day,
  title: title ?? _title,
  activities: activities ?? _activities,
  trip: trip ?? _trip,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get day => _day;
  String? get title => _title;
  List<Activities>? get activities => _activities;
  String? get trip => _trip;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['day'] = _day;
    map['title'] = _title;
    if (_activities != null) {
      map['activities'] = _activities?.map((v) => v.toJson()).toList();
    }
    map['trip'] = _trip;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/// title : "Visit the Colosseum"
/// type : "Experience"
/// period : "Morning"
/// commutingTime : "30 minutes"
/// price : 16
/// per : "per person"
/// currency : "euro"
/// url : "https://www.coopculture.it/en/colosseo-e-shop.cfm"

class Activities {
  Activities({
      String? title, 
      String? type, 
      String? period, 
      String? commutingTime, 
      num? price, 
      String? per, 
      String? currency, 
      String? url,}){
    _title = title;
    _type = type;
    _period = period;
    _commutingTime = commutingTime;
    _price = price;
    _per = per;
    _currency = currency;
    _url = url;
}

  Activities.fromJson(dynamic json) {
    _title = json['title'];
    _type = json['type'];
    _period = json['period'];
    _commutingTime = json['commutingTime'];
    _price = json['price'];
    _per = json['per'];
    _currency = json['currency'];
    _url = json['url'];
  }
  String? _title;
  String? _type;
  String? _period;
  String? _commutingTime;
  num? _price;
  String? _per;
  String? _currency;
  String? _url;
Activities copyWith({  String? title,
  String? type,
  String? period,
  String? commutingTime,
  num? price,
  String? per,
  String? currency,
  String? url,
}) => Activities(  title: title ?? _title,
  type: type ?? _type,
  period: period ?? _period,
  commutingTime: commutingTime ?? _commutingTime,
  price: price ?? _price,
  per: per ?? _per,
  currency: currency ?? _currency,
  url: url ?? _url,
);
  String? get title => _title;
  String? get type => _type;
  String? get period => _period;
  String? get commutingTime => _commutingTime;
  num? get price => _price;
  String? get per => _per;
  String? get currency => _currency;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['type'] = _type;
    map['period'] = _period;
    map['commutingTime'] = _commutingTime;
    map['price'] = _price;
    map['per'] = _per;
    map['currency'] = _currency;
    map['url'] = _url;
    return map;
  }

}