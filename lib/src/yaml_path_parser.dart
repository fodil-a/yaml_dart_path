import 'yaml_data.dart';

class YamlPath {
  final YamlData _data;

  YamlPath.fromData(this._data);

  dynamic extract(String path) {
    dynamic doc = _data.read();

    if (path.isEmpty) return doc;

    for (String node in path.split('/')) {
      doc = doc[node];
    }

    return doc;
  }
}
