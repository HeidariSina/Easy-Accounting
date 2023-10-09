import 'package:flutter/material.dart';

class BalanceRow extends StatelessWidget {
  final String title;
  final double income;
  final double outcome;

  const BalanceRow(this.title, this.income, this.outcome, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "In the $title :",
            style: const TextStyle(color: Color(0xff7589a2)),
          ),
          income - outcome > 0
              ? Text(
                  "Saving",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.surface),
                )
              : Text(
                  "Dissaving",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
          Text(
            "€ ${income - outcome}",
            style: TextStyle(
              color: income - outcome > 0
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}
