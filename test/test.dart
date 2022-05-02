import 'dart:io';
import 'dart:convert';

import 'example.dart';

void main() async {
  final file = File("${Platform.script.toFilePath().replaceFirst('test/test.dart', '')}/src/example.ts");
  final _js = (await file.readAsString()).replaceAll('export const example = `', '').replaceAll('`;', '');
  final _json = json.decode(_js);
  final example = Example.fromJson(_json);
  test('string', example.string == 'string');
  test('boolean', example.boolean == true);
  test('number', example.number == 123);
  test('arraystring.first', example.arraystring.first == '2');
  test('arrayint.first', example.arrayint.first == 1);
  test('arraydynamic.first', example.arraydynamic.first == 1);
  test('arraydynamic.last', example.arraydynamic.last == '4');
  test('obj.a', example.obj.a == 1);
  test('obj.b', example.obj.b == '1');
  test('arrayObj.first.string', example.arrayObj.first.string == 'string');
  test('arrayObj.first.number', example.arrayObj.first.number == 123);
  test('arrayObj.first.dyanmic', example.arrayObj.first.dyanmic == '22');
  test('arrayObj.last.dyanmic', example.arrayObj.last.dyanmic == 2324);
  test('arrayObj.first.ornull', example.arrayObj.first.ornull == '23');
  test('arrayObj.last.ornull', example.arrayObj.last.ornull == null);
  test('arrayObj.first.deepObj.ss', example.arrayObj.first.deepObj.ss == '33');
  test('arrayObj.first.deepObj.arr?.first', example.arrayObj.first.deepObj.arr?.first == 22);
  test('arrayObj.last.deepObj.arr', example.arrayObj.last.deepObj.arr == null);
}

void test(String name, bool result) {
  print('test: ${result ? 'pass' : 'fail'} - $name');
}
