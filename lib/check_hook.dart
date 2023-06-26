import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChecksController<T> extends ChangeNotifier {
  final List<T> data;
  late final List<bool> selected;
  ChecksController(this.data) {
    selected = List.filled(data.length, false);
  }

  void toggle(int index) {
    selected[index] = !selected[index];
    notifyListeners();
  }

  void addAll(Iterable<int> indexes) {
    for (var index in indexes) {
      selected[index] = true;
    }
    notifyListeners();
  }

  void clear() {
    selected = List.filled(data.length, false);
    notifyListeners();
  }

  bool contains(int index) => selected[index];

  List<T> getSelected() =>
      selected.indexed.where((val) => val.$2).map((e) => data[e.$1]).toList();
  List<T> getUnSelected(List<T> allValue) =>
      selected.indexed.where((val) => !val.$2).map((e) => data[e.$1]).toList();
}

ChecksController<T> useChecksHook<T>(List<T> data) {
  return useListenable(useMemoized(() => ChecksController<T>(data), [data]));
}
