import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  var userInput = "";
  var answer = "";
  // final List<String> buttons = [
  //   'AC',
  //   'C',
  //   '<',
  //   '/',
  //   '9',
  //   '8',
  //   '7',
  //   'X',
  //   '6',
  //   '5',
  //   '4',
  //   '-',
  //   '3',
  //   '2',
  //   '1',
  //   '+',
  //   '+/-',
  //   '0',
  //   '00',
  //   '=',
  // ];
  String output = '';
  double num1 = 0;
  double num2 = 0;
  String operand = '';
  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        output = '';
        num1 = 0;
        num2 = 0;
        operand = '';
      } else if (buttonText == 'AC') {
        output = '';
        num1 = 0;
        num2 = 0;
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '*' ||
          buttonText == '/') {
        num1 = double.parse(output);
        operand = buttonText;
        output = '';
      } else if (buttonText == 'Calculate' || buttonText == '=') {
        num2 = double.parse(output);
        if (operand == '+') {
          output = (num1 + num2).toString();
        }
        if (operand == '-') {
          output = (num1 - num2).toString();
        }
        if (operand == '*') {
          output = (num1 * num2).toString();
        }
        if (operand == '/') {
          output = (num1 / num2).toString();
        }
        num1 = 0;
        num2 = 0;
        operand = '';
      } else {
        output += buttonText;
      }
    });
  }

  Widget _buildButton(
    String buttonText,
    Color buttonColor,
    Color textColor,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: textColor,
            backgroundColor: buttonColor,
          ),
          onPressed: () {
            _buttonPressed(buttonText);
          },
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      children: buttons
          .map((button) => _buildButton(
                button,
                button == 'C' ? Colors.orange : Colors.blue,
                button == '=' ||
                        button == '/' ||
                        button == '*' ||
                        button == '-' ||
                        button == '+'
                    ? Colors.black
                    : Colors.black,
              ))
          .toList(),
    );
  }
  Widget _buildButtonColumn(List<String> buttons) {
    return Row(
      children: buttons
          .map((button) => _buildButton(
                button,
                button == 'Calculate' ? Colors.orange : Colors.blue,
                button == '=' ||
                        button == '/' ||
                        button == '*' ||
                        button == '-' ||
                        button == '+'
                    ? Colors.black
                    : Colors.black,
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
          title: Text(
            "Calculator",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(
                          output,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ]),
              ),
            ),
            _buildButtonRow(['9', '8', '7', '+']),
            _buildButtonRow(['6', '5', '4', '-']),
            _buildButtonRow(['3', '2', '1', '*']),
            _buildButtonRow(['C', '0','<', '/',]),
            _buildButtonColumn(['Calculate']),
          ],
        ),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  MyButton(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: widget.color, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
