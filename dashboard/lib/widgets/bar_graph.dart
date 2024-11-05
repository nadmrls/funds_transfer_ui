import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarGraph extends StatelessWidget {
  final List<double> count;
  final List<String> narratives;

  BarGraph({super.key, required this.count, required this.narratives});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: MonthlySalesBarChart(
            count: count,
            narratives: narratives,
          ),
        ),
      ),
    );
  }
}

class MonthlySalesBarChart extends StatelessWidget {
  final List<double> count;
  final List<String> narratives;

  const MonthlySalesBarChart({
    super.key,
    required this.count,
    required this.narratives,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: narratives.length * 80.0, // Adjust width for each bar
              height: 900,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: _getInterval(count),
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
                        reservedSize: 60,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                          );

                          int index = value.toInt();
                          if (index >= 0 && index < narratives.length) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: SizedBox(
                                width: 60, // Set fixed width for stacked text
                                child: Text(
                                  narratives[index],
                                  style: style,
                                  textAlign: TextAlign.center,
                                  softWrap: true, // Enable wrapping
                                  maxLines: 3, // Limit to 2 lines if needed
                                  overflow: TextOverflow
                                      .ellipsis, // Add ellipsis if too long
                                ),
                              ),
                            );
                          } else {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: const Text(''),
                            );
                          }
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
                  maxY: _getMaxY(count),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _getMaxY(List<double> counts) {
    if (counts.isEmpty) return 10000;
    double maxCount = counts.reduce((a, b) => a > b ? a : b);
    return ((maxCount ~/ 10000) + 1) * 10000;
  }

  double _getInterval(List<double> counts) {
    double maxY = _getMaxY(counts);
    return maxY / 10;
  }
}
