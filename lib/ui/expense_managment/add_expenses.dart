import 'package:expense/data/local/exp_database.dart';
import 'package:expense/data/models/cat_model.dart';
import 'package:expense/data/models/expense_model.dart';
import 'package:expense/domains/app_constants.dart';
import 'package:expense/domains/app_prefs.dart';
import 'package:expense/ui/bloc/expense_bloc.dart';
import 'package:expense/ui/bloc/expense_event.dart';
import 'package:expense/ui/custom_widget/widgets_design.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddExpenses extends StatelessWidget {

  var tfControllerSpent=TextEditingController();
  ExpDatabase db=ExpDatabase.ExpDatabase_obj;
  bool categotyOptionVisible=false;
  int selectedCategoryId = -1;
  List<String> listType = ['Debit', 'Credit', 'Lend', 'Borrow'];
  String selectedType = 'Debit';
  num balance = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool titleGiven = false;
  bool descGiven = false;
  DateFormat mFormat = DateFormat.yMMMd();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Expenses"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          // padding: EdgeInsets.only(left: 10,right: 10,top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Spent",
                style: TextStyle(fontSize: 21, color: Colors.grey.shade400),
              ),
              SizedBox(
                height: 21,
              ),

              StatefulBuilder(builder: (_,ss){
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 150, right: 150),
                      child: TextField(
                        controller: tfControllerSpent,
                        style: TextStyle(fontSize: 25),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.currency_rupee,
                            size: 50,
                          ),
                        ),
                        onChanged: (value){
                          checkSpentIsEmpty();
                          ss((){});
                        },
                      ),
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    categotyOptionVisible==true ? Text("Select Expense Categoty",style: TextStyle(fontSize: 21, color: Colors.grey.shade400)) : Container(),
                    SizedBox(
                      height: 21,
                    ),
                    categotyOptionVisible==true ?InkWell(
                      child: selectedCategoryId == -1 ? Icon(Icons.category, size: 40,) : Image.asset(AppConstants.mCategories.where((element) => element.catId==selectedCategoryId).toList()[0].catImgUrl!, width: 50, height: 50,),
                      onTap: () {
                        showModalBottomSheet(
                         // barrierColor: Colors.grey,
                          // isDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                height: 700,
                                child:  Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Center(
                                          child: Text(
                                            'Category',
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(height: 25,),
                                        GridView.builder(
                                            itemCount: AppConstants.mCategories.length,
                                            shrinkWrap: true,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                               /* crossAxisSpacing: 10,
                                                mainAxisSpacing: 10*/
                                            ),
                                            itemBuilder: (_,index){
                                              return InkWell(
                                                onTap: (){
                                                  selectedCategoryId = AppConstants.mCategories[index].catId!;
                                                  ss((){});
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    Image.asset(AppConstants.mCategories[index].catImgUrl!, width: 50, height: 50,),
                                                    Text(AppConstants.mCategories[index].catName!)
                                                  ],
                                                ),
                                              );
                                            })
                                      ],
                                    ),

                              );
                          },
                        );
                      },
                    ) : Container(),
                    SizedBox(
                      height: 21,
                    ),
                    selectedCategoryId!=-1 ? DropdownButton(
                        items: listType.map((eachType){
                      return DropdownMenuItem(
                        value: eachType,
                          child: Text(eachType));
                    }).toList(), onChanged: (value){
                      selectedType = value!;
                      ss((){});
                    }, value: selectedType,) : Container(),
                    SizedBox(
                      height: 21,
                    ),
                    selectedCategoryId!=-1? TextField(
                      controller: titleController, onChanged: (value){
                        if(value!=""){
                          titleGiven = true;
                        } else {
                          titleGiven = false;
                        }
                        ss((){});
                    },
                    ) : Container(),
                    titleGiven ? TextField(
                      controller: descController,
                      onChanged: (value){
                        if(value!=""){
                          descGiven = true;
                        } else {
                          descGiven = false;
                        }
                        ss((){});
                      },
                    ) : Container(),
                    descGiven ? ElevatedButton(onPressed: () async{
                     selectedDate = await showDatePicker(context: context, firstDate: DateTime(DateTime.now().year-2, 1, 1), lastDate: DateTime.now()) ?? DateTime.now();
                     ss((){});
                    }, child: Text(mFormat.format(selectedDate))) : Container(),
                    categotyOptionVisible==true ? ElevatedButton(onPressed: (){

                      /*var prefs=AppPrefs();
                      int uId=prefs.getUserId();*/

                      if(selectedCategoryId>0) {

                        context.read<ExpenseBloc>().add(AddExpenseEvent(newExpense: ExpenseModel(
                            catId: selectedCategoryId,
                            expAmt: int.parse(tfControllerSpent.text),
                            expBal: selectedType=='Debit' ? balance-int.parse(tfControllerSpent.text) : balance + int.parse(tfControllerSpent.text),
                            expTitle: titleController.text.toString(),
                            expDesc: descController.text.toString(),
                            expType: selectedType,
                            expCreatedAt: selectedDate.millisecondsSinceEpoch.toString())));

                        categotyOptionVisible=false;
                        tfControllerSpent.clear();
                        titleController.clear();
                        descController.clear();
                        Navigator.pop(context);
                      }

                    }, child: Text("Save")) : Container(),
                  ],
                );
              }),

            ],
          ),
        ),
      ),
    );
  }
  checkSpentIsEmpty()
  {
    if(tfControllerSpent.text.toString().isNotEmpty)
      {
        categotyOptionVisible=true;
      }
    else{
      categotyOptionVisible=false;
    }
  }
}
