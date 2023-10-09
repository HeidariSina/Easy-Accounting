import 'package:flutter/material.dart';
import 'package:money/class/data.dart';
import 'package:money/class/items.dart';
import 'package:money/sideComponents/balance_row.dart';
import 'package:money/sideComponents/my_bar_chart.dart';
import 'package:money/sideComponents/my_line_chart.dart';
import '../class/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Items> allItems = [];
  // ignore: prefer_typing_uninitialized_variables
  Map<int, double> moun = {};
  Map<int, double> weak = {
    0: 0,
    1: 0,
    2: 0,
    3: 0,
    4: 0,
    5: 0,
    6: 0,
  };
  String name = "";
  double income = 0;
  double thisYear = 0;
  double thismounth = 0;
  double lastmounth = 0;
  String iconNumber = "1";
  @override
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name')!;
      income = prefs.getDouble("income")!;
      iconNumber = prefs.getString("iconNumber")!;
    });
    var iiiii = await items();
    var now = DateTime.now();
    int i = 1;
    while (i <= now.month) {
      moun.addAll({i: 0});
      i++;
    }
    for (var item in iiiii) {
      if (DateTime.parse(item.time).year == now.year) {
        setState(() {
          moun.update(
            DateTime.parse(item.time).month,
            (value) => value + double.parse(item.amount),
          );
          thisYear = thisYear - double.parse(item.amount);
        });
      }
      if (now.difference(DateTime.parse(item.time)).inDays <= now.weekday - 1) {
        weak.update(
            now.weekday - 1 - now.difference(DateTime.parse(item.time)).inDays,
            (value) => value + double.parse(item.amount));
      }
    }
    if (now.month > 1) {
      thismounth = moun[now.month]!;
      lastmounth = moun[now.month - 1]!;
    } else {
      thismounth = moun[now.month]!;
      for (var item in iiiii) {
        if (DateTime.parse(item.time).year == now.year - 1 &&
            DateTime.parse(item.time).month == 12) {
          lastmounth = lastmounth + double.parse(item.amount);
        }
      }
    }
    moun.updateAll((key, value) => value = income - value);
    super.setState(() {
      allItems = iiiii;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).viewPadding.top + 30,
            left: 15,
            right: 15,
          ),
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.onSurface,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello,",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 45,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 5),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 45,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).colorScheme.primary),
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 7, top: 5, end: 10, start: 10),
                    width: 60,
                    height: 60,
                    child: Image.asset(icons[iconNumber]!),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.only(top: 50, bottom: 40),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).colorScheme.onSurface,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "Your Balance :",
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    BalanceRow(mounths[DateTime.now().month].toString(), income,
                        thismounth),
                    BalanceRow(
                        DateTime.now().month == 1
                            ? mounths[12].toString()
                            : mounths[DateTime.now().month - 1].toString(),
                        income,
                        lastmounth),
                    BalanceRow(DateTime.now().year.toString(),
                        (DateTime.now().month * income), thisYear),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      padding: const EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: const Text(
                        "This Year So Far :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: MyLineChart(moun),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 20),
                      padding: const EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: const Text(
                        "This Weak So Far :",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: MyBarChart(weak),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
