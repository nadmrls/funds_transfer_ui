import 'package:dashboard/utils/appcolor.dart';
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
      backgroundColor: AppColors.mainscreenBG,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down,
                        color: Color.fromARGB(255, 123, 123, 123)),
                    dropdownColor: AppColors.primaryColor,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 123, 123, 123),
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
                  Expanded(
                      child: CustomContainer(
                    title: 'Debit',
                    data_today: '250',
                    data_yesterday: '300',
                    comment: 'try comment',
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: CustomContainer(
                    title: 'Credit',
                    data_today: '',
                    data_yesterday: '',
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: CustomContainer(
                    title: 'Counter',
                    data_today: '',
                    data_yesterday: '',
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 320,
                child: BarGraph(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Expanded(
                      child: CustomContainer(
                    title: '',
                    data_today: '',
                    data_yesterday: '',
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: CustomContainer(
                    title: '',
                    data_today: '',
                    data_yesterday: '',
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: CustomContainer(
                    title: '',
                    data_today: '',
                    data_yesterday: '',
                  )),
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
