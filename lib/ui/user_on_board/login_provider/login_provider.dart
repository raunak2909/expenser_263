import 'package:expense/data/local/exp_database.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier{

  ExpDatabase db=ExpDatabase.ExpDatabase_obj;
  List<Map<String,dynamic>> _loginDetails=[];

  Future<List<Map<String, dynamic>>> providerLoginAuthentication({required String email, required String pass}) async
  {
    //_loginDetails=await db.loginAuthentication(emailId: email, pass: pass);
    return _loginDetails;
  }

  List<Map<String,dynamic>> fetchUserId()
  {
    return _loginDetails;
  }

}