import 'package:fl_chart/fl_chart.dart';
import "package:flutter/material.dart";

// ignore: must_be_immutable
class MyLineChart extends StatelessWidget {
  final Map<int, double> moun;
  double max = 0;
  double min = 0;
  double last = 0;
  double intervalLine = 500;
  double interval = 1000;
  var i = 0;
  MyLineChart(this.moun, {super.key});

  @override
  Widget build(BuildContext context) {
    while (i < moun.length) {
      if (moun.values.elementAt(i) > max) {
        max = moun.values.elementAt(i);
      }
      if (moun.values.elementAt(i) < min) {
        min = moun.values.elementAt(i);
      }
      i++;
    }
    if (max > -min) {
      last = max;
    } else {
      last = -min;
    }
    interval = last;
    intervalLine = last / 2;
    if (last == 0) {
      interval = 1;
      intervalLine = 1;
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AspectRatio(
        aspectRatio: 1.8,
        child: LineChart(
          swapAnimationDuration: const Duration(seconds: 1),
          swapAnimationCurve: Curves.easeInOutExpo,
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              drawHorizontalLine: true,
              horizontalInterval: intervalLine,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.white12,
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.white10,
                  strokeWidth: 1,
                );
              },
            ),
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
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: interval,
                  getTitlesWidget: leftTitleWidgets,
                  reservedSize: 65,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: last != 0 ? true : false,
              border: const Border.symmetric(
                  horizontal: BorderSide(color: Colors.white10, width: 1)),
            ),
            minX: 1,
            maxX: double.parse(moun.length.toString()),
            minY: -last,
            maxY: last,
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(
                    moun.length,
                    (index) => FlSpot(
                        double.parse(
                            moun.keys.elementAt(index).toStringAsFixed(0)),
                        moun.values.elementAt(index))),
                isCurved: true,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    Theme.of(context).colorScheme.primary
                  ],
                ),
                barWidth: 3,
                isStrokeCapRound: false,
                dotData: FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: Color(0xff7589a2),
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

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Color(0xff7589a2),
  );
  String text;
  Widget wig;
  switch (value.toInt()) {
    case 1:
      text = 'Jan';
      break;
    case 2:
      text = 'Feb';
      break;
    case 3:
      text = 'Mar';
      break;
    case 4:
      text = 'Apr';
      break;
    case 5:
      text = 'May';
      break;
    case 6:
      text = 'Jun';
      break;
    case 7:
      text = 'Jul';
      break;
    case 8:
      text = 'Aug';
      break;
    case 9:
      text = 'Sep';
      break;
    case 10:
      text = 'Oct';
      break;
    case 11:
      text = 'Nov';
      break;
    case 12:
      text = 'Dec';
      break;
    default:
      text = '';
      break;
  }
  wig = Center(
    child: Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()..rotateZ(-50 * 3.1415927 / 180),
      child: Text(
        text,
        style: style,
      ),
    ),
  );

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: wig,
  );
}
