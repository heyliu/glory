library utils;

export 'exteinsion/widget_ext.dart';
export 'exteinsion/base_type_ext.dart';
export 'exteinsion/collection_ext.dart';

int getSize(Object target) {
  if (target == null) return 0;
  if (target is Iterable) {
    return target.length;
  } else if (target is Map) {
    return target.length;
  } else {
    return 0;
  }
}


