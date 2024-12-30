/// code : 0
/// message : "Previous Trip itinerary found successfully"
/// data : {"tripItineraries":[{"_id":"646e1ce3f257b7f15d1e4aee","day":"1","title":"Exploring the Marais District","activities":[{"title":"Visit the Picasso Museum","type":"Experience","price":14,"currency":"euro","url":"https://www.museepicassoparis.fr/en/"},{"title":"Lunch at Miznon","type":"Activity","price":20,"currency":"euro","url":"https://miznonparis.com/"},{"title":"Explore the Place des Vosges","type":"Natural Location","price":0,"currency":"euro","url":"https://en.parisinfo.com/paris-museum-monument/71387/Place-des-Vosges"},{"title":"Visit the Carnavalet Museum","type":"Experience","price":0,"currency":"euro","url":"https://www.carnavalet.paris.fr/en/"}],"trip":"646e1bbbf257b7f15d1e4acf","parent":"646e1bbbf257b7f15d1e4ad1","__v":0}]}

class PreviousTripIterationResponse {
  PreviousTripIterationResponse({
    num? code,
    String? message,
    Data? data,
  }) {
    _code = code;
    _message = message;
    _data = data;
  }

  PreviousTripIterationResponse.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? _code;
  String? _message;
  Data? _data;

  PreviousTripIterationResponse copyWith({
    num? code,
    String? message,
    Data? data,
  }) =>
      PreviousTripIterationResponse(
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

/// tripItineraries : [{"_id":"646e1ce3f257b7f15d1e4aee","day":"1","title":"Exploring the Marais District","activities":[{"title":"Visit the Picasso Museum","type":"Experience","price":14,"currency":"euro","url":"https://www.museepicassoparis.fr/en/"},{"title":"Lunch at Miznon","type":"Activity","price":20,"currency":"euro","url":"https://miznonparis.com/"},{"title":"Explore the Place des Vosges","type":"Natural Location","price":0,"currency":"euro","url":"https://en.parisinfo.com/paris-museum-monument/71387/Place-des-Vosges"},{"title":"Visit the Carnavalet Museum","type":"Experience","price":0,"currency":"euro","url":"https://www.carnavalet.paris.fr/en/"}],"trip":"646e1bbbf257b7f15d1e4acf","parent":"646e1bbbf257b7f15d1e4ad1","__v":0}]

class Data {
  Data({
    List<TripItineraries>? tripItineraries,
  }) {
    _tripItineraries = tripItineraries;
  }

  Data.fromJson(dynamic json) {
    if (json['tripItineraries'] != null) {
      _tripItineraries = [];
      json['tripItineraries'].forEach((v) {
        _tripItineraries?.add(TripItineraries.fromJson(v));
      });
    }
  }

  List<TripItineraries>? _tripItineraries;

  Data copyWith({
    List<TripItineraries>? tripItineraries,
  }) =>
      Data(
        tripItineraries: tripItineraries ?? _tripItineraries,
      );

  List<TripItineraries>? get tripItineraries => _tripItineraries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_tripItineraries != null) {
      map['tripItineraries'] =
          _tripItineraries?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "646e1ce3f257b7f15d1e4aee"
/// day : "1"
/// title : "Exploring the Marais District"
/// activities : [{"title":"Visit the Picasso Museum","type":"Experience","price":14,"currency":"euro","url":"https://www.museepicassoparis.fr/en/"},{"title":"Lunch at Miznon","type":"Activity","price":20,"currency":"euro","url":"https://miznonparis.com/"},{"title":"Explore the Place des Vosges","type":"Natural Location","price":0,"currency":"euro","url":"https://en.parisinfo.com/paris-museum-monument/71387/Place-des-Vosges"},{"title":"Visit the Carnavalet Museum","type":"Experience","price":0,"currency":"euro","url":"https://www.carnavalet.paris.fr/en/"}]
/// trip : "646e1bbbf257b7f15d1e4acf"
/// parent : "646e1bbbf257b7f15d1e4ad1"
/// __v : 0

class TripItineraries {
  TripItineraries({
    String? id,
    String? day,
    String? title,
    List<Activities>? activities,
    String? trip,
    String? parent,
    num? v,
  }) {
    _id = id;
    _day = day;
    _title = title;
    _activities = activities;
    _trip = trip;
    _parent = parent;
    _v = v;
  }

  TripItineraries.fromJson(dynamic json) {
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
    _parent = json['parent'];
    _v = json['__v'];
  }

  String? _id;
  String? _day;
  String? _title;
  List<Activities>? _activities;
  String? _trip;
  String? _parent;
  num? _v;

  TripItineraries copyWith({
    String? id,
    String? day,
    String? title,
    List<Activities>? activities,
    String? trip,
    String? parent,
    num? v,
  }) =>
      TripItineraries(
        id: id ?? _id,
        day: day ?? _day,
        title: title ?? _title,
        activities: activities ?? _activities,
        trip: trip ?? _trip,
        parent: parent ?? _parent,
        v: v ?? _v,
      );

  String? get id => _id;

  String? get day => _day;

  String? get title => _title;

  List<Activities>? get activities => _activities;

  String? get trip => _trip;

  String? get parent => _parent;

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
    map['parent'] = _parent;
    map['__v'] = _v;
    return map;
  }
}

/// title : "Walk across the Golden Gate Bridge"
/// type : "Natural Location"
/// price : 0
/// currency : "usd"
/// period: "Afternoon"
/// commutingTime: "1 hour"
///  "per": "person",
/// url : "https://www.goldengate.org/"

class Activities {
  Activities({
    String? title,
    String? type,
    num? price,
    String? currency,
    String? period,
    String? commutingTime,
    String? per,
    String? url,
  }) {
    _title = title;
    _type = type;
    _price = price;
    _currency = currency;
    _url = url;
    _period = period;
    _commutingTime = commutingTime;
    _per = per;
  }

  Activities.fromJson(dynamic json) {
    _title = json['title'];
    _type = json['type'];
    _price = json['price'];
    _currency = json['currency'];
    _url = json['url'];
    _period = json['period'];
    _commutingTime = json['commutingTime'];
    _per = json['per'];
  }

  String? _title;
  String? _type;
  num? _price;
  String? _currency;
  String? _url;
  String? _period;
  String? _commutingTime;
  String? _per;

  Activities copyWith({
    String? title,
    String? type,
    num? price,
    String? currency,
    String? url,
    String? period,
    String? commutingTime,
    String? per,
  }) =>
      Activities(
        title: title ?? _title,
        type: type ?? _type,
        price: price ?? _price,
        currency: currency ?? _currency,
        url: url ?? _url,
        period: period ?? _period,
        commutingTime: commutingTime ?? _commutingTime,
        per: per ?? _per,
      );

  String? get title => _title;

  String? get type => _type;

  num? get price => _price;

  String? get currency => _currency;

  String? get url => _url;

  String? get commutingTime => _commutingTime;

  String? get period => _period;

  String? get per => _per;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['type'] = _type;
    map['price'] = _price;
    map['currency'] = _currency;
    map['url'] = _url;
    map['period'] = _period;
    map['commutingTime'] = _commutingTime;
    map['per'] = _per;
    return map;
  }
}

