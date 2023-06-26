import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:set_hook/check_hook.dart';
import 'package:set_hook/set_hook.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends HookWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = useMemoized(() => [for (var i = 0; i < 1000000; i++) i]);
    final set = useSetHook<int>();
    return Scaffold(
      appBar: AppBar(
        // use set.getSelected() to get selected item
        // use set.getUnSelected(data) to get un-selected item
        title: Text(
            '${set.getSelected().length} ${set.getUnSelected(data).length}'),
        actions: [
          ElevatedButton(
              onPressed: () {
                // clear all
                set.clear();
              },
              child: Text('Clear All')),
          ElevatedButton(
              onPressed: () {
                // select more than one item
                set.addAll(data.sublist(4, 10));
              },
              child: Text('Select items')),
        ],
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, i) {
            final item = data[i];
            return CheckboxListTile(
              value: set.contains(item),
              onChanged: (val) => set.toggle(item),
              title: Text(item.toString()),
            );
          }),
    );
  }
}

class Home2Widget extends HookWidget {
  const Home2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = useMemoized(() => [for (var i = 0; i < 1000000; i++) "$i"]);
    final set = useChecksHook<String>(data);
    return Scaffold(
      appBar: AppBar(
        // use set.getSelected() to get selected item
        // use set.getUnSelected(data) to get un-selected item
        title: Text(
            '${set.getSelected().length} ${set.getUnSelected(data).length}'),
        actions: [
          ElevatedButton(
              onPressed: () {
                // clear all
                set.clear();
              },
              child: Text('Clear All')),
          ElevatedButton(
              onPressed: () {
                // select more than one item
                // this is the index of item
                set.addAll([4, 5, 6, 7, 8, 9]);
              },
              child: Text('Select items')),
        ],
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, i) {
            final item = data[i];
            return CheckboxListTile(
              value: set.contains(i),
              onChanged: (val) => set.toggle(i),
              title: Text(item.toString()),
            );
          }),
    );
  }
}
