import 'expense_model.dart';

class DateWiseExpModel {
  String date;
  num totalAmt;
  List<ExpenseModel> expenses;

  DateWiseExpModel(
      {required this.date, required this.totalAmt, required this.expenses});
}
