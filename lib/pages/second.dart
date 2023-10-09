import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money/class/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final nameController = TextEditingController();
  final incomeController = TextEditingController();
  String iconNumber = "0";
  String colorNumber = "0";

  addSetting() async {
    if (nameController.text == "" ||
        incomeController.text == "" ||
        double.parse(incomeController.text) < 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            iconColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            title: Text(
              "Invalid Input",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            icon: const Icon(Icons.warning_amber_outlined),
            content: Text(
              "Some of Your Input are Invalid Or Empty",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', nameController.text);
      await prefs.setDouble('income', double.parse(incomeController.text));
      await prefs.setString("iconNumber", iconNumber);
      Navigator.pushReplacementNamed(context, 'main');
      return Future.value(false);
    }
  }

  void changeColorTheme() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          title: Text(
            "Choose Your Color",
            style: TextStyle(color: themeColors[colorNumber]!),
          ),
          content: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: themeColors.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsetsDirectional.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: themeColors[index.toString()]!,
                  ),
                  margin: const EdgeInsets.all(5),
                  child: TextButton(
                    key: Key(index.toString()),
                    onPressed: () {
                      setState(() {
                        colorNumber = index.toString();
                      });
                      Navigator.of(context).pop();
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: themeColors[colorNumber]!),
              ),
            ),
          ],
        );
      },
    );
  }

  void changeIcon() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          title: Text(
            "Choose Your Icon",
            style: TextStyle(color: themeColors[colorNumber]!),
          ),
          content: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: icons.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 75,
                  height: 75,
                  padding: const EdgeInsetsDirectional.all(0),
                  margin: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        iconNumber = index.toString();
                      });
                      Navigator.of(context).pop();
                      FocusScope.of(context).unfocus();
                    },
                    child: Image.asset(
                      icons[index.toString()]!,
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: themeColors[colorNumber]!),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(color: themeColors[colorNumber]!),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: themeColors[colorNumber]!,
          ),
          onPressed: () async {
            FocusScope.of(context).unfocus();
            addSetting();
          },
          child: const Text(
            "Start",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 30,
          left: 20,
          right: 20,
        ),
        color: Theme.of(context).colorScheme.onSurface,
        width: MediaQuery.of(context).size.width,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              maxHeight: double.infinity,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "We Just Need Some Basic Information",
                    style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: themeColors[colorNumber]!,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        color: themeColors[colorNumber]!, fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'Your Name',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: themeColors[colorNumber]!,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: themeColors[colorNumber]!,
                        ),
                      ),
                      focusColor: themeColors[colorNumber]!,
                      labelStyle: TextStyle(color: themeColors[colorNumber]!),
                      fillColor: themeColors[colorNumber]!,
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: incomeController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: themeColors[colorNumber]!, fontSize: 16),
                    decoration: InputDecoration(
                      labelText: 'Your Income',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: themeColors[colorNumber]!,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: themeColors[colorNumber]!,
                        ),
                      ),
                      focusColor: themeColors[colorNumber]!,
                      labelStyle: TextStyle(color: themeColors[colorNumber]!),
                      fillColor: themeColors[colorNumber]!,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Your Icon",
                            style: TextStyle(
                                fontSize: 20, color: themeColors[colorNumber]!),
                          ),
                          Container(
                            width: 65,
                            height: 65,
                            padding: const EdgeInsetsDirectional.all(0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: themeColors[colorNumber]!),
                            ),
                            margin: const EdgeInsets.only(top: 10),
                            child: TextButton(
                              onPressed: changeIcon,
                              child: Image.asset(
                                icons[iconNumber]!,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Column(
                      //   children: [
                      //     Text(
                      //       "Color Theme",
                      //       style: TextStyle(
                      //           fontSize: 20, color: themeColors[colorNumber]!),
                      //     ),
                      //     Container(
                      //       width: 65,
                      //       height: 65,
                      //       padding: const EdgeInsetsDirectional.all(0),
                      //       decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(100),
                      //         color: themeColors[colorNumber]!,
                      //       ),
                      //       margin: const EdgeInsets.only(top: 10),
                      //       child: TextButton(
                      //         onPressed: changeColorTheme,
                      //         child: Container(),
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
