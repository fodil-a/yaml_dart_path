import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:yaml_path/src/cache.dart';

class CacheInMock extends Mock {}

void main() {
  test('good string should return good result on read', () {
    Cache(CacheInMock(), map: (c) => '').read();
  });

  test('cache should never be computed again', () {
    int called = 0;
    Cache(CacheInMock(), map: (c) {
      called++;
      return '';
    }).read();
    expect(called, equals(1));
  });
  test('disabled cache should always again', () {
    int called = 0;
    Cache(CacheInMock(), cache: false, map: (c) {
      called++;
      return '';
    })
      ..read()
      ..read();
    expect(called, equals(2));
  });

  test('null input should return good result on read', () {
    Cache(null, map: (n) => '').read();
  });

  test('null map should throw exception on construction', () {
    expect(() => Cache(CacheInMock(), map: null),
        throwsA(TypeMatcher<AssertionError>()));
  });

  test('null cache should throw exception on construction', () {
    expect(() => Cache(CacheInMock(), cache: null),
        throwsA(TypeMatcher<AssertionError>()));
  });
}
