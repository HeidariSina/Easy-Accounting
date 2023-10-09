import 'package:flutter/material.dart';
import '../class/items.dart';
import '../sideComponents/stat_card.dart';
import '../class/data.dart';
import '../sideComponents/chart.dart';

class StatPage extends StatefulWidget {
  const StatPage({super.key});

  @override
  State<StatPage> createState() => _StatPage();
}

class _StatPage extends State<StatPage> {
  var options = {
    "Total": Icons.attach_money,
    "Eating": Icons.fastfood_rounded,
    "Clothes": Icons.shopping_bag,
    "Games": Icons.sports_esports,
    "Education": Icons.biotech,
    "Home": Icons.cottage,
    "Travel": Icons.train,
    "Others": Icons.question_mark,
  };
  var weakly = [];
  Map<String, double> weaklyTotalM = {
    "Total": 0,
  };
  Map<String, double> weaklyTotalC = {
    "Total": 0,
  };
  Map<String, double> weaklyMoney = {
    "Eating": 0.0,
    "Clothes": 0.0,
    "Games": 0.0,
    "Education": 0.0,
    "Home": 0.0,
    "Travel": 0,
    "Others": 0.0,
  };
  Map<String, double> weaklyCount = {
    "Eating": 0,
    "Clothes": 0,
    "Games": 0,
    "Education": 0,
    "Home": 0,
    "Travel": 0,
    "Others": 0,
  };

  Map<String, double> monthlyTotalM = {
    "Total": 0.0,
  };
  Map<String, double> monthlyTotalC = {
    "Total": 0,
  };

  Map<String, double> monthlyMoney = {
    "Eating": 0,
    "Clothes": 0,
    "Games": 0,
    "Education": 0,
    "Home": 0,
    "Travel": 0,
    "Others": 0,
  };
  Map<String, double> monthlyCount = {
    "Eating": 0,
    "Clothes": 0,
    "Games": 0,
    "Education": 0,
    "Home": 0,
    "Travel": 0,
    "Others": 0,
  };
  Map<String, double> yearlyTotalM = {
    "Total": 0.0,
  };
  Map<String, double> yearlyTotalC = {
    "Total": 0,
  };

  Map<String, double> yearlyMoney = {
    "Eating": 0,
    "Clothes": 0,
    "Games": 0,
    "Education": 0,
    "Home": 0,
    "Travel": 0,
    "Others": 0,
  };
  Map<String, double> yearlyCount = {
    "Eating": 0,
    "Clothes": 0,
    "Games": 0,
    "Education": 0,
    "Home": 0,
    "Travel": 0,
    "Others": 0,
  };

  int weaklyIndex = 0;
  int monthlyIndex = 0;
  int yearlyIndex = 0;

  void upWeaklyIndex() {
    setState(() {
      weaklyIndex = 1;
    });
  }

  void downWeaklyIndex() {
    setState(() {
      weaklyIndex = 0;
    });
  }

  void upMonthlyIndex() {
    setState(() {
      monthlyIndex = 1;
    });
  }

  void downMonthlyIndex() {
    setState(() {
      monthlyIndex = 0;
    });
  }

  void upYearlyIndex() {
    setState(() {
      yearlyIndex = 1;
    });
  }

  void downYearlyIndex() {
    setState(() {
      yearlyIndex = 0;
    });
  }

  @override
  void didChangeDependencies() async {
    weaklyTotalM = {
      "Total": 0,
    };
    weaklyTotalC = {
      "Total": 0,
    };
    weaklyMoney = {
      "Eating": 0.0,
      "Clothes": 0.0,
      "Games": 0.0,
      "Education": 0.0,
      "Home": 0.0,
      "Travel": 0,
      "Others": 0.0,
    };
    weaklyCount = {
      "Eating": 0,
      "Clothes": 0,
      "Games": 0,
      "Education": 0,
      "Home": 0,
      "Travel": 0,
      "Others": 0,
    };

    monthlyTotalM = {
      "Total": 0.0,
    };
    monthlyTotalC = {
      "Total": 0,
    };

    monthlyMoney = {
      "Eating": 0,
      "Clothes": 0,
      "Games": 0,
      "Education": 0,
      "Home": 0,
      "Travel": 0,
      "Others": 0,
    };
    monthlyCount = {
      "Eating": 0,
      "Clothes": 0,
      "Games": 0,
      "Education": 0,
      "Home": 0,
      "Travel": 0,
      "Others": 0,
    };
    yearlyTotalM = {
      "Total": 0.0,
    };
    yearlyTotalC = {
      "Total": 0,
    };

    yearlyMoney = {
      "Eating": 0,
      "Clothes": 0,
      "Games": 0,
      "Education": 0,
      "Home": 0,
      "Travel": 0,
      "Others": 0,
    };
    yearlyCount = {
      "Eating": 0,
      "Clothes": 0,
      "Games": 0,
      "Education": 0,
      "Home": 0,
      "Travel": 0,
      "Others": 0,
    };
    var now = DateTime.now();
    super.didChangeDependencies();
    var iiiii = await items();
    for (var item in iiiii) {
      if (DateTime.parse(item.time).month == now.month) {
        setState(() {
          monthlyCount[item.category] = monthlyCount[item.category]! + 1;
          monthlyTotalC["Total"] = monthlyTotalC["Total"]! + 1;
          monthlyTotalM["Total"] =
              monthlyTotalM["Total"]! + double.parse(item.amount);
          weaklyMoney[item.category] =
              weaklyMoney[item.category]! + double.parse(item.amount);
        });
      }
      if (now.difference(DateTime.parse(item.time)).inDays < 7) {
        setState(() {
          weaklyCount[item.category] = weaklyCount[item.category]! + 1;
          weaklyTotalC["Total"] = weaklyTotalC["Total"]! + 1;
          weaklyTotalM["Total"] =
              weaklyTotalM["Total"]! + double.parse(item.amount);
          monthlyMoney[item.category] =
              monthlyMoney[item.category]! + double.parse(item.amount);
        });
      }
      if (DateTime.parse(item.time).year == now.year) {
        setState(() {
          yearlyCount[item.category] = yearlyCount[item.category]! + 1;
          yearlyTotalC["Total"] = yearlyTotalC["Total"]! + 1;
          yearlyTotalM["Total"] =
              yearlyTotalM["Total"]! + double.parse(item.amount);
          yearlyMoney[item.category] =
              yearlyMoney[item.category]! + double.parse(item.amount);
        });
      }
    }
    super.setState(() {
      weakly = iiiii;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Statistics",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.onSecondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Last 7 Days :",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return StatCard(
                        options.values.elementAt(index),
                        options.keys.elementAt(index),
                        weaklyTotalM.values.elementAt(index),
                        weaklyTotalC.values.elementAt(index),
                      );
                    } else {
                      return StatCard(
                        options.values.elementAt(index),
                        options.keys.elementAt(index),
                        weaklyMoney.values.elementAt(index - 1),
                        weaklyCount.values.elementAt(index - 1),
                      );
                    }
                  },
                  itemCount: weaklyMoney.length + 1,
                ),
              ),
              MyPie(upWeaklyIndex, downWeaklyIndex, weaklyIndex, weaklyTotalC,
                  weaklyTotalM, weaklyCount, weaklyMoney),
              Text(
                "In ${mounths[DateTime.now().month]} :",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return StatCard(
                        options.values.elementAt(index),
                        options.keys.elementAt(index),
                        monthlyTotalM.values.elementAt(index),
                        monthlyTotalC.values.elementAt(index),
                      );
                    } else {
                      return StatCard(
                        options.values.elementAt(index),
                        options.keys.elementAt(index),
                        monthlyMoney.values.elementAt(index - 1),
                        monthlyCount.values.elementAt(index - 1),
                      );
                    }
                  },
                  itemCount: weaklyMoney.length + 1,
                ),
              ),
              MyPie(upMonthlyIndex, downMonthlyIndex, monthlyIndex,
                  monthlyTotalC, monthlyTotalM, monthlyCount, monthlyMoney),
              Text(
                "In ${DateTime.now().year} :",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return StatCard(
                        options.values.elementAt(index),
                        options.keys.elementAt(index),
                        yearlyTotalM.values.elementAt(index),
                        yearlyTotalC.values.elementAt(index),
                      );
                    } else {
                      return StatCard(
                        options.values.elementAt(index),
                        options.keys.elementAt(index),
                        yearlyMoney.values.elementAt(index - 1),
                        yearlyCount.values.elementAt(index - 1),
                      );
                    }
                  },
                  itemCount: yearlyMoney.length + 1,
                ),
              ),
              MyPie(upYearlyIndex, downYearlyIndex, yearlyIndex, yearlyTotalC,
                  yearlyTotalM, yearlyCount, yearlyMoney),
            ],
          ),
        ),
      ),
    );
  }
}
