class ExampleFinal {
  ExampleFinal({
    required this.string,
    required this.boolean,
    required this.number,
    required this.arrayInt,
    required this.abcSs,
    required this.array_string,
    required this.array_dynamic,
    this.array_intOrNull,
    this.stringForceMaybeNull,
    required this.numberForceRequired,
    required this.changed1,
    required this.changed2Required,
    this.changed3MaybeNull,
    required this.obj,
    required this.arrayObj,
  });

  late final String string;
  late final bool boolean;
  late final int number;
  late final List<int> arrayInt;
  late final int abcSs;
  late final List<String> array_string;
  late final List<dynamic> array_dynamic;
  late final List<int>? array_intOrNull;
  late final String? stringForceMaybeNull;
  late final int numberForceRequired;
  late final int changed1;
  late final int changed2Required;
  late final int? changed3MaybeNull;
  late final ExampleFinalObj obj;
  late final List<ExampleFinalArrayObjItem> arrayObj;

  ExampleFinal.fromJson(Map<String, dynamic> json) {
    string = json['string'];
    boolean = json['boolean'];
    number = json['number'];
    arrayInt = List.castFrom<dynamic, int>(json['array int']);
    abcSs = json['abc-ss'];
    array_string = List.castFrom<dynamic, String>(json['array_string']);
    array_dynamic = List.castFrom<dynamic, dynamic>(json['array_dynamic']);
    array_intOrNull = json['array_int-or-null'] == null ? null : List.castFrom<dynamic, int>(json['array_int-or-null']);
    stringForceMaybeNull = json['string-force-maybe-null'];
    numberForceRequired = json['number-force-required'];
    changed1 = json['originname1'];
    changed2Required = json['originname2'];
    changed3MaybeNull = json['originname3'];
    obj = ExampleFinalObj.fromJson(json['obj']);
    arrayObj = List.from(json['arrayObj']).map((e) => ExampleFinalArrayObjItem.fromJson(e)).toList();
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
      'array_int-or-null': array_intOrNull,
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

class ExampleFinalObj {
  ExampleFinalObj({
    required this.a,
    required this.b,
  });

  late final int a;
  late final String b;

  ExampleFinalObj.fromJson(Map<String, dynamic> json) {
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

class ExampleFinalArrayObjItem {
  ExampleFinalArrayObjItem({
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

  late final String string;
  late final int number;
  late final dynamic dyanmic;
  late final String? maybeNull;
  late final int? numberForceOrNull;
  late final ExampleFinalArrayObjItemDeepObj deepObj;
  late final List<int>? arr;
  late final List<dynamic>? arr2;
  late final int? numberForceMaybeNull;

  ExampleFinalArrayObjItem.fromJson(Map<String, dynamic> json) {
    string = json['string'];
    number = json['number'];
    dyanmic = json['dyanmic'];
    maybeNull = json['maybe-null'];
    numberForceOrNull = json['number-force-or-null'];
    deepObj = ExampleFinalArrayObjItemDeepObj.fromJson(json['deep-obj']);
    arr = json['arr'] == null ? null : List.castFrom<dynamic, int>(json['arr']);
    arr2 = json['arr2'] == null ? null : List.castFrom<dynamic, dynamic>(json['arr2']);
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

class ExampleFinalArrayObjItemDeepObj {
  ExampleFinalArrayObjItemDeepObj({
    required this.ss,
    this.arr,
  });

  late final String ss;
  late final List<int>? arr;

  ExampleFinalArrayObjItemDeepObj.fromJson(Map<String, dynamic> json) {
    ss = json['ss'];
    arr = json['arr'] == null ? null : List.castFrom<dynamic, int>(json['arr']);
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
