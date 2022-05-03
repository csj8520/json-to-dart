import 'dart:io';
import 'dart:convert';

import 'example.dart';

void main() async {
  final file = File("${Platform.script.toFilePath().replaceFirst('test/test.dart', '')}/src/example.ts");
  final text = (await file.readAsString())
      .replaceAll('export const example = `', '')
      .replaceAll('`;', '')
      .replaceAllMapped(RegExp(r'[?!](\s*"\s*:)'), (m) => m.group(1) ?? '');
  final _json = json.decode(text);
  final example = Example.fromJson(_json);
  test('string', example.string == 'string');
  test('boolean', example.boolean == true);
  test('number', example.number == 123);
  test('stringForceMaybeNull', example.stringForceMaybeNull == '1');
  test('numberForceRequired', example.numberForceRequired == 1);
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
}

void test(String name, bool result) {
  print('test: ${result ? 'pass' : 'fail'} - $name');
}
