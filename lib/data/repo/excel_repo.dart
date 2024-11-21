import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/services/excel_services.dart';

class ExcelRepo {
  ExcelServices excelServices = ExcelServices();

  void exportClientsToExcel(Set<Client> clients) {
    excelServices.exportClientsToExcel(clients);
  }
}
