import 'dart:io';
import 'package:yaml/yaml.dart';

import 'cache.dart';

abstract class YamlData {
  Map<dynamic, dynamic> read();
}

class StringYaml implements YamlData {
  Cache<String, Map<dynamic, dynamic>> _cache;

  StringYaml.fromString(String content, {bool cache: true})
      : 
      assert(content != null),
      assert(cache != null),
      _cache = Cache(
          content,
          map: (file) => loadYaml(content),
          cache: cache,
        );

  Map<dynamic, dynamic> read() => _cache.read();
}

class FileYaml implements YamlData {
  Cache<File, Map<dynamic, dynamic>> _cache;

  FileYaml.fromFile(File file, {bool cache: true})
      : 
      assert(file != null),
      assert(cache != null),
      _cache = Cache(
          file,
          map: (f) => loadYaml(file.readAsStringSync(), sourceUrl: file.uri),
          cache: cache,
        );

  Map<dynamic, dynamic> read() => _cache.read();
}
