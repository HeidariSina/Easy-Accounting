import 'package:flutter/material.dart';
import './indicator.dart';
import '../class/data.dart';

class IndicatorRow extends StatelessWidget {
  final Map<String, double> data;
  const IndicatorRow(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Indicator(
              color: colorList[index],
              text: data.keys.elementAt(index),
              isSquare: false);
        },
        itemCount: data.length,
      ),
    );
  }
}
