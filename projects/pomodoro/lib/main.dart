import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pomodoro/store/counter.store.dart';

void main() {
  runApp(const MainApp());
}

final store = CounterStore();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.green),
      home: Scaffold(
        body: Center(
          child: Observer(
            builder: (_) => Text(
              '${store.counter}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: store.add,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
