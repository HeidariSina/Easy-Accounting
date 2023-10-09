import 'package:flutter/material.dart';
import '../sideComponents/item_card.dart';
import '../class/items.dart';
import '../class/data.dart';

class AllPage extends StatefulWidget {
  const AllPage({super.key});

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  List<Items> allItems = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var iiiii = await items();
    super.setState(() {
      allItems = iiiii;
    });
  }

  void deleteButtonPressed(String id) {
    setState(() {
      deleteItem(id);
      allItems.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var mounth = now.month;
    var year = now.year;
    List<Widget> myWid = [];
    allItems.sort((a, b) => a.time.compareTo(b.time));

    if (allItems.isNotEmpty) {
      myWid.add(
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Text(
            '${mounths[now.month]} ${now.year} :',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
      for (var item in allItems.reversed) {
        if (DateTime.parse(item.time).month == mounth &&
            DateTime.parse(item.time).year == year) {
          myWid.add(ItemCard(item, deleteButtonPressed));
        } else {
          mounth = mounth - 1;
          if (mounth == 0) {
            mounth = 12;
            year = year - 1;
          }
          while (DateTime.parse(item.time).month != mounth ||
              DateTime.parse(item.time).year != year) {
            mounth = mounth - 1;
            if (mounth == 0) {
              mounth = 12;
              year = year - 1;
            }
          }
          myWid.add(
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Text(
                '${mounths[mounth]} $year :',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
          myWid.add(ItemCard(item, deleteButtonPressed));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "All Transactions",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        color: Theme.of(context).colorScheme.onSurface,
        child: Column(
          children: [
            ...myWid,
          ],
        ),
      ),
    );
  }
}
