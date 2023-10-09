import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyAllCards extends StatelessWidget {
  final String text;
  final double amount;
  IconData myIcon = Icons.monetization_on_sharp;
  MyAllCards(this.amount, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    if (text == "eating") {
    } else if (text == "clothes") {
    } else if (text == "games") {
    } else if (text == "education") {
    } else if (text == "room") {
    } else if (text == "others") {}

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(children: [
        Row(
          children: [
            Text(text),
            Text('\$$amount'),
          ],
        )
      ]),
    );
  }
}
