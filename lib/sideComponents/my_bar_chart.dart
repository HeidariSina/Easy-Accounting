import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyBarChart extends StatelessWidget {
  final Map<int, double> data;
  const MyBarChart(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    var barGroup1 = makeGroupData(0, data.values.elementAt(0), context);
    var barGroup2 = makeGroupData(1, data.values.elementAt(1), context);
    var barGroup3 = makeGroupData(2, data.values.elementAt(2), context);
    var barGroup4 = makeGroupData(3, data.values.elementAt(3), context);
    var barGroup5 = makeGroupData(4, data.values.elementAt(4), context);
    var barGroup6 = makeGroupData(5, data.values.elementAt(5), context);
    var barGroup7 = makeGroupData(6, data.values.elementAt(6), context);
    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    double max = 0;
    int i = 0;
    while (i < 7) {
      if (max < data.values.elementAt(i)) {
        max = data.values.elementAt(i);
      }
      i++;
    }
    double interval = max / 2;
    if (interval == 0) {
      interval = 1;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: 2,
        child: BarChart(
          BarChartData(
            maxY: max,
            titlesData: FlTitlesData(
              show: true,
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: bottomTitles,
                  reservedSize: 42,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: interval,
                  getTitlesWidget: leftTitles,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: items,
            gridData: FlGridData(show: false),
          ),

          swapAnimationDuration: const Duration(seconds: 2), // Optional
          swapAnimationCurve: Curves.linear, // Optional
        ),
      ),
    );
  }
}

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff7589a2),
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  if (value > 1000000 || value < -1000000) {
    return Text("${(value / 1000000).toStringAsFixed(1)}M",
        style: style, textAlign: TextAlign.left);
  }
  if (value > 1000 || value < -1000) {
    return Text("${(value / 1000).toStringAsFixed(1)}K",
        style: style, textAlign: TextAlign.left);
  } else {
    return Text(value.toStringAsFixed(0),
        style: style, textAlign: TextAlign.left);
  }
}

Widget bottomTitles(double value, TitleMeta meta) {
  final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

  final Widget text = Text(
    titles[value.toInt()],
    style: const TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16, //margin top
    child: text,
  );
}

BarChartGroupData makeGroupData(int x, double y1, context) {
  return BarChartGroupData(
    barsSpace: 4,
    x: x,
    barRods: [
      BarChartRodData(
        toY: y1,
        color: Theme.of(context).colorScheme.primary,
        width: 7,
      ),
    ],
  );
}
