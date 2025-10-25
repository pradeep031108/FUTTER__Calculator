import 'package:flutter/material.dart';

void main() => runApp(ModernCalculatorApp());

class ModernCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ModernCalculator(),
    );
  }
}

class ModernCalculator extends StatefulWidget {
  @override
  _ModernCalculatorState createState() => _ModernCalculatorState();
}

class _ModernCalculatorState extends State<ModernCalculator> {
  String output = "0";
  String _input = "";
  double num1 = 0;
  double num2 = 0;
  String operator = "";

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        _input = "";
        num1 = 0;
        num2 = 0;
        operator = "";
        output = "0";
      } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
        if (_input.isEmpty) return;
        num1 = double.parse(_input);
        operator = buttonText;
        _input = "";
      } else if (buttonText == "=") {
        if (_input.isEmpty) return;
        num2 = double.parse(_input);
        switch (operator) {
          case "+":
            output = (num1 + num2).toString();
            break;
          case "-":
            output = (num1 - num2).toString();
            break;
          case "×":
            output = (num1 * num2).toString();
            break;
          case "÷":
            output = num2 == 0 ? "Error" : (num1 / num2).toString();
            break;
        }
        _input = output;
        operator = "";
      } else {
        _input += buttonText;
        output = _input;
      }
    });
  }

  Widget buildButton(String text, {Color color = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(22),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Text(
                  output,
                  style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white),
                  maxLines: 1,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton("C", color: Colors.redAccent),
                    buildButton("÷", color: Colors.orange),
                    buildButton("×", color: Colors.orange),
                    buildButton("-", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("+", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("=", color: Colors.green),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("0"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}