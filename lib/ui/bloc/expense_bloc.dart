import 'package:expense/data/models/expense_model.dart';
import 'package:expense/ui/bloc/expense_event.dart';
import 'package:expense/ui/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local/exp_database.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{
  ExpDatabase db;
  ExpenseBloc({required this.db}) : super(ExpenseInitialState()){

    on<AddExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());

      bool check = await db.addUserExpense(event.newExpense);

      if(check){
        List<ExpenseModel> allExpenses = await db.getUserExpenses();
        emit(ExpenseLoadedState(mExpenses: allExpenses));
      } else {
        emit(ExpenseErrorState(errorMsg: "Expense not added!!"));
      }

    });
    
    on<FetchAllExpenseEvent>((event, emit) async{
      emit(ExpenseLoadingState());
      
      var allExpenses = await db.getUserExpenses();
      
      emit(ExpenseLoadedState(mExpenses: allExpenses));
      
    });

  }
}