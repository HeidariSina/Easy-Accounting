import 'package:flutter/material.dart';
import '../class/items.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ItemCard extends StatelessWidget {
  final Items item;
  final Function func;
  ItemCard(this.item, this.func, {super.key});
  IconData myIcon = Icons.attach_money;

  @override
  Widget build(BuildContext context) {
    if (item.category == "Eating") {
      myIcon = Icons.fastfood_rounded;
    } else if (item.category == "Clothes") {
      myIcon = Icons.shopping_bag;
    } else if (item.category == "Games") {
      myIcon = Icons.sports_esports;
    } else if (item.category == "Education") {
      myIcon = Icons.biotech;
    } else if (item.category == "Home") {
      myIcon = Icons.cottage;
    } else if (item.category == "Travel") {
      myIcon = Icons.train;
    } else if (item.category == "Others") {
      myIcon = Icons.question_mark;
    }
    var date = DateTime.parse(item.time);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(0, 0, 0, 0),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                myIcon,
                color: Theme.of(context).colorScheme.primary,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      DateFormat("EEEE/dd").format(date),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Text(
                '€${item.amount}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            iconColor: Theme.of(context).colorScheme.primary,
                            backgroundColor:
                                Theme.of(context).colorScheme.onSurface,
                            icon: const Icon(Icons.delete_outline),
                            content: Text(
                              "Delete This Transaction?",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancle"),
                              ),
                              TextButton(
                                onPressed: () {
                                  func(item.id);
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 20,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
