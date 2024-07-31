import 'dart:math';
import 'dart:ui';

import 'package:expense/data/local/exp_database.dart';
import 'package:expense/data/models/date_wise_exp_model.dart';
import 'package:expense/domains/app_constants.dart';
import 'package:expense/ui/bloc/expense_bloc.dart';
import 'package:expense/ui/bloc/expense_event.dart';
import 'package:expense/ui/bloc/expense_state.dart';
import 'package:expense/ui/user_on_board/login_provider/login_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/models/expense_model.dart';
import '../../../data/models/month_wise_exp_model.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DateWiseExpModel> listDateWiseExp = [];
  List<MonthWiseExpModel> listMonthWiseExp = [];
  String indianRupeeSymbol = "\u{20B9}";

  DateFormat mFormat = DateFormat.yMMMd();

  List<String> listMonths = ['Jan', ' Feb',  'Mar', 'Apr',  'May', 'Jun',  'Jul', ' Aug',  'Sep', 'Oct',  'Nov', 'Dec', ];

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchAllExpenseEvent());

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (_, state) {
        if (state is ExpenseLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ExpenseErrorState) {
          return Center(
            child: Text('${state.errorMsg}'),
          );
        } else if (state is ExpenseLoadedState) {

          filterDateWiseExpense(state.mExpenses.reversed.toList());
          filterMonthWiseExpense(state.mExpenses.reversed.toList());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expense",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                  Image(
                    image: AssetImage('asset/icon/search_icon.png'),
                    width: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.account_circle),
                    radius: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                color: Color(0xffcccccc),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Month wise"),
                      Expanded(child: BarChart(
                          BarChartData(
                        titlesData: FlTitlesData(

                        ),
                        maxY: 20000,
                        barGroups: listMonthWiseExp.map((eachMonthData){
                          return BarChartGroupData(
                              x: listMonths.indexWhere((element) => element==eachMonthData.month.split(",")[0]), barRods: [
                            BarChartRodData(toY: (eachMonthData.totalAmt*-1).toDouble(),
                                color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
                              width: 14,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
                            ),
                          ]);
                        }).toList()
                      )))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                " Expense List",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: listMonthWiseExp.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1,color: Colors.grey.shade300)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${listMonthWiseExp[index].month}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "$indianRupeeSymbol ${listMonthWiseExp[index].totalAmt}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: listMonthWiseExp[index].expenses.length,
                                  itemBuilder: (_ , childIndex){

                                    var currentExpenseEachDate = listMonthWiseExp[index].expenses[childIndex];

                                    return ListTile(
                                      leading: Container(
                                          padding: EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                              color: Colors.primaries[Random().nextInt(Colors.primaries.length-1)].shade100
                                          ),
                                          child: Image.asset('${AppConstants.mCategories.where((element) => element.catId==currentExpenseEachDate.catId).toList()[0].catImgUrl}', width: 30, height: 30,)),
                                      title: Text(
                                        currentExpenseEachDate.expTitle!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      subtitle: Text( currentExpenseEachDate.expDesc!,),
                                      trailing: currentExpenseEachDate.expType=="Debit" ? Text('- $indianRupeeSymbol ${currentExpenseEachDate.expAmt!}', style: TextStyle(color: Colors.red),) : Text('$indianRupeeSymbol ${state.mExpenses[index].expAmt!}',style: TextStyle(color: Colors.green),),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  void filterDateWiseExpense(List<ExpenseModel> allExpenses){

    listDateWiseExp.clear();

    ///uniques dates
    List<String> uniqueDates = [];

    for(ExpenseModel eachExp in allExpenses){
      String date = mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expCreatedAt!)));

      if(!uniqueDates.contains(date)){
        uniqueDates.add(date);
      }

    }

    for(String eachDate in uniqueDates){
      num eachDayAmt = 0.0;
      List<ExpenseModel> eachDateExpenses = [];

      for(ExpenseModel eachExpense in allExpenses){
        String date = mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExpense.expCreatedAt!)));

        if(date == eachDate){
          eachDateExpenses.add(eachExpense);
          if(eachExpense.expType=='Debit' || eachExpense.expType=='Lend'){
            eachDayAmt -= eachExpense.expAmt!;
          } else {
            eachDayAmt += eachExpense.expAmt!;
          }
        }

      }

      listDateWiseExp.add(DateWiseExpModel(date: eachDate, totalAmt: eachDayAmt, expenses: eachDateExpenses));



    }

    print(listDateWiseExp);


  }

  void filterMonthWiseExpense(List<ExpenseModel> allExpenses){

    listMonthWiseExp.clear();

    ///uniques dates
    List<String> uniqueMonths = [];

    for(ExpenseModel eachExp in allExpenses){
      DateTime mDate = DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.expCreatedAt!));
      String month = "${listMonths[mDate.month-1]}, ${mDate.year}";
      print(month);

      if(!uniqueMonths.contains(month)){
        uniqueMonths.add(month);
      }

    }

    for(String eachMonth in uniqueMonths){
      num eachMonthAmt = 0.0;
      List<ExpenseModel> eachMonthExpenses = [];

      for(ExpenseModel eachExpense in allExpenses){
        DateTime mDate = DateTime.fromMillisecondsSinceEpoch(int.parse(eachExpense.expCreatedAt!));
        String month = "${listMonths[mDate.month-1]}, ${mDate.year}";


        if(eachMonth == month){
          eachMonthExpenses.add(eachExpense);
          if(eachExpense.expType=='Debit' || eachExpense.expType=='Lend'){
            eachMonthAmt -= eachExpense.expAmt!;
          } else {
            eachMonthAmt += eachExpense.expAmt!;
          }
        }

      }

      listMonthWiseExp.add(MonthWiseExpModel(month: eachMonth, totalAmt: eachMonthAmt, expenses: eachMonthExpenses));



    }

    print(listDateWiseExp);


  }

}

///monthwise
///yearwise
///catwise


/*
 Consumer<LoginProvider>(builder: (context,providerData,child)
          {
            loginRecordDetails=providerData.fetchUserId();
            return Text('${loginRecordDetails[0][ExpDatabase.COLUMN_NAME_LOGIN_TB_EMAIL]}');
          })
 */
