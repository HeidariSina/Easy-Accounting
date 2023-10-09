import 'package:flutter/material.dart';
import './indicator_row.dart';
import './my_pie_chart.dart';

class MyPie extends StatelessWidget {
  final Function funcup;
  final Function funcdown;
  final int index;
  final Map<String, double> totalcount;
  final Map<String, double> totalmoney;
  final Map<String, double> money;
  final Map<String, double> count;
  const MyPie(this.funcup, this.funcdown, this.index, this.totalcount,
      this.totalmoney, this.count, this.money,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta! > 1) {
          funcdown();
        }
        if (details.primaryDelta! < -1) {
          funcup();
        }
      },
      child: Column(
        children: [
          IndicatorRow(money),
          index == 0
              ? Row(
                  children: [
                    MyPieChart(
                      "Amount",
                      money,
                      totalmoney.values.elementAt(0),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          20 -
                          MediaQuery.of(context).size.width / 1.2,
                      child: IconButton(
                        onPressed: () {
                          funcup();
                        },
                        icon: Icon(
                          Icons.arrow_right,
                          color: Theme.of(context).colorScheme.primary,
                          size: 50,
                        ),
                      ),
                    )
                  ],
                )
              : Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width -
                          20 -
                          MediaQuery.of(context).size.width / 1.2,
                      child: IconButton(
                        onPressed: () {
                          funcdown();
                        },
                        icon: Icon(
                          Icons.arrow_left,
                          color: Theme.of(context).colorScheme.primary,
                          size: 50,
                        ),
                      ),
                    ),
                    MyPieChart(
                        "Transaction", count, totalcount.values.elementAt(0)),
                  ],
                ),
        ],
      ),
    );
  }
}
