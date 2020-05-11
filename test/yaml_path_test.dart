import 'package:test/test.dart';

import 'package:yaml_path/yaml_path.dart';

void main() {
  test('simple path, simple value should return simple value', () {
    var doc = StringYaml.fromString('''
      toto: a
    ''');
    var path = YamlPath.fromData(doc);

    expect(path.extract('toto'), equals('a'));
  });

  test('simple node path, complex type should return complex value', () {
    var doc = StringYaml.fromString('''
    toto: 
      a: toto
      b: 3
    ''');
    var path = YamlPath.fromData(doc);

    expect(path.extract('toto'), equals({'a': 'toto', 'b': 3}));
  });

  test('empty path, should return doc', () {
    var doc = StringYaml.fromString('''
    toto: 
      a: toto
      b: 3
    ''');
    var path = YamlPath.fromData(doc);

    expect(
        path.extract(''),
        equals({
          'toto': {'a': 'toto', 'b': 3}
        }));
  });

  test('complex path to string should return string node', () {
    var doc = StringYaml.fromString('''
    toto: 
      a: toto
      b: 3
    ''');
    var path = YamlPath.fromData(doc);

    expect(path.extract('toto/a'), equals('toto'));
  });

  test('complex path to list should return list node', () {
    var doc = StringYaml.fromString('''
    toto: 
      a: toto
      b: 3
      c: [1, 2, 3]
    ''');
    var path = YamlPath.fromData(doc);

    expect(path.extract('toto/c'), equals([1, 2, 3]));
  });
  test('complex path to num should return num node', () {
    var doc = StringYaml.fromString('''
    toto: 
      a: toto
      b: 3
    ''');
    var path = YamlPath.fromData(doc);

    expect(path.extract('toto/b'), equals(3));
  });

  test('complex path to complex not should return complex node', () {
    var doc = StringYaml.fromString('''
    toto: 
      a: toto
      b: 3
      complex:
        host: test
        username: tata
    ''');
    var path = YamlPath.fromData(doc);

    expect(path.extract('toto/complex'), equals({'host': 'test', 'username': 'tata'}));
  });
}
