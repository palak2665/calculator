import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/utils.dart';

class Button extends StatefulWidget {
  const Button(
      {super.key,
      required this.text,
      required this.onClicked,
      required this.onClickedLong});
  final String text;
  final VoidCallback onClicked;
  final VoidCallback onClickedLong;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isElevated = true;
  @override
  Widget build(BuildContext context) {
    final color = getTextColor(widget.text);
    final double fontSize =
        Utils.isOperator(widget.text, hasEquals: true) ? 26 : 22;
    final style = TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
    return Expanded(
      child: GestureDetector(
        onTap: widget.onClicked,
        onLongPress: widget.onClickedLong,
        child: Container(
          height: double.infinity,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: MyColors.background3,
              borderRadius: BorderRadius.circular(20),
              boxShadow: _isElevated
                  ? [
                      BoxShadow(
                        color: MyColors.shadowlight,
                        offset: const Offset(-6.0, -6.0),
                        blurRadius: 16.0,
                      ),
                      BoxShadow(
                        color: MyColors.shadowdark,
                        offset: const Offset(6.0, 6.0),
                        blurRadius: 16.0,
                      ),
                    ]
                  : null),
          child: Center(
            child: widget.text == '<'
                ? Icon(Icons.backspace_outlined, color: color)
                : Text(widget.text, style: style),
          ),
        ),
      ),
    );
  }

  Color getTextColor(String buttonText) {
    switch (buttonText) {
      case '+':
      case '-':
      case '⨯':
      case '÷':
      case '=':
        return MyColors.operators;
      case 'AC':
      case '<':
      case '%':
        return MyColors.delete;
      default:
        return MyColors.numbers;
    }
  }
}
