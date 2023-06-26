import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SetController<T> extends ChangeNotifier {
  Set<T> set = {};

  add(T val) {
    set.add(val);
    notifyListeners();
  }

  void toggle(T val) {
    if (contains(val)) {
      remove(val);
    } else {
      add(val);
    }
  }

  void addAll(Iterable<T> items) {
    set.addAll(items);
    notifyListeners();
  }

  void clear() {
    set.clear();
    notifyListeners();
  }

  void remove(T val) {
    set.remove(val);
    notifyListeners();
  }

  bool contains(T val) => set.contains(val);

  List<T> getSelected() => set.toList();
  List<T> getUnSelected(List<T> allValue) =>
      allValue.toSet().difference(set).toList();
}

SetController<T> useSetHook<T>() {
  return useListenable(useMemoized(() => SetController<T>()));
}
