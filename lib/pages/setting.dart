import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Setting",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
