import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarGraph extends StatelessWidget {
  final List<double> count = [150, 170, 165, 241, 215, 180, 622, 1582];

  BarGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: MonthlySalesBarChart(count: count),
          ),
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 6000,
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 500, // Set interval for Y-axis labels
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
                reservedSize: 32,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  );
                  switch (value.toInt()) {
                    case 0:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('Jan', style: style));
                    case 1:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('Feb', style: style));
                    case 2:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('Mar', style: style));
                    case 3:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('Apr', style: style));
                    case 4:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('May', style: style));
                    case 5:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('Jun', style: style));
                    case 6:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('Jul', style: style));
                    case 7:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('Aug', style: style));
                    case 8:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('Sep', style: style));
                    case 9:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('Oct', style: style));
                    case 10:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('Nov', style: style));
                    case 11:
                      return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: const Text('Dec', style: style));
                    default:
                      return const SizedBox.shrink();
                  }
                },
                interval: 1, // Show one label per month
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
                  color: Colors.red,
                  width: 20, // Set the width of the bars
                ),
              ],
            );
          }).toList(),
          minY: 0, // Set a fixed minimum value for Y axis
          maxY: 3000, // Set a fixed maximum value for Y axis
        ),
      ),
    );
  }
}
