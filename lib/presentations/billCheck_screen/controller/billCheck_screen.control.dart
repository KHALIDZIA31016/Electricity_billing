import 'package:get/get.dart';

class BillCheckController extends GetxController {
  var showHistory = false.obs;
  var searchHistory = <String>[
    '1234567890123',
    '9876543210123',
  ].obs;

  void toggleHistory(bool value) {
    showHistory.value = value;
  }

  void clearHistory() {
    searchHistory.clear();
  }
}
