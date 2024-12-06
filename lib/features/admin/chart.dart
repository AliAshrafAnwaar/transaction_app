import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/model/transaction.dart';
import 'package:intl/intl.dart';

late List<DateTime> sortedDates;

class Chart extends StatelessWidget {
  const Chart({super.key});

  Map<DateTime, Map<String, double>> groupTransactionsByDateAndType(
      List<TransactionModel> transactions) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day); // Start of today
    final sevenDaysAgo =
        today.subtract(const Duration(days: 6)); // Inclusive of today

    // Initialize the map with the last 7 days and set their values to 0
    final groupedData = <DateTime, Map<String, double>>{};
    for (int i = 0; i < 7; i++) {
      final date = sevenDaysAgo.add(Duration(days: i));
      groupedData[date] = {'ايداع': 0.0, 'سحب': 0.0};
    }

    // Group transactions and add their amounts to the corresponding dates
    for (final transaction in transactions) {
      if (transaction.time!
              .isAfter(sevenDaysAgo.subtract(const Duration(seconds: 1))) &&
          transaction.time!.isBefore(today.add(const Duration(days: 1)))) {
        final date = DateTime(
          transaction.time!.year,
          transaction.time!.month,
          transaction.time!.day,
        );
        final type = transaction.type; // 'ايداع' or 'سحب'
        groupedData[date]![type!] =
            (groupedData[date]![type] ?? 0) + transaction.amount!;
      }
    }

    return groupedData;
  }

  List<BarChartGroupData> prepareBarChartData(
      Map<DateTime, Map<String, double>> groupedData) {
    sortedDates = groupedData.keys.toList()..sort();

    return List.generate(sortedDates.length, (i) {
      final date = sortedDates[i];
      final deposit = groupedData[date]!['ايداع']!;
      final withdrawal = groupedData[date]!['سحب']!;

      return BarChartGroupData(
        x: i,
        barRods: [
          // Combined bar for stacking
          BarChartRodData(
            width: 40, // Adjust bar width
            toY: deposit + withdrawal, // Total height (deposit + withdrawal)
            rodStackItems: [
              // Deposit part of the stack
              BarChartRodStackItem(0, deposit, Colors.blue),
              // Withdrawal part stacked above the deposit
              BarChartRodStackItem(
                  deposit, deposit + withdrawal, Colors.purple),
            ],
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    });
  }

  void printGroupedTransactions(List<TransactionModel> transactions) {
    final groupedTransactions = groupTransactionsByDateAndType(transactions);

    // Print the grouped transactions
    groupedTransactions.forEach((date, totalAmount) {
      print('Date: ${date.toLocal()} | Total Amount: \$${totalAmount}');
    });
  }

  /// Converts numbers to Arabic numerals.
  String toArabicNumerals(double value) {
    return '${value.toInt()} ج'.split('').map((char) {
      final asciiValue = char.codeUnitAt(0);
      if (asciiValue >= 48 && asciiValue <= 57) {
        return String.fromCharCode(asciiValue + 0x0660 - 48);
      }
      return char;
    }).join();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd/MM/yy', 'ar'); // Arabic date format
    final groupedData = groupTransactionsByDateAndType(allTransactions);
    final chartData = prepareBarChartData(groupedData);
    printGroupedTransactions(allTransactions);

    return BarChart(
      BarChartData(
        barGroups: chartData,
        groupsSpace: 35,
        alignment: BarChartAlignment.center,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            //to adjust location of pop up
            tooltipMargin: 0,
            tooltipHorizontalOffset: 0,
            tooltipPadding: const EdgeInsets.all(8),
            tooltipBorder: const BorderSide(color: Colors.white, width: 1),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final date = sortedDates[group.x.toInt()];
              final groupedDataForDate = groupedData[date]!;
              final deposit = groupedDataForDate['ايداع']!;
              final withdrawal = groupedDataForDate['سحب']!;

              return BarTooltipItem(
                'التاريخ: ${DateFormat('dd/MM/yyyy', 'ar').format(date)}\n'
                'ايداع: $deposit\n'
                'سحب: $withdrawal\n',
                const TextStyle(color: Colors.white, fontSize: 12),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) => SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(
                  toArabicNumerals(value),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
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
            ),
          ),
        ),
        gridData: const FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: false,
        ),
        borderData: FlBorderData(
          show: false, // Removes unnecessary border
        ),
      ),
      duration: const Duration(milliseconds: 150), // Smooth transition
      curve: Curves.linear, // Linear animation
    );
  }
}
