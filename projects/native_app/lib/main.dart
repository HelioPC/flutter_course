import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _sum = 0;
  bool _isLoading = false;

  final _num1Controller = TextEditingController();
  final _num2Controller = TextEditingController();

  void sum() async {
    setState(() => _isLoading = true);

    if (_num1Controller.text.isEmpty || _num2Controller.text.isEmpty) {
      setState(() => _isLoading = false);
      return;
    }
    debugPrint(
      'num 1: ${_num1Controller.text} | num 2: ${_num2Controller.text}',
    );

    setState(() {
      _sum = (int.tryParse(_num1Controller.text) ?? 0) +
          (int.tryParse(_num2Controller.text) ?? 0);
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native code'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Text(
                      _isLoading ? 'Calculating' : 'Result: $_sum',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              TextField(
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                controller: _num1Controller,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Type number 1',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                onTapOutside: (_) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                controller: _num2Controller,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: 'Type number 2',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_num1Controller.text.isNotEmpty ||
                            _num2Controller.text.isNotEmpty) {
                          _num1Controller.clear();
                          _num2Controller.clear();
                        }
                      },
                      child: const Text('Clear'),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: sum,
                      child: const Text('Execute'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
