extension MapExt<K, V> on Map<K, V> {
  String joinToString(String f(K key, V value)) {
    if (this.isEmpty) return "";
    final sb = StringBuffer();
    for (var key in this.keys) {
      sb.write(f(key, this[key]));
    }
    return sb.toString();
  }
}

extension ListExt<E> on List<E> {
  E safeGet(int index) {
    if (this == null) {
      return null;
    } else if (index < 0 || index >= this.length) {
      return null;
    } else {
      return this[index];
    }
  }
}
