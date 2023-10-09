import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:money/pages/second.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool _textComes = false;
  bool _buttomcomes = false;
  double opacity = 1;
  double opacity2 = 1;
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Future.delayed(const Duration(milliseconds: 20), () {
        setState(() {
          opacity = 0;
        });
      });
      setState(() {
        _textComes = true;
      });
    });
    Timer(const Duration(seconds: 4), () {
      Future.delayed(const Duration(milliseconds: 20), () {
        setState(() {
          opacity2 = 0;
        });
      });
      setState(() {
        _buttomcomes = true;
      });
    });
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buttomcomes
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: AnimatedOpacity(
                opacity: opacity2 == 1 ? 0 : 1,
                duration: const Duration(milliseconds: 500),
                child: ElevatedButton(
                  onPressed: () {
                    Route route = PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SecondPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;

                          final tween = Tween(begin: begin, end: end);
                          final curvedAnimation = CurvedAnimation(
                            parent: animation,
                            curve: curve,
                          );

                          return SlideTransition(
                            position: tween.animate(curvedAnimation),
                            child: child,
                          );
                        });
                    Navigator.of(context).push(route);
                  },
                  child: const Text(
                    "Let's GO",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
          : Container(),
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 30,
          left: 15,
          right: 15,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    TyperAnimatedText(
                      'Welcome To Easy Accounting',
                      textStyle: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      // duration: const Duration(milliseconds: 1500),
                    ),
                  ],
                ),
                _textComes
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 5,
                        ),
                        child: AnimatedOpacity(
                          opacity: opacity == 1 ? 0 : 1,
                          duration: const Duration(milliseconds: 1500),
                          child: const Text(
                            'In this app you can easily manage your outcomes and the things that you spending your money on, there are 7 categories that you can organize your expenses.\n\nThe data will be categorize in daily, weakly, monthly and yearly timing and for your convenience, we put your data in Charts like Barchart, Piechart and Linechart',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
