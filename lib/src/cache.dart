class Cache<I, O> {
  I _in;
  O _out;
  O Function(I i) _map;
  final bool _cache;
  Cache(
    this._in, {
    O Function(I i) map,
    bool cache: true,
  })  : 
  assert(map != null),
  assert(cache != null),
  _cache = cache,
        _map = map;

  O read() {
    if (_cache) {
      _out ??= _map(_in);
      _in = null;
      _map = null;
    } else {
      _out = _map(_in);
    }
    return _out;
  }
}