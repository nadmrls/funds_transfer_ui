import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarGraph extends StatelessWidget {
  final List<double> count = [
    150,
    170,
    165,
    241,
    215,
    180,
    622,
    1582,
    200,
    300,
    250,
    350,
    400,
    450,
    500,
    550,
    600,
    700,
  ];

  BarGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: MonthlySalesBarChart(count: count),
        ),
      ),
    );
  }
}

class MonthlySalesBarChart extends StatelessWidget {
  final List<double> count;

  const MonthlySalesBarChart({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: 400,
          child: BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 500,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      );
                      return Text('${value.toInt()}', style: style);
                    },
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize:
                        50, // Increase reserved size for bottom titles
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 9, // Keep font size smaller
                      );
                      List<String> titles = [
                        'Cash',
                        'Commission Fee',
                        'Fund Transfer',
                        'IBFT INCOMING\nRIZAL Bank',
                        'IBFT OUTGOING',
                        'K2C Cash In',
                        'K2C Cash Out',
                        'K2C Payment\nBill',
                        'K2C Purchase\nLoad',
                        'K2C Transfer',
                        'Loan Payment',
                        'MBA Payment',
                        'Mobile Collect',
                        'Transaction fee\nfor CO118523',
                        'Transaction fee\nfor CO119459',
                        'Transaction fee\nfor CO119491',
                        'Transaction fee\nfor CO119604',
                        'trx SBS Fund\nTra',
                      ];
                      String title = titles[value.toInt()];

                      // Wrap title in a Column to allow multi-line
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: title.split('\n').map((line) {
                            return Text(line, style: style);
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: false,
                border: Border.all(color: Colors.grey, width: 1),
              ),
              barGroups: count.asMap().entries.map((entry) {
                return BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      width: 15,
                      borderRadius: BorderRadius.zero,
                    ),
                  ],
                );
              }).toList(),
              minY: 0,
              maxY: 2000,
            ),
          ),
        );
      },
    );
  }
}
