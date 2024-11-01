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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.black,
                  size: 30,
                ),
                elevation: 16,
                style:
                    const TextStyle(color: Color.fromARGB(255, 43, 122, 217)),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
            ],
          ),
        ),
      ),
    );
  }
}
