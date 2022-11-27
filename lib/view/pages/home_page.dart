import 'package:calculator/view/widgets/calculator_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controller/riverpod.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';
import '../widgets/calculator_buttons.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(left: 8.0),
          child: const Text('Calculator'),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          const Expanded(
            child: CalculatorResult(),
          ),
          Expanded(flex: 2, child: buildButtons())
        ],
      )),
    );
  }

  Widget buildButtons() => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: MyColors.background2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(children: [
          buildButtonRow('AC', '<', '^', '÷'),
          buildButtonRow('7', '8', '9', '⨯'),
          buildButtonRow('4', '5', '6', '-'),
          buildButtonRow('1', '2', '3', '+'),
          buildButtonRow('0', '.', '', '='),
        ]),
      );

  Widget buildButtonRow(
    String first,
    String second,
    String third,
    String fourth,
  ) {
    final row = [first, second, third, fourth];

    return Expanded(
      child: Row(
        children: row
            .map((text) => Button(
                  text: text,
                  onClicked: () => onClickedButton(text),
                  onClickedLong: () => onLongClickedButton(text),
                ))
            .toList(),
      ),
    );
  }

  void onClickedButton(String buttonText) {
    final calculator = ref.read(calculatorProvider.notifier);

    switch (buttonText) {
      case 'AC':
        calculator.reset();
        break;
      case '=':
        calculator.equals();
        break;
      case '<':
        calculator.delete();
        break;
      default:
        calculator.append(buttonText);
        break;
    }
  }

  void onLongClickedButton(String text) {
    final calculator = ref.read(calculatorProvider.notifier);

    if (text == '<') {
      calculator.reset();
    }
  }
}
