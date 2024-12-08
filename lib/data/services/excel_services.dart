import 'dart:io';
import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:file_picker/file_picker.dart';

class ExcelServices {
  Future<void> exportClientsToExcel(Set<Client> clients) async {
    // Check storage permission
    if (!await Permission.manageExternalStorage.request().isGranted) {
      print('Manage external storage permission denied');
      return;
    }

    // Create Excel object
    var excel = Excel.createExcel();

    // Get the default sheet
    Sheet sheetObject = excel['Clients'];
    Sheet sheetAllTransactions = excel['Transactions'];

    // Add headers
    sheetObject.appendRow([
      TextCellValue('Name'),
      TextCellValue('Phone Number'),
      TextCellValue('number of transactions'),
    ]);
    sheetAllTransactions.appendRow([
      TextCellValue('ID'),
      TextCellValue('Phone Number'),
      TextCellValue('Amount'),
      TextCellValue('type'),
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
      print(e);
    }
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

    if (selectedDirectory == null) {
      // User canceled the picker
    }
    print(selectedDirectory);

    // Save file to storage
    try {
      // Get directory
      // Directory? directory = await getExternalStorageDirectory();
      // print(directory);
      String filePath = '${selectedDirectory}/clients.xlsx';

      // Write file
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.save()!);

      print('File saved at: $filePath');
    } catch (e) {
      print('Error saving file: $e');
    }
  }
}
