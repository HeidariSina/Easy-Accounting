import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import '../class/data.dart';

class MyPieChart extends StatelessWidget {
  final Map<String, double> data;
  final String title;
  final double total;
  const MyPieChart(this.title, this.data, this.total, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: 300,
          child: PieChart(
            swapAnimationDuration: const Duration(seconds: 1),
            swapAnimationCurve: Curves.easeIn,
            PieChartData(
              borderData: FlBorderData(show: false),
              sectionsSpace: 2,
              centerSpaceRadius: 30,
              sections: total == 0
                  ? [
                      PieChartSectionData(
                        color: Theme.of(context).colorScheme.primary,
                        value: 1,
                        title: "Nothing",
                        radius: 80,
                        titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ]
                  : List.generate(
                      data.length,
                      (index) => PieChartSectionData(
                        color: colorList[index],
                        value: data.values.elementAt(index),
                        title:
                            '%${(100 * data.values.elementAt(index) / total).toStringAsFixed(1)}',
                        radius: 100,
                        titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 40),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }
}
