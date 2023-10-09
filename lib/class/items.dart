import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Items {
  String id;
  String title;
  String amount;
  String time;
  String category;

  Items({
    required this.id,
    required this.title,
    required this.amount,
    required this.time,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'time': time,
      'category': category,
    };
  }
}

Future<void> insertItems(Items item) async {
  final db = await openDatabase(
    join(await getDatabasesPath(), "Items.db"),
    version: 1,
  );
  await db.insert(
    'items',
    item.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Items>> items() async {
  // Get a reference to the database.
  final db = await openDatabase(
    join(await getDatabasesPath(), "Items.db"),
    version: 1,
  );
  final List<Map<String, dynamic>> maps = await db.query('items');
  return List.generate(maps.length, (i) {
    return Items(
      id: maps[i]['id'],
      title: maps[i]['title'],
      time: maps[i]['time'],
      amount: maps[i]['amount'],
      category: maps[i]['category'],
    );
  });
}

Future<void> updateItems(Items item) async {
  // Get a reference to the database.
  final db = await openDatabase(
    join(await getDatabasesPath(), "Items.db"),
    version: 1,
  );

  // Update the given Dog.
  await db.update(
    'items',
    item.toMap(),
    where: 'id = ?',
    whereArgs: [item.id],
  );
}

Future<void> deleteItem(String id) async {
  final db = await openDatabase(
    join(await getDatabasesPath(), "Items.db"),
    version: 1,
  );
  await db.delete(
    'items',
    where: 'id = ?',
    whereArgs: [id],
  );
}
