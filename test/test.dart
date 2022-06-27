import 'dart:io';
import 'dart:convert';

import 'example.dart';
import 'example_final.dart';

final sep = Platform.isWindows ? '\\' : '/';

void main() async {
  final file = File("${Platform.script.toFilePath().replaceFirst('test${sep}test.dart', '')}${sep}src${sep}example.ts");
  final text = (await file.readAsString())
      .replaceAll('export const example = `', '')
      .replaceAll('`;', '')
      .replaceAllMapped(RegExp(r'[?!](\s*"\s*:)'), (m) => m.group(1) ?? '')
      .replaceAllMapped(RegExp(r'@.+(\s*"\s*:)'), (m) => m.group(1) ?? '');

  final _json = json.decode(text);
  final example = Example.fromJson(_json);
  final exampleFinal = ExampleFinal.fromJson(_json);
  test('example.string', example.string == 'string');
  test('example.boolean', example.boolean == true);
  test('example.number', example.number == 123);
  test('example.stringForceMaybeNull', example.stringForceMaybeNull == '1');
  test('example.numberForceRequired', example.numberForceRequired == 1);
  test('example.changed1', example.changed1 == 1);
  test('example.changed2Required', example.changed2Required == 1);
  test('example.changed3MaybeNull', example.changed3MaybeNull == 1);
  test('example.array_string.first', example.array_string.first == '2');
  test('example.arrayInt.first', example.arrayInt.first == 1);
  test('example.array_dynamic.first', example.array_dynamic.first == 1);
  test('example.array_dynamic.last', example.array_dynamic.last == '4');
  test('example.array_intOrNull?.first', example.array_intOrNull?.first == 1);
  test('example.obj.a', example.obj.a == 1);
  test('example.obj.b', example.obj.b == '1');
  test('example.arrayObj.first.string', example.arrayObj.first.string == 'string');
  test('example.arrayObj.first.number', example.arrayObj.first.number == 123);
  test('example.arrayObj.first.dyanmic', example.arrayObj.first.dyanmic == '22');
  test('example.arrayObj.last.dyanmic', example.arrayObj.last.dyanmic == 2324);
  test('example.arrayObj.first.maybeNull', example.arrayObj.first.maybeNull == '23');
  test('example.arrayObj.last.maybeNull', example.arrayObj.last.maybeNull == null);
  test('example.arrayObj.first.deepObj.ss', example.arrayObj.first.deepObj.ss == '33');
  test('example.arrayObj.first.deepObj.arr?.first', example.arrayObj.first.deepObj.arr?.first == 22);
  test('example.arrayObj.last.deepObj.arr', example.arrayObj.last.deepObj.arr == null);
  test('example.toJson', isEqual(example.toJson(), _json));

  // test final override
  try {
    exampleFinal.string = 'override';
    test('exampleFinal.string = "override"', false);
  } catch (e) {
    test('exampleFinal.string = "override"', exampleFinal.string == 'string');
  }
  try {
    exampleFinal.stringForceMaybeNull = 'override';
    test('exampleFinal.stringForceMaybeNull = "override"', false);
  } catch (e) {
    test('exampleFinal.stringForceMaybeNull = "override"', exampleFinal.stringForceMaybeNull == '1');
  }
  try {
    exampleFinal.array_intOrNull = [2, 3];
    test('exampleFinal.array_intOrNull = [2, 3]', false);
  } catch (e) {
    test('exampleFinal.array_intOrNull = [2, 3]', exampleFinal.array_intOrNull?.first == 1);
  }
  exampleFinal.arrayInt[0] = 5;
  test('exampleFinal.arrayInt[0] = 5', exampleFinal.arrayInt.first == 5);
  test('exampleFinal.toJson', isEqual(exampleFinal.toJson(), _json));
}

bool isEqual(dynamic v1, dynamic v2) {
  if (v1 is List) {
    if (!(v2 is List)) return false;
    if (v1.length != v2.length) return false;
    return v1.asMap().keys.every((it) => isEqual(v1[it], v2[it]));
  } else if (v1 is Map) {
    if (!(v2 is Map)) return false;
    final keys = v1.keys.toSet();
    keys.addAll(v2.keys);
    return keys.every((key) => isEqual(v1[key], v2[key]));
  } else {
    return v1 == v2;
  }
}

void test(String name, bool result) {
  print('test: ${result ? 'pass' : 'fail'} - $name');
}
