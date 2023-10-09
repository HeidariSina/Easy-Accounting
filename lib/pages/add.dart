import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../class/items.dart';

List<String> dropCate = <String>[
  "Eating",
  "Clothes",
  "Games",
  "Education",
  "Home",
  "Travel",
  "Others",
];

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var uuid = const Uuid();
  final amountController = TextEditingController();
  final textController = TextEditingController();
  String dropdownValue = dropCate.first;

  DateTime selectedDate = DateTime.now();
  String datte = "Select Date";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        datte = DateFormat("yyyy/MM/dd").format(selectedDate);
      });
    }
  }

  void addNewTrans() async {
    if (textController.text == "" ||
        amountController.text == "" ||
        datte == "Select Date") {
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
      final item = Items(
        time: selectedDate.toString(),
        id: uuid.v1(),
        title: textController.text,
        amount: amountController.text,
        category: dropdownValue,
      );
      await insertItems(item);
      amountController.text = "";
      textController.text = "";
      setState(() {
        datte = "Select Date";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add New Transaction",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: Theme.of(context).colorScheme.onSecondary,
        child: Column(children: [
          TextField(
            controller: textController,
            style: Theme.of(context).textTheme.bodySmall,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Enter The Title',
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: amountController,
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: const InputDecoration(
              labelText: 'Enter The Amount',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 40,
                margin: const EdgeInsets.only(top: 30, bottom: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
                  ),
                  child: Text(
                    datte,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width * 0.4,
                child: DropdownButton(
                  dropdownColor: Colors.black87,
                  isDense: false,
                  isExpanded: true,
                  underline: Container(
                    height: 2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  icon: Icon(
                    Icons.arrow_downward,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                  items: dropCate.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  value: dropdownValue,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary),
              onPressed: () {
                FocusScope.of(context).unfocus();
                addNewTrans();
              },
              icon: const Icon(Icons.check),
              label: const Text("Submit"),
            ),
          )
        ]),
      ),
    );
  }
}
