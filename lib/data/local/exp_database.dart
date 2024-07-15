import 'dart:async';

import 'package:expense/domains/app_prefs.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/expense_model.dart';

class ExpDatabase {
  ExpDatabase._(); //singleton class
  Database? expDB;

  static final ExpDatabase ExpDatabase_obj = ExpDatabase._();

  static const String DATABASE_NAME = 'expenses.db';
  static const String TABLE_NAME_LOGIN_DETAILS = 'login_details';
  static const String COLUMN_NAME_LOGIN_TB_FNAME = 'fName';
  static const String COLUMN_NAME_LOGIN_TB_LNAME = 'lName';
  static const String COLUMN_NAME_LOGIN_TB_USER_ID = 'uerId';
  static const String COLUMN_NAME_LOGIN_TB_EMAIL = 'emailAddress';
  static const String COLUMN_NAME_LOGIN_TB_PHONE = 'phoneNo';
  static const String COLUMN_NAME_LOGIN_TB_PASSWORD = 'password';

  //Expense table details
  static const String TABLE_EXPENSE = 'expense';
  static const String COLUMN_EXP_ID = 'expId';
  static const String COLUMN_EXP_TITLE = 'expTitle';
  static const String COLUMN_EXP_DESC = 'expDesc';
  static const String COLUMN_EXP_CAT_ID = 'catId';
  static const String COLUMN_EXP_TYPE = 'expType'; //1 for Debit, 2 for credit
   static const String COLUMN_EXP_AMT = 'expAmt';
  static const String COLUMN_EXP_BAL = 'expBal';
  static const String COLUMN_EXP_CREATE_AT = 'expCreatedAt';

  Future<Database> getDB() async
  {
    if (expDB != null) {
      return expDB!;
    }
    else {
      expDB = await openDB();
      return expDB!;
    }
  }

  Future<Database> openDB() async
  {
    var d_Path = await getApplicationDocumentsDirectory();
    var full_path = join(d_Path.path, ExpDatabase.DATABASE_NAME);
    return await openDatabase(full_path, version: 1, onCreate: (db, version) {
      db.execute("create table $TABLE_NAME_LOGIN_DETAILS ($COLUMN_NAME_LOGIN_TB_USER_ID integer primary key autoincrement,$COLUMN_NAME_LOGIN_TB_FNAME text,$COLUMN_NAME_LOGIN_TB_LNAME text,$COLUMN_NAME_LOGIN_TB_EMAIL text,$COLUMN_NAME_LOGIN_TB_PHONE text,$COLUMN_NAME_LOGIN_TB_PASSWORD text) ");
      db.execute("create table $TABLE_EXPENSE ($COLUMN_EXP_ID integer primary key autoincrement, $COLUMN_NAME_LOGIN_TB_USER_ID integer, $COLUMN_EXP_TITLE text,$COLUMN_EXP_DESC text,$COLUMN_EXP_CAT_ID integer,$COLUMN_EXP_TYPE text,$COLUMN_EXP_AMT real,$COLUMN_EXP_BAL real,$COLUMN_EXP_CREATE_AT text, foreign key ($COLUMN_NAME_LOGIN_TB_USER_ID) references $TABLE_NAME_LOGIN_DETAILS($COLUMN_NAME_LOGIN_TB_USER_ID)) ");
    });
  }

  Future<bool> insertionSignUp({required String fname,required String lname,required String email,required String phn,required String password})async
  {
    var db =await getDB();
    int inserted=await db.rawInsert("insert into $TABLE_NAME_LOGIN_DETAILS ($COLUMN_NAME_LOGIN_TB_FNAME,$COLUMN_NAME_LOGIN_TB_LNAME,$COLUMN_NAME_LOGIN_TB_EMAIL,$COLUMN_NAME_LOGIN_TB_PHONE,$COLUMN_NAME_LOGIN_TB_PASSWORD) values ('$fname','$lname','$email','$phn','$password') ");
    return inserted>0;
  }

/////Login Query

Future<bool> loginAuthentication({required String emailId,required String pass}) async
{
  var db =await getDB();
  List<Map<String,dynamic>> data = await db.rawQuery("select $COLUMN_NAME_LOGIN_TB_EMAIL,$COLUMN_NAME_LOGIN_TB_USER_ID from $TABLE_NAME_LOGIN_DETAILS where $COLUMN_NAME_LOGIN_TB_EMAIL='$emailId' and $COLUMN_NAME_LOGIN_TB_PASSWORD='$pass'");

  if(data.isNotEmpty){
    var prefs=AppPrefs();
    prefs.initPrefs();
    prefs.setUserId(data[0][COLUMN_NAME_LOGIN_TB_USER_ID]);
  }
  return data.isNotEmpty;
}

//Fetch user Expenses

  Future<List<ExpenseModel>> getUserExpenses() async{

    var prefs=AppPrefs();
    prefs.initPrefs();
   int id= prefs.getUserId();

    var db=await getDB();
    List<Map<String,dynamic>> allExpenses =await db.query(TABLE_EXPENSE,where: "$COLUMN_NAME_LOGIN_TB_USER_ID = ?", whereArgs: ['$id']);

    List<ExpenseModel> mExpenses=[];
    for(Map<String,dynamic> eachExpenses in allExpenses)
      {
        mExpenses.add(ExpenseModel.fromMap(eachExpenses));
      }
    return mExpenses;

  }

  Future<bool> addUserExpense(ExpenseModel newExpense) async{
    var db =await getDB();
    //db.rawInsert("insert into ${}")
    int rowsInserted=await db.insert(TABLE_EXPENSE, newExpense.toMap());
    return rowsInserted>0;
  }

}