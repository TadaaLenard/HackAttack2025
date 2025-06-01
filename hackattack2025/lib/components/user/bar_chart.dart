// bar_chart_component.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartComponent extends StatelessWidget {
  final List<double> values;
  final List<String> labels;

  const BarChartComponent({
    super.key,
    required this.values,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16.0), // Top padding inside scroll view
        child: SizedBox(
          width: values.length * 80,
          height: 300,
          child: BarChart(
            BarChartData(
              maxY: (values.reduce((a, b) => a > b ? a : b)) +
                  5, // Set Y-axis max 10 units above max value
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 28,
                    getTitlesWidget: (value, _) {
                      if (value.toInt() >= labels.length) return const Text('');
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          labels[value.toInt()],
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 5,
                    getTitlesWidget: (value, _) => Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                    reservedSize: 28,
                  ),
                ),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              barGroups: List.generate(values.length, (index) {
                final color = values[index] <= 20 ? Colors.green : Colors.red;
                return BarChartGroupData(x: index, barRods: [
                  BarChartRodData(
                    toY: values[index],
                    color: color,
                    width: 20,
                    borderRadius: BorderRadius.circular(4),
                  )
                ]);
              }),
            ),
          ),
        ),
      ),
    );
  }
}
