import 'package:coffee_admin/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
//import 'package:collection/collection.dart';
//import 'package:intl/intl.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chartData = context
        .read<FirestoreService>()
        .getCoffeeshopStampsHistory()
        .map((stamp) => BarChartRodData(
            y: stamp.count.toDouble(),
            width: 30,
            colors: [Colors.blueGrey.shade400]))
        .take(7)
        .toList();

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: Colors.white,
      child: BarChart(
        BarChartData(
            maxY: 80,
            minY: 0,
            alignment: BarChartAlignment.center,
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (value) => value % 10 == 0,
              getDrawingHorizontalLine: (value) => FlLine(
                color: const Color(0xffe7e8ec),
                strokeWidth: 1,
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: SideTitles(
                showTitles: true,
                interval: 10,
                //checkToShowTitle: (d1, d2, titles, d3, d4) => true),
              ),
            ),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: chartData,
              )
            ]),
      ),
    );
  }
}

// final Map<String, List<Stamp>> stampsByMonth =
//     groupBy(stampsHistory, (obj) => DateFormat.MMM().format(obj.date));

// final fooo = stampsByMonth.map(
//   (month, stampsPerDay) => MapEntry(
//     month,
//     BarChartGroupData(
//       x: stampsPerDay[0].date.year * 10 + stampsPerDay[0].date.month,
//       barRods: stampsPerDay
//           .map(
//             (stampsByDay) => BarChartRodData(
//                 y: stampsByDay.count.toDouble(), colors: [Colors.brown]),
//           )
//           .toList(),
//     ),
//   ),
// );
