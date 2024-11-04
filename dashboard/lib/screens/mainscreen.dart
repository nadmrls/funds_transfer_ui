import 'package:dashboard/utils/appcolor.dart';
import 'package:dashboard/widgets/bar_graph.dart';
import 'package:dashboard/widgets/custom_container.dart';
import 'package:dashboard/widgets/custom_container2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final http.Client client = http.Client();
  List<String> narratives = [];
  String? dropdownValue;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNarratives();
  }

  Future<void> fetchNarratives() async {
    try {
      final response =
          await client.get(Uri.parse('http://127.0.0.1:4000/transactions'));

      if (response.statusCode == 200) {
        List<dynamic> allTransactions = jsonDecode(response.body);
        setState(() {
          // Extract narratives from the response
          narratives = allTransactions
              .map((transaction) => transaction['narrative'] as String)
              .toList();
          // Set the first item as the default dropdown value if available
          if (narratives.isNotEmpty) {
            dropdownValue = narratives.first;
          }
          isLoading = false;
        });
      } else {
        print('Failed to fetch narratives: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching narratives: $error');
    }
  }

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
                padding: EdgeInsets.symmetric(horizontal: isLoading ? 0 : 10),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 48.0,
                          width: 230,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      )
                    : DropdownButtonHideUnderline(
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
                          items: narratives
                              .map<DropdownMenuItem<String>>((String value) {
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
                  // Expanded(
                  //     child: CustomContainer2(
                  //   title: 'Counter',
                  //   data_today: 'data1',
                  //   data_yesterday: 'data2',
                  // )),
                  Expanded(
                      child: CustomContainer(
                    title: 'Credit Counter',
                    data_today: '',
                    data_yesterday: '',
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: CustomContainer(
                    title: 'Debit Counter',
                    data_today: '',
                    data_yesterday: '',
                  )),
                  const SizedBox(width: 20),
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
