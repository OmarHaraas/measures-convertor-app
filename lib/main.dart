import 'package:flutter/material.dart';

//Author: Omar Roshdy.
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String? _resultMessage;
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };
  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };
  String? _startMeasure;
  String? _convertedMeasure;
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];
  double? _numberFrom;
  @override
  Widget build(BuildContext context) {
    final TextStyle inputStyle = TextStyle(
      fontSize: 20,
      color: Colors.blue[900],
    );
    final TextStyle labelStyle = TextStyle(
      fontSize: 24,
      color: Colors.grey[700],
    );
    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Measures Converter'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,/
            children: [
              const Spacer(),
              Text("Value", style: labelStyle),
              const Spacer(),
              TextField(
                onChanged: (text) {
                  var rv = double.tryParse(text);
                  if (rv != null) {
                    setState(() {
                      _numberFrom = rv;
                    });
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Enter a value to convert it',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                // textAlign: TextAlign.right,
                // textDirection: TextDirection.rtl,
                style: inputStyle,
              ),

              const Spacer(),
              Text(
                'From',
                style: labelStyle,
              ),
              // Spacer(),
              DropdownButton(
                style: inputStyle,
                isExpanded: true,
                value: _startMeasure,
                items: _measures.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _startMeasure = value;
                  });
                },
              ),
              const Spacer(),
              Text(
                'To',
                style: labelStyle,
              ),
              /////////////////////////////////////////////
              const Spacer(),
              DropdownButton(
                style: inputStyle,
                value: _convertedMeasure,
                isExpanded: true,
                items: _measures.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _convertedMeasure = value;
                  });
                },
              ),
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () {
                  if (_startMeasure == null ||
                      _convertedMeasure == null ||
                      _numberFrom == null) {
                    return;
                  }
                  if (_startMeasure!.isEmpty ||
                      _convertedMeasure!.isEmpty ||
                      _numberFrom == 0) {
                    return;
                  } else {
                    convert(_numberFrom!, _startMeasure!, _convertedMeasure!);
                  }
                },
                child: Text(
                  'convert',
                  style: inputStyle,
                ),
              ),
              const Spacer(flex: 2),
              Text(
                (_resultMessage == null) ? '' : _resultMessage.toString(),
                style: labelStyle,
              ),
              const Spacer(flex: 8),
            ],
          ),
        ),
      ),
    );
  }

  void convert(double value, String from, String to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multiplier = _formulas[nFrom.toString()][nTo];
    var result = value * multiplier;
    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage =
          '${_numberFrom.toString()} $_startMeasure are ${result.toString()} $_convertedMeasure';
    }
    setState(() {
      _resultMessage = _resultMessage;
    });
  }
}
