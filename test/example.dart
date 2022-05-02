class Example {
  Example({
    required this.string,
    required this.boolean,
    required this.number,
    required this.arrayint,
    required this.abcSs,
    required this.arraystring,
    required this.arraydynamic,
    required this.obj,
    required this.arrayObj,
  });

  late String string;
  late bool boolean;
  late int number;
  late List<int> arrayint;
  late int abcSs;
  late List<String> arraystring;
  late List<dynamic> arraydynamic;
  late ExampleObj obj;
  late List<ExampleArrayObjItem> arrayObj;

  Example.fromJson(Map<String, dynamic> json) {
    string = json['string'];
    boolean = json['boolean'];
    number = json['number'];
    arrayint = List.castFrom<dynamic, int>(json['arrayint']);
    abcSs = json['abc-ss'];
    arraystring = List.castFrom<dynamic, String>(json['arraystring']);
    arraydynamic = List.castFrom<dynamic, dynamic>(json['arraydynamic']);
    obj = ExampleObj.fromJson(json['obj']);
    arrayObj = List.from(json['arrayObj']).map((e) => ExampleArrayObjItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['string'] = string;
    _data['boolean'] = boolean;
    _data['number'] = number;
    _data['arrayint'] = arrayint;
    _data['abc-ss'] = abcSs;
    _data['arraystring'] = arraystring;
    _data['arraydynamic'] = arraydynamic;
    _data['obj'] = obj.toJson();
    _data['arrayObj'] = arrayObj.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class ExampleObj {
  ExampleObj({
    required this.a,
    required this.b,
  });

  late int a;
  late String b;

  ExampleObj.fromJson(Map<String, dynamic> json) {
    a = json['a'];
    b = json['b'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['a'] = a;
    _data['b'] = b;
    return _data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class ExampleArrayObjItem {
  ExampleArrayObjItem({
    required this.string,
    required this.number,
    required this.dyanmic,
    this.ornull,
    required this.deepObj,
    this.arr,
    this.arr2,
  });

  late String string;
  late int number;
  late dynamic dyanmic;
  String? ornull;
  late ExampleArrayObjItemDeepObj deepObj;
  List<int>? arr;
  List<dynamic>? arr2;

  ExampleArrayObjItem.fromJson(Map<String, dynamic> json) {
    string = json['string'];
    number = json['number'];
    dyanmic = json['dyanmic'];
    ornull = json['ornull'];
    deepObj = ExampleArrayObjItemDeepObj.fromJson(json['deep-obj']);
    if (json['arr'] != null) arr = List.castFrom<dynamic, int>(json['arr']);
    if (json['arr2'] != null) arr2 = List.castFrom<dynamic, dynamic>(json['arr2']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['string'] = string;
    _data['number'] = number;
    _data['dyanmic'] = dyanmic;
    _data['ornull'] = ornull;
    _data['deep-obj'] = deepObj.toJson();
    _data['arr'] = arr;
    _data['arr2'] = arr2;
    return _data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class ExampleArrayObjItemDeepObj {
  ExampleArrayObjItemDeepObj({
    required this.ss,
    this.arr,
  });

  late String ss;
  List<int>? arr;

  ExampleArrayObjItemDeepObj.fromJson(Map<String, dynamic> json) {
    ss = json['ss'];
    if (json['arr'] != null) arr = List.castFrom<dynamic, int>(json['arr']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ss'] = ss;
    _data['arr'] = arr;
    return _data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}