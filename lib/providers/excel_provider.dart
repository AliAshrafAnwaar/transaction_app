import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:transaction_app/data/model/client.dart';
import 'package:transaction_app/data/repo/excel_repo.dart';

part 'excel_provider.g.dart';

@riverpod
class ExcelProvider extends _$ExcelProvider {
  ExcelRepo excelRepo = ExcelRepo();
  @override
  build() {
    return {};
  }

  void exportClientsToExcel(Set<Client> clients) {
    excelRepo.exportClientsToExcel(clients);
  }
}
