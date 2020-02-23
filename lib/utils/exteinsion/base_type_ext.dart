///String扩展方法
extension SafeStringExt on String {
  String safeValue(
      {String defaultValue = "", String prefix = "", String postFix = ""}) {
    if (this == null) {
      return defaultValue;
    }
    return prefix + this + postFix;
  }

  /// 转换成int
  /// null -> [defaultValue]
  /// "" -> [defaultValue]
  /// "a" -> [defaultValue]
  /// "123" -> 123
  int safeToInt({int defaultValue = 0}) {
    if (this == null) {
      return defaultValue;
    } else {
      return int.tryParse(this) ?? defaultValue;
    }
  }


  double safeToDouble({double defaultValue = 0}) {
    if (this == null) {
      return defaultValue;
    } else {
      return double.tryParse(this) ?? defaultValue;
    }
  }
}
