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
    required this.changed1,
    required this.changed2Required,
    this.changed3MaybeNull,
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
  late int changed1;
  late int changed2Required;
  int? changed3MaybeNull;
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
    changed1 = json['originname1'];
    changed2Required = json['originname2'];
    changed3MaybeNull = json['originname3'];
    obj = ExampleObj.fromJson(json['obj']);
    arrayObj = List.from(json['arrayObj']).map((e) => ExampleArrayObjItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'string': string,
      'boolean': boolean,
      'number': number,
      'array int': arrayInt,
      'abc-ss': abcSs,
      'array_string': array_string,
      'array_dynamic': array_dynamic,
      'string-force-maybe-null': stringForceMaybeNull,
      'number-force-required': numberForceRequired,
      'originname1': changed1,
      'originname2': changed2Required,
      'originname3': changed3MaybeNull,
      'obj': obj.toJson(),
      'arrayObj': arrayObj.map((e) => e.toJson()).toList(),
    };
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
    return {
      'a': a,
      'b': b,
    };
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
    return {
      'string': string,
      'number': number,
      'dyanmic': dyanmic,
      'maybe-null': maybeNull,
      'number-force-or-null': numberForceOrNull,
      'deep-obj': deepObj.toJson(),
      'arr': arr,
      'arr2': arr2,
      'number-force-maybe-null': numberForceMaybeNull,
    };
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
    return {
      'ss': ss,
      'arr': arr,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
