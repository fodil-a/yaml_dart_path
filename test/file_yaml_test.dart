import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:yaml_path/yaml_path.dart';

class FileMock extends Mock implements File {}

void main() {
  test('good file should return good result on read', () {
    var file = FileMock();
    when(file.readAsStringSync()).thenReturn('toto: a');
    var doc = FileYaml.fromFile(file);

    expect(doc.read(), equals({'toto': 'a'}));
  });

  test('empty file should return null on read', () {
    var file = FileMock();
    when(file.readAsStringSync()).thenReturn('');
    var doc = FileYaml.fromFile(file);

    expect(doc.read(), isNull);
  });

  test('missing file should throw exception on read', () {
    var file = FileMock();
    when(file.readAsStringSync()).thenThrow(FileSystemException('error'));
    var doc = FileYaml.fromFile(file);

    expect(() => doc.read(), throwsException);
  });
 
  test('null file should throw exception on construction', () {
    expect(() => FileYaml.fromFile(null), throwsA(TypeMatcher<AssertionError>()));
  });

  test('null cache should throw exception on construction', () {
    expect(() => FileYaml.fromFile(FileMock(), cache: null), throwsA(TypeMatcher<AssertionError>()));
  });
}
