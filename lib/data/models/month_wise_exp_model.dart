import 'expense_model.dart';

class MonthWiseExpModel {
  String month;
  num totalAmt;
  List<ExpenseModel> expenses;

  MonthWiseExpModel(
      {required this.month, required this.totalAmt, required this.expenses});
}
