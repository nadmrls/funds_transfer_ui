import 'package:dashboard/widgets/bar_graph.dart';
import 'package:dashboard/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  String dropdownValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, // Background color of dropdown
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down,
                        color: Colors.deepPurple),
                    dropdownColor:
                        Colors.white, // Dropdown menu background color
                    style: const TextStyle(
                      color: Colors.deepPurple, // Text color
                      fontWeight: FontWeight.bold,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      'Option 1',
                      'Option 2',
                      'Option 3',
                      'Option 4'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Expanded(child: CustomContainer(background: Colors.red)),
                  const SizedBox(width: 20),
                  Expanded(child: CustomContainer(background: Colors.blue)),
                  const SizedBox(width: 20),
                  Expanded(child: CustomContainer(background: Colors.green)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 500,
                child: BarGraph(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Expanded(child: CustomContainer(background: Colors.red)),
                  const SizedBox(width: 20),
                  Expanded(child: CustomContainer(background: Colors.blue)),
                  const SizedBox(width: 20),
                  Expanded(child: CustomContainer(background: Colors.green)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.red,
                width: double.infinity,
                height: 500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
