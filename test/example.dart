class Example {
  Example({
    required this.string,
    required this.boolean,
    required this.number,
    required this.arrayInt,
    required this.abcSs,
    required this.array_string,
    required this.array_dynamic,
    this.stringForceMaybeNull,
    required this.numberForceRequired,
    required this.obj,
    required this.arrayObj,
  });

  late String string;
  late bool boolean;
  late int number;
  late List<int> arrayInt;
  late int abcSs;
  late List<String> array_string;
  late List<dynamic> array_dynamic;
  String? stringForceMaybeNull;
  late int numberForceRequired;
  late ExampleObj obj;
  late List<ExampleArrayObjItem> arrayObj;

  Example.fromJson(Map<String, dynamic> json) {
    string = json['string'];
    boolean = json['boolean'];
    number = json['number'];
    arrayInt = List.castFrom<dynamic, int>(json['array int']);
    abcSs = json['abc-ss'];
    array_string = List.castFrom<dynamic, String>(json['array_string']);
    array_dynamic = List.castFrom<dynamic, dynamic>(json['array_dynamic']);
    stringForceMaybeNull = json['string-force-maybe-null'];
    numberForceRequired = json['number-force-required'];
    obj = ExampleObj.fromJson(json['obj']);
    arrayObj = List.from(json['arrayObj']).map((e) => ExampleArrayObjItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['string'] = string;
    _data['boolean'] = boolean;
    _data['number'] = number;
    _data['array int'] = arrayInt;
    _data['abc-ss'] = abcSs;
    _data['array_string'] = array_string;
    _data['array_dynamic'] = array_dynamic;
    _data['string-force-maybe-null'] = stringForceMaybeNull;
    _data['number-force-required'] = numberForceRequired;
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
    this.maybeNull,
    this.numberForceOrNull,
    required this.deepObj,
    this.arr,
    this.arr2,
    this.numberForceMaybeNull,
  });

  late String string;
  late int number;
  late dynamic dyanmic;
  String? maybeNull;
  int? numberForceOrNull;
  late ExampleArrayObjItemDeepObj deepObj;
  List<int>? arr;
  List<dynamic>? arr2;
  int? numberForceMaybeNull;

  ExampleArrayObjItem.fromJson(Map<String, dynamic> json) {
    string = json['string'];
    number = json['number'];
    dyanmic = json['dyanmic'];
    maybeNull = json['maybe-null'];
    numberForceOrNull = json['number-force-or-null'];
    deepObj = ExampleArrayObjItemDeepObj.fromJson(json['deep-obj']);
    if (json['arr'] != null) arr = List.castFrom<dynamic, int>(json['arr']);
    if (json['arr2'] != null) arr2 = List.castFrom<dynamic, dynamic>(json['arr2']);
    numberForceMaybeNull = json['number-force-maybe-null'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['string'] = string;
    _data['number'] = number;
    _data['dyanmic'] = dyanmic;
    _data['maybe-null'] = maybeNull;
    _data['number-force-or-null'] = numberForceOrNull;
    _data['deep-obj'] = deepObj.toJson();
    _data['arr'] = arr;
    _data['arr2'] = arr2;
    _data['number-force-maybe-null'] = numberForceMaybeNull;
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