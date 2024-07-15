import 'dart:ui';

import 'package:expense/data/local/exp_database.dart';

class ExpenseModel{

  int? expId;
  int? userId;
  int? catId;
  num? expAmt;
  num? expBal;
  String? expTitle;
  String? expDesc;
  String? expType;
  String? expCreatedAt;

ExpenseModel({this.expId, required this.userId, required this.catId, required this.expAmt, required this.expBal, required this.expTitle, required this.expDesc, required this.expType, required this.expCreatedAt});

 factory ExpenseModel.fromMap(Map<String,dynamic> map){
   return ExpenseModel(
       expId: map[ExpDatabase.COLUMN_EXP_ID],
       userId: map[ExpDatabase.COLUMN_NAME_LOGIN_TB_USER_ID],
       catId: map[ExpDatabase.COLUMN_EXP_CAT_ID],
       expAmt: map[ExpDatabase.COLUMN_EXP_AMT],
       expBal: map[ExpDatabase.COLUMN_EXP_BAL],
       expTitle: map[ExpDatabase.COLUMN_EXP_TITLE],
       expDesc: map[ExpDatabase.COLUMN_EXP_DESC],
       expType: map[ExpDatabase.COLUMN_EXP_TYPE],
       expCreatedAt: map[ExpDatabase.COLUMN_EXP_CREATE_AT]
   );
 }

 Map<String, dynamic> toMap(){
  return {
    ExpDatabase.COLUMN_EXP_ID : expId,
    ExpDatabase.COLUMN_NAME_LOGIN_TB_USER_ID : userId,
    ExpDatabase.COLUMN_EXP_CAT_ID : catId,
    ExpDatabase.COLUMN_EXP_AMT : expAmt,
    ExpDatabase.COLUMN_EXP_BAL : expBal,
    ExpDatabase.COLUMN_EXP_TITLE : expTitle,
    ExpDatabase.COLUMN_EXP_DESC : expDesc,
    ExpDatabase.COLUMN_EXP_TYPE : expType,
    ExpDatabase.COLUMN_EXP_CREATE_AT : expCreatedAt
  };
 }

}