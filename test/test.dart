import 'dart:io';
import 'dart:convert';

import 'example.dart';

void main() async {
  final file = File("${Platform.script.toFilePath().replaceFirst('test/test.dart', '')}/src/example.ts");
  final text = (await file.readAsString())
      .replaceAll('export const example = `', '')
      .replaceAll('`;', '')
      .replaceAllMapped(RegExp(r'[?!](\s*"\s*:)'), (m) => m.group(1) ?? '')
      .replaceAllMapped(RegExp(r'@.+(\s*"\s*:)'), (m) => m.group(1) ?? '');

  final _json = json.decode(text);
  final example = Example.fromJson(_json);
  test('string', example.string == 'string');
  test('boolean', example.boolean == true);
  test('number', example.number == 123);
  test('stringForceMaybeNull', example.stringForceMaybeNull == '1');
  test('numberForceRequired', example.numberForceRequired == 1);
  test('changed1', example.changed1 == 1);
  test('changed2Required', example.changed2Required == 1);
  test('changed3MaybeNull', example.changed3MaybeNull == 1);
  test('array_string.first', example.array_string.first == '2');
  test('arrayInt.first', example.arrayInt.first == 1);
  test('array_dynamic.first', example.array_dynamic.first == 1);
  test('array_dynamic.last', example.array_dynamic.last == '4');
  test('obj.a', example.obj.a == 1);
  test('obj.b', example.obj.b == '1');
  test('arrayObj.first.string', example.arrayObj.first.string == 'string');
  test('arrayObj.first.number', example.arrayObj.first.number == 123);
  test('arrayObj.first.dyanmic', example.arrayObj.first.dyanmic == '22');
  test('arrayObj.last.dyanmic', example.arrayObj.last.dyanmic == 2324);
  test('arrayObj.first.maybeNull', example.arrayObj.first.maybeNull == '23');
  test('arrayObj.last.maybeNull', example.arrayObj.last.maybeNull == null);
  test('arrayObj.first.deepObj.ss', example.arrayObj.first.deepObj.ss == '33');
  test('arrayObj.first.deepObj.arr?.first', example.arrayObj.first.deepObj.arr?.first == 22);
  test('arrayObj.last.deepObj.arr', example.arrayObj.last.deepObj.arr == null);
  test('toJson', isEqual(example.toJson(), _json));
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
