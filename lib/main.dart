import 'package:flutter/material.dart';
import 'package:money/components/bottom_navigation_bar.dart';
import 'package:money/pages/mainpage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  openDatabase(
    join(await getDatabasesPath(), "Items.db"),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE items(id TEXT PRIMARY KEY, title TEXT, amount TEXT, time TEXT, category TEXT)',
      );
    },
    version: 1,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        'home': (context) => const MainApp(),
        "main": (context) => const BottomNavBar(),
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.black,
            toolbarTextStyle: TextStyle(color: Colors.cyan.shade500)),
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.cyan.shade600,
            // primary: mySetting.isEmpty
            //     ? Colors.cyan.shade600
            //     : themeColors[mySetting[0].colorNumber]!,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.black,
            error: Colors.black26,
            onError: Colors.black26,
            background: Colors.blue,
            onBackground: Colors.red.shade900,
            surface: Colors.green.shade600,
            onSurface: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.cyan.shade600,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.cyan.shade600,
            ),
          ),
          focusColor: Colors.cyan.shade600,
          labelStyle: TextStyle(color: Colors.cyan.shade600),
          fillColor: Colors.cyan.shade600,
        ),
        textTheme: TextTheme(
          bodySmall: TextStyle(color: Colors.cyan.shade600, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.cyan.shade600, fontSize: 16),
          bodyLarge: TextStyle(color: Colors.cyan.shade600, fontSize: 18),
          displayLarge: TextStyle(
              color: Colors.cyan.shade600,
              fontSize: 26,
              fontWeight: FontWeight.w500),
          displaySmall: TextStyle(
              color: Colors.cyan.shade600,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: MyMainPage(),
      ),
    );
  }
}
