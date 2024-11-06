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
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: narratives.length * 110,
              height: 400,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    horizontalInterval:
                        _getInterval(count), // Interval for horizontal lines
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.5),
                        strokeWidth: 1,
                      );
                    },
                    drawVerticalLine: true,
                    verticalInterval: 1, // Interval for vertical lines
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withOpacity(0.5),
                        strokeWidth: 1,
                      );
                    },
                  ),
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
                                  overflow: TextOverflow.ellipsis,
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
                    int index = entry.key;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value,
                          color: index % 2 == 0
                              ? const Color.fromARGB(
                                  255, 42, 77, 124) // Color 1
                              : const Color.fromARGB(
                                  255, 74, 138, 191), // Color 2
                          width: 30,
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
    if (counts.isEmpty) return 20000;
    double maxCount = counts.reduce((a, b) => a > b ? a : b);
    return ((maxCount ~/ 20000) + 1) * 20000;
  }

  double _getInterval(List<double> counts) {
    double maxY = _getMaxY(counts);
    return maxY / 10;
  }
}
