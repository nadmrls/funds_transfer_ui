import 'package:dashboard/utils/appcolor.dart';
import 'package:dashboard/widgets/bar_graph.dart';
import 'package:dashboard/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
  double? totalCreditAmount;
  double? totalDebitAmount;
  int? totalDebitCount;
  int? totalCreditCount;
  List<Map<String, dynamic>> transactions = [];
  List<String> narrativeValue = [];
  List<double> countTransac = [];

  @override
  void initState() {
    super.initState();
    fetchNarratives();
    fetchAllTransactions();
  }

  @override
  void dispose() {
    client.close(); // Clean up the client when not in use
    super.dispose();
  }

  Future<void> fetchAllTransactions() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:4000/transaction-count'));

      if (response.statusCode == 200) {
        List<dynamic> allTransactions = jsonDecode(response.body);
        setState(() {
          transactions = allTransactions
              .map((transaction) => {
                    'narrative': transaction['narrative'],
                    'count': transaction['count'],
                  })
              .toList()
              .cast<Map<String, dynamic>>();

          // Clear the lists before adding new data
          narrativeValue.clear();
          countTransac.clear();

          // Populate the narrativeValue and countTransac lists
          for (var transaction in transactions) {
            narrativeValue.add(transaction['narrative'] as String);
            countTransac.add(transaction['count'].toDouble());
          }
          isLoading = false;
        });
      } else {
        print('Failed to fetch transactions: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching transactions: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchNarratives() async {
    try {
      final response =
          await client.get(Uri.parse('http://127.0.0.1:4000/transactions'));

      if (response.statusCode == 200) {
        List<dynamic> allTransactions = jsonDecode(response.body);
        setState(() {
          narratives = allTransactions
              .map((transaction) => transaction['narrative'] as String)
              .toList();
          if (narratives.isNotEmpty) {
            dropdownValue = narratives.first;
            fetchTotalAmounts(dropdownValue!);
          }
          isLoading = false;
        });
      } else {
        print('Failed to fetch narratives: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching narratives: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchTotalAmounts(String narrative) async {
    await Future.wait([
      fetchTotalCreditAmount(narrative),
      fetchTotalDebitAmount(narrative),
      fetchTotalDebitCount(narrative),
      fetchTotalCreditCount(narrative),
    ]);
  }

  Future<void> fetchTotalCreditAmount(String narrative) async {
    try {
      final response = await client.get(Uri.parse(
          'http://127.0.0.1:4000/total-credit-amount?narrative=$narrative'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          totalCreditAmount = data['total_credit_amount'];
        });
      } else {
        print('Failed to fetch total credit amount: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching total credit amount: $error');
    }
  }

  Future<void> fetchTotalDebitAmount(String narrative) async {
    try {
      final response = await client.get(Uri.parse(
          'http://127.0.0.1:4000/total-debit-amount?narrative=$narrative'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          totalDebitAmount = data['total_debit_amount'];
        });
      } else {
        print('Failed to fetch total debit amount: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching total debit amount: $error');
    }
  }

  Future<void> fetchTotalDebitCount(String narrative) async {
    try {
      final response = await client.get(Uri.parse(
          'http://127.0.0.1:4000/transaction-count-debit?narrative=$narrative'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          totalDebitCount = data['count'];
        });
      } else {
        print('Failed to fetch total debit count: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching total debit count: $error');
    }
  }

  Future<void> fetchTotalCreditCount(String narrative) async {
    try {
      final response = await client.get(Uri.parse(
          'http://127.0.0.1:4000/transaction-count-credit?narrative=$narrative'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          totalCreditCount = data['count'];
        });
      } else {
        print('Failed to fetch total credit count: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching total credit count: $error');
    }
  }

  final DateTime today = DateTime.now();
  final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat("MMM. d, yyyy");
    final String todayLabel = dateFormat.format(today);
    final String yesterdayLabel = dateFormat.format(yesterday);
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
                            if (newValue != null) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                              fetchTotalAmounts(newValue);
                            }
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
              Row(
                children: [
                  Expanded(
                    child: CustomContainer(
                      todaylabel: todayLabel,
                      yesterdaylabel: yesterdayLabel,
                      title: 'Debit',
                      data_today: totalDebitAmount != null
                          ? totalDebitAmount.toString()
                          : 'Loading...',
                      data_yesterday: '300',
                      comment: 'Try comment',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomContainer(
                      todaylabel: todayLabel,
                      yesterdaylabel: yesterdayLabel,
                      title: 'Debit Counter',
                      data_today: totalDebitAmount != null
                          ? totalDebitAmount.toString()
                          : 'Loading...',
                      data_yesterday: '300',
                      comment: 'Try comment',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomContainer(
                      todaylabel: todayLabel,
                      yesterdaylabel: yesterdayLabel,
                      title: 'Credit',
                      data_today: totalDebitAmount != null
                          ? totalDebitAmount.toString()
                          : 'Loading...',
                      data_yesterday: '300',
                      comment: 'Try comment',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomContainer(
                      todaylabel: todayLabel,
                      yesterdaylabel: yesterdayLabel,
                      title: 'Credit Counter',
                      data_today: totalDebitAmount != null
                          ? totalDebitAmount.toString()
                          : 'Loading...',
                      data_yesterday: '300',
                      comment: 'Try comment',
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 550,
                child: BarGraph(
                  count: countTransac,
                  narratives: narrativeValue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
