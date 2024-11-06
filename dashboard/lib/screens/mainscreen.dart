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
  double totalCreditAmountYes = 0.0;
  double totalDebitAmountYes = 0.0;
  int? totalDebitCount;
  int? totalCreditCount;
  int totalDebitCountYes = 0;
  int totalCreditCountYes = 0;
  List<Map<String, dynamic>> transactions = [];
  List<String> narrativeValue = [];
  List<double> countTransac = [];

  bool isHigher = true;
  bool isHigher2 = true;
  bool isHigher3 = true;
  bool isHigher4 = true;

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
      fetchTotalDebitCountYesterday(narrative),
      fetchTotalCreditCountYesterday(narrative),
      fetchTotalCreditAmountYesterday(narrative),
      fetchTotalDebitAmountYesterday(narrative)
    ]);

    // After fetching the totals, compare and set the isHigher flags
    setState(() {
      isHigher =
          (totalDebitAmount != null && totalDebitAmount! > totalDebitAmountYes);
      isHigher2 = (totalCreditAmount != null &&
          totalCreditAmount! > totalCreditAmountYes);
      isHigher3 =
          (totalCreditCount != null && totalCreditCount! > totalCreditCountYes);
      isHigher4 =
          (totalDebitCount != null && totalDebitCount! > totalDebitCountYes);
    });
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

  Future<void> fetchTotalCreditAmountYesterday(String narrative) async {
    try {
      final response = await client.get(Uri.parse(
          'http://127.0.0.1:4000/total-credit-amount-yesterday?narrative=$narrative'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          totalCreditAmountYes = data['total_credit_amount'];
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

  Future<void> fetchTotalDebitAmountYesterday(String narrative) async {
    try {
      final response = await client.get(Uri.parse(
          'http://127.0.0.1:4000/total-debit-amount-yesterday?narrative=$narrative'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          totalDebitAmountYes = data['total_debit_amount'];
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

  Future<void> fetchTotalDebitCountYesterday(String narrative) async {
    try {
      final response = await client.get(Uri.parse(
          'http://127.0.0.1:4000/transaction-count-debit-yesterday?narrative=$narrative'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          totalDebitCountYes = data['count'];
        });
      } else {
        print('Failed to fetch total debit count: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching total debit count: $error');
    }
  }

  Future<void> fetchTotalCreditCountYesterday(String narrative) async {
    try {
      final response = await client.get(Uri.parse(
          'http://127.0.0.1:4000/transaction-count-credit-yesterday?narrative=$narrative'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          totalCreditCountYes = data['count'];
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
    final DateFormat dateFormat = DateFormat("MMMM d, yyyy");
    final String todayLabel = dateFormat.format(today);
    final String yesterdayLabel = dateFormat.format(yesterday);
    return Scaffold(
      backgroundColor: AppColors.mainscreenBG,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 40,
              color: const Color.fromARGB(255, 42, 77, 124),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: isLoading ? 0 : 10),
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
                              items: narratives.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(builder: (context, constraints) {
                    bool isWideScreen = constraints.maxWidth >= 950;
                    double containerWidth = isWideScreen
                        ? constraints.maxWidth * 1.0
                        : constraints.maxWidth * 1.3;
                    double containerHeight = isWideScreen ? 200.0 : 400.0;
                    return Container(
                        height: containerHeight,
                        width: containerWidth,
                        child: isWideScreen
                            ? Row(
                                children: [
                                  Expanded(
                                    child: CustomContainer(
                                        todayLabel: todayLabel,
                                        yesterdayLabel: yesterdayLabel,
                                        background: const Color.fromARGB(
                                            255, 90, 167, 195),
                                        test: isHigher,
                                        title: 'Debit',
                                        data_today: totalDebitAmount != null
                                            ? '₱ ${NumberFormat('#,##0.00').format(totalDebitAmount)}'
                                            : 'Loading...',
                                        data_yesterday: totalDebitAmountYes !=
                                                null
                                            ? '₱ ${NumberFormat('#,##0.00').format(totalDebitAmountYes)}'
                                            : 'Loading...',
                                        titleIcon: Icon(
                                          Icons.remove_circle,
                                          color: const Color.fromARGB(
                                              255, 42, 77, 124),
                                        )),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: CustomContainer(
                                        todayLabel: todayLabel,
                                        yesterdayLabel: yesterdayLabel,
                                        background:
                                            Color.fromARGB(255, 90, 195, 129),
                                        test: isHigher2,
                                        title: 'Credit',
                                        data_today: totalCreditAmount != null
                                            ? '₱ ${NumberFormat('#,##0.00').format(totalCreditAmount)}'
                                            : 'Loading...',
                                        data_yesterday: totalCreditAmountYes !=
                                                null
                                            ? '₱ ${NumberFormat('#,##0.00').format(totalCreditAmountYes)}'
                                            : 'Loading...',
                                        titleIcon: Icon(
                                          Icons.add_circle,
                                          color: const Color.fromARGB(
                                              255, 42, 77, 124),
                                        )),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: CustomContainer(
                                      todayLabel: todayLabel,
                                      yesterdayLabel: yesterdayLabel,
                                      background: const Color.fromARGB(
                                          255, 104, 189, 162),
                                      test: isHigher4,
                                      title: 'Debit Counter',
                                      data_today: totalDebitCount != null
                                          ? NumberFormat('#,##0')
                                              .format(totalDebitCount)
                                          : 'Loading...',
                                      data_yesterday: totalDebitCountYes != null
                                          ? NumberFormat('#,##0')
                                              .format(totalDebitCountYes)
                                          : 'Loading...',
                                      titleIcon: Icon(
                                        Icons.format_list_numbered,
                                        color: const Color.fromARGB(
                                            255, 42, 77, 124),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: CustomContainer(
                                        todayLabel: todayLabel,
                                        yesterdayLabel: yesterdayLabel,
                                        background: const Color.fromARGB(
                                            255, 82, 153, 212),
                                        test: isHigher3,
                                        title: 'Credit Counter',
                                        data_today: totalCreditCount != null
                                            ? NumberFormat('#,##0')
                                                .format(totalCreditCount)
                                            : 'Loading...',
                                        data_yesterday:
                                            totalCreditCountYes != null
                                                ? NumberFormat('#,##0')
                                                    .format(totalCreditCountYes)
                                                : 'Loading...',
                                        titleIcon: Icon(
                                          Icons.check_circle,
                                          color: const Color.fromARGB(
                                              255, 42, 77, 124),
                                        )),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomContainer(
                                            todayLabel: todayLabel,
                                            yesterdayLabel: yesterdayLabel,
                                            background: const Color.fromARGB(
                                                255, 90, 167, 195),
                                            test: isHigher,
                                            title: 'Debit',
                                            data_today: totalDebitAmount != null
                                                ? '₱ ${NumberFormat('#,##0.00').format(totalDebitAmount)}'
                                                : 'Loading...',
                                            data_yesterday: totalDebitAmountYes !=
                                                    null
                                                ? '₱ ${NumberFormat('#,##0.00').format(totalDebitAmountYes)}'
                                                : 'Loading...',
                                            titleIcon: Icon(
                                              Icons.remove_circle,
                                              color: const Color.fromARGB(
                                                  255, 42, 77, 124),
                                            )),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: CustomContainer(
                                            todayLabel: todayLabel,
                                            yesterdayLabel: yesterdayLabel,
                                            background: Color.fromARGB(
                                                255, 90, 195, 129),
                                            test: isHigher2,
                                            title: 'Credit',
                                            data_today: totalCreditAmount !=
                                                    null
                                                ? '₱ ${NumberFormat('#,##0.00').format(totalCreditAmount)}'
                                                : 'Loading...',
                                            data_yesterday: totalCreditAmountYes !=
                                                    null
                                                ? '₱ ${NumberFormat('#,##0.00').format(totalCreditAmountYes)}'
                                                : 'Loading...',
                                            titleIcon: Icon(
                                              Icons.add_circle,
                                              color: const Color.fromARGB(
                                                  255, 42, 77, 124),
                                            )),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomContainer(
                                          todayLabel: todayLabel,
                                          yesterdayLabel: yesterdayLabel,
                                          background: const Color.fromARGB(
                                              255, 104, 189, 162),
                                          test: isHigher4,
                                          title: 'Debit Counter',
                                          data_today: totalDebitCount != null
                                              ? NumberFormat('#,##0')
                                                  .format(totalDebitCount)
                                              : 'Loading...',
                                          data_yesterday: totalDebitCountYes != null
                                              ? NumberFormat('#,##0')
                                                  .format(totalDebitCountYes)
                                              : 'Loading...',
                                          titleIcon: Icon(
                                            Icons.format_list_numbered,
                                            color: const Color.fromARGB(
                                                255, 42, 77, 124),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: CustomContainer(
                                            todayLabel: todayLabel,
                                            yesterdayLabel: yesterdayLabel,
                                            background: const Color.fromARGB(
                                                255, 82, 153, 212),
                                            test: isHigher3,
                                            title: 'Credit Counter',
                                            data_today: totalCreditCount != null
                                                ? NumberFormat('#,##0')
                                                .format(totalCreditCount)
                                                : 'Loading...',
                                            data_yesterday:
                                            totalCreditCountYes != null
                                                ? NumberFormat('#,##0')
                                                .format(totalCreditCountYes)
                                                : 'Loading...',
                                            titleIcon: Icon(
                                              Icons.check_circle,
                                              color: const Color.fromARGB(
                                                  255, 42, 77, 124),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ));
                  }),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border(
                            top: BorderSide(color: Colors.grey),
                            left: BorderSide(color: Colors.grey),
                            right: BorderSide(color: Colors.grey),
                            bottom: BorderSide.none, // No border on the bottom
                          ),
                        ),
                        height: 40,
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(
                              Icons.bar_chart_outlined,
                              color: Colors.grey[700],
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Bar Chart',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(color: Colors.grey, width: 1)),
                        width: double.infinity,
                        height: 450,
                        child: BarGraph(
                          count: countTransac,
                          narratives: narrativeValue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
