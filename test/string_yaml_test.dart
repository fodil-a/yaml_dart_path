import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:yaml_path/yaml_path.dart';

void main() {
  test('good string should return good result on read', () {
    var doc = StringYaml.fromString('toto: a');

    expect(doc.read(), equals({'toto': 'a'}));
  });
  
  test('empty string should return null on read', () {
    var doc = StringYaml.fromString('');

    expect(doc.read(), equals(null));
  });

  test('null string should throw exception on construction', () {
    expect(() => StringYaml.fromString(null), throwsA(TypeMatcher<AssertionError>()));
  });

  test('null cache should throw exception on construction', () {
    expect(() => StringYaml.fromString('a', cache: null), throwsA(TypeMatcher<AssertionError>()));
  });
}
