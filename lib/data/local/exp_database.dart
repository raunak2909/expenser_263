import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ExpDatabase {
  ExpDatabase._(); //singleton class
  Database? expDB;

  static final ExpDatabase ExpDatabase_obj = ExpDatabase._();

  static const String DATABASE_NAME = 'expenses.db';
  static const String TABLE_NAME_LOGIN_DETAILS = 'login_details';
  static const String COLUMN_NAME_LOGIN_TB_FNAME = 'fName';
  static const String COLUMN_NAME_LOGIN_TB_LNAME = 'lName';
  static const String COLUMN_NAME_LOGIN_TB_EMAIL = 'emailAddress';
  static const String COLUMN_NAME_LOGIN_TB_PHONE = 'phoneNo';
  static const String COLUMN_NAME_LOGIN_TB_PASSWORD = 'password';


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
      db.execute("create table $TABLE_NAME_LOGIN_DETAILS ($COLUMN_NAME_LOGIN_TB_FNAME text,$COLUMN_NAME_LOGIN_TB_LNAME text,$COLUMN_NAME_LOGIN_TB_EMAIL text primary key,$COLUMN_NAME_LOGIN_TB_PHONE text,$COLUMN_NAME_LOGIN_TB_PASSWORD text) ");
    });
  }

  Future<bool> insertionSignUp({required String fname,required String lname,required String email,required String phn,required String password})async
  {
    var db =await getDB();
    int inserted=await db.rawInsert("insert into $TABLE_NAME_LOGIN_DETAILS ($COLUMN_NAME_LOGIN_TB_FNAME,$COLUMN_NAME_LOGIN_TB_LNAME,$COLUMN_NAME_LOGIN_TB_EMAIL,$COLUMN_NAME_LOGIN_TB_PHONE,$COLUMN_NAME_LOGIN_TB_PASSWORD) values ('$fname','$lname','$email','$phn','$password') ");
    return inserted>0;
  }

/////Login Query

Future<List<Map<String,dynamic>>> loginAuthentication({required String emailId,required String pass}) async
{
  var db =await getDB();
  List<Map<String,dynamic>> data=await db.rawQuery("select $COLUMN_NAME_LOGIN_TB_EMAIL, $COLUMN_NAME_LOGIN_TB_PASSWORD from $TABLE_NAME_LOGIN_DETAILS where $COLUMN_NAME_LOGIN_TB_EMAIL='$emailId' and $COLUMN_NAME_LOGIN_TB_PASSWORD='$pass'");
  return data;
}

}