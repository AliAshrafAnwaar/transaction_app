import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:transaction_app/data/model/client.dart';

class ExcelServices {
  Future<void> exportClientsToExcel(Set<Client> clients) async {
    // Create Excel object
    var excel = Excel.createExcel();

    // Get the default sheets
    Sheet sheetObject = excel['Clients'];
    Sheet sheetAllTransactions = excel['Transactions'];

    // Add headers
    sheetObject.appendRow([
      TextCellValue('Name'),
      TextCellValue('Phone Number'),
      TextCellValue('Number of Transactions'),
    ]);
    sheetAllTransactions.appendRow([
      TextCellValue('ID'),
      TextCellValue('Phone Number'),
      TextCellValue('Amount'),
      TextCellValue('Type'),
      TextCellValue('Payment Method'),
      TextCellValue('Date'),
    ]);

    // Add client data
    try {
      for (var client in clients) {
        for (var transaction in client.transactions!) {
          sheetAllTransactions.appendRow([
            TextCellValue(transaction.id.toString()),
            TextCellValue(transaction.phoneNumber!),
            DoubleCellValue(transaction.amount!),
            TextCellValue(transaction.type!),
            TextCellValue(transaction.payMethod!),
            DateTimeCellValue.fromDateTime(transaction.time!),
          ]);
        }
        sheetObject.appendRow([
          TextCellValue(client.name!),
          TextCellValue(client.phoneNumber!),
          TextCellValue(client.numberTransactions.toString()),
        ]);
      }
    } on Exception catch (e) {
      print('Error while adding data: $e');
    }

    // Save file based on platform
    if (kIsWeb) {
      // Save for Web
      excel.save(fileName: "بيانات العلماء.xlsx");
    } else {
      // Save for Android or other platforms
      await _saveFileForMobile(excel.save()!);
    }
  }

  // Save file for mobile
  Future<void> _saveFileForMobile(List<int> bytes) async {
    // Check storage permission
    if (!await Permission.manageExternalStorage.request().isGranted) {
      print('Manage external storage permission denied');
      return;
    }

    // Pick a directory
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      print('No directory selected');
      return;
    }

    String filePath = '$selectedDirectory/clients.xlsx';
    try {
      // Write file to the selected directory
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(bytes);

      print('File saved at: $filePath');
    } catch (e) {
      print('Error saving file: $e');
    }
  }
}
