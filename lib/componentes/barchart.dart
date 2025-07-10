import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class BarChartSample extends StatelessWidget {
  final Map<String, double> groupedItems;

  BarChartSample(this.groupedItems);

  @override
  Widget build(BuildContext context) {
    
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (valor, meta) {
                if (valor.isFinite && valor >= 0 && valor < groupedItems.keys.length) {
                  final name = groupedItems.keys.elementAt(valor.toInt());
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 12),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (valor, meta) {
                return Text('${valor.toInt()}');
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: groupedItems.entries.map((entry) {
          final index = groupedItems.keys.toList().indexOf(entry.key);
          double value = entry.value.isFinite ? entry.value : 0.0;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: value,
                color: Colors.blue,
                width: 20,
              ),
            ],
          );
        }).toList(),
        minY: 0,
        maxY: groupedItems.values.reduce((a, b) => a > b ? a : b) + 10,
      ),
    );
  }
}

late final Map<String, double> groupedItems = {
  'A': 10.0,
  'B': 20.0,
  'C': 30.0,
  'D': 40.0,
};
