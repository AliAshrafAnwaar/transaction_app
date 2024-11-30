import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:intl/intl.dart';

late List<DateTime> sortedDates;
DateFormat dateFormatter = DateFormat('dd/MM/yy', 'ar'); // Arabic date format

class AdminPage extends StatelessWidget {
  Map<DateTime, double> groupTransactionsByDate(
      List<Transaction> transactions) {
    Map<DateTime, double> groupedData = {};

    // Get the current date and calculate the start date for the last 7 days
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    for (var transaction in transactions) {
      // Include only transactions within the last 7 days
      if (transaction.time.isAfter(sevenDaysAgo) &&
              transaction.time.isBefore(now) ||
          transaction.time.isAtSameMomentAs(now)) {
        // Round the date to remove time information (consider only the day)
        final date = DateTime(transaction.time.year, transaction.time.month,
            transaction.time.day);
        groupedData[date] = (groupedData[date] ?? 0) + transaction.amount;
      }
    }

    return groupedData;
  }

  List<BarChartGroupData> prepareBarChartData(
      Map<DateTime, double> groupedData) {
    sortedDates = groupedData.keys.toList()..sort();

    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < sortedDates.length; i++) {
      final date = sortedDates[i];
      final total = groupedData[date]!;

      barGroups.add(
        BarChartGroupData(
          x: i, // The index represents the x-axis position
          barRods: [
            BarChartRodData(
              width: 40,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              toY: total, // Total transaction amount as the height of the bar
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.purple],
              ),
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  double getDeviceWidth() {
    final size = WidgetsBinding.instance.window.physicalSize;
    return size.width / WidgetsBinding.instance.window.devicePixelRatio;
  }

  double getDeviceHeight() {
    final size = WidgetsBinding.instance.window.physicalSize;
    return size.height / WidgetsBinding.instance.window.devicePixelRatio;
  }

  double totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    Map<DateTime, double> groupedData =
        groupTransactionsByDate(allTransactions);
    List<BarChartGroupData> chartData = prepareBarChartData(groupedData);

    for (var transaction in allTransactions) {
      totalAmount += transaction.amount;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: getDeviceWidth() / 2, maxWidth: getDeviceWidth()),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BarChart(
          BarChartData(
            barGroups: chartData,
            groupsSpace: 35,
            alignment: BarChartAlignment.center,
            titlesData: FlTitlesData(
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 50, // Adjust space as needed
                  getTitlesWidget: (value, meta) {
                    // Convert the number to Arabic numerals
                    final englishToArabicNumbers =
                        '${value.toInt().toString().split('').map((char) {
                      final asciiValue = char.codeUnitAt(0);
                      if (asciiValue >= 48 && asciiValue <= 57) {
                        // Map English digits ('0'-'9') to Arabic digits ('٠'-'٩')
                        return String.fromCharCode(asciiValue + 0x0660 - 48);
                      }
                      return char;
                    }).join()} ج';

                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        englishToArabicNumbers,
                        style: const TextStyle(
                            fontSize: 12), // Adjust text style as needed
                      ),
                    );
                  },
                ),
              ),
              leftTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    if (index >= 0 && index < sortedDates.length) {
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        child: Text(
                          dateFormatter.format(sortedDates[index]),
                          style: const TextStyle(fontSize: 10),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  reservedSize: 40, // Increases space on the bottom
                ),
              ),
            ),
            gridData: const FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: false,
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                  color: Colors.transparent, width: 0), // Removes extra border
            ),
          ),
          duration: const Duration(milliseconds: 150), // Optional
          curve: Curves.linear, // Optional
        ),
      ),
    );
  }
}
