import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({required this.count, Key? key}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  const CounterIncrementor({required this.onPressed, Key? key})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late Future<int> _localCounter;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _localCounter = fetchCounter().then((value) => _counter = value);
  }

  Future<void> _increment() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      ++_counter;
    });

    await prefs.setInt('counter', _counter);
  }

  Future<int> fetchCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final int counter = prefs.getInt('counter') ?? 0;

    return counter;
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       CounterIncrementor(onPressed: _increment),
  //       const SizedBox(width: 16),
  //       CounterDisplay(count: _counter),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _localCounter,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CounterIncrementor(onPressed: _increment),
                const SizedBox(width: 16),
                CounterDisplay(count: _counter),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const CircularProgressIndicator();
        });
  }
}
