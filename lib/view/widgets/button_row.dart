import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/riverpod.dart';
import '../../utils/colors.dart';
import 'calculator_buttons.dart';

class CalculatorButtons extends StatelessWidget {
  const CalculatorButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: MyColors.background2,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Column(
        children: const [
          CalculatorButtonsRow(
            buttonsRow: ['AC', '<', '^', '÷'],
          ),
          CalculatorButtonsRow(
            buttonsRow: ['7', '8', '9', '⨯'],
          ),
          CalculatorButtonsRow(
            buttonsRow: ['4', '5', '6', '-'],
          ),
          CalculatorButtonsRow(
            buttonsRow: ['1', '2', '3', '+'],
          ),
          CalculatorButtonsRow(
            buttonsRow: ['', '0', '.', '='],
          ),
        ],
      ),
    );
  }
}

class CalculatorButtonsRow extends ConsumerWidget {
  const CalculatorButtonsRow({
    required this.buttonsRow,
    super.key,
  });

  final buttonsRow;

  void onClickedButton(String buttonText, WidgetRef ref) {
    final calculator = ref.read(calculatorProvider.notifier);
    final type = ref.read(calculatorProvider.notifier).setType();
    switch (buttonText) {
      case 'C':
        calculator.reset();
        break;
      case '=':
        calculator.equals();
        break;
      case '<':
        calculator.delete();
        break;
      case '':
        break;

      default:
        calculator.append(buttonText);
        break;
    }
  }

  void onLongClickedButton(String text, WidgetRef ref) {
    final calculator = ref.read(calculatorProvider.notifier);

    if (text == '<') {
      calculator.reset();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Row(
        children: buttonsRow
            .map((text) => Button(
                  text: text,
                  onClicked: () => onClickedButton(text, ref),
                  onClickedLong: () => onLongClickedButton(text, ref),
                ))
            .toList(),
      ),
    );
  }
}
