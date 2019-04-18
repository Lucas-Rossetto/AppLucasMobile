import 'package:flutter/material.dart';
import 'package:flutter_app/models/todolistDatabase.dart';
import 'package:flutter_app/utils/database_helper.dart';

class TodoList extends StatefulWidget {

  final TodoData _todoData;
  final String appBarTitle;

  TodoList(this._todoData,this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
  return TodoListState(this._todoData , this.appBarTitle);
  }
}

class TodoListState extends State<TodoList> {

  TextEditingController taskController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  TodoData _todoData;
  String appBarTitle;
  int count = 0;
  TodoListState(this._todoData, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    
    taskController.text = _todoData.task;    

    TextStyle textStyle = Theme.of(context).textTheme.title;
    // Push this page onto the stack
    return WillPopScope(

	     onWillPop: () {
	      	// Write some code to control things, when user press Back navigation button in device navigationBar
		     moveToLastScreen();
	     },

          child: Scaffold(
            appBar: new AppBar(
              title: new Text(appBarTitle),
              leading: IconButton(icon: Icon(
                              Icons.arrow_back),
                              onPressed: (){
                                moveToLastScreen();
                              }
                    ),
            ),

        body: Padding(
		    padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
		    child: ListView(
			    children: <Widget>[

			    	// First element
				     Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: TextField(
						    controller: taskController,
						    style: textStyle,
						    onChanged: (value) {
						    	debugPrint('Something changed in Title Text Field');
						    	updateTask();
						    },
						    decoration: InputDecoration(
							    labelText: 'Title',
							    labelStyle: textStyle,
							    border: OutlineInputBorder(
								    borderRadius: BorderRadius.circular(5.0)
							    )
						    ),
					    ),
				    ),
            // Second element

          Padding(
					    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
					    child: Row(
						    children: <Widget>[
						    	Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Save',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
									    	setState(() {
									    	  debugPrint("Save button clicked");
									    	  _save();
									    	});
									    },
								    ),
                  ),

                  Container(width: 5.0,),

							    Expanded(
								    child: RaisedButton(
									    color: Theme.of(context).primaryColorDark,
									    textColor: Theme.of(context).primaryColorLight,
									    child: Text(
										    'Delete',
										    textScaleFactor: 1.5,
									    ),
									    onPressed: () {
										    setState(() {
											    debugPrint("Delete button clicked");
											    _delete();
										    });
									    },
								    ),
                  ),
                 ],
                ),
               ),
              ],
        ),
      ),
    ));
  }


  void _save() async {

  moveToLastScreen();

  int result;
    
    if(_todoData.id != null){
      result = await databaseHelper.updateTodo(_todoData);
    } else {
      result = await databaseHelper.insertTodo(_todoData);
    }

    if(result != 0){
      _showAlertDialog("Status", "Todo ajouté à la liste !");
    }  else {
      _showAlertDialog("Status", "Echec de l'ajout");
    }

  }
  
  
void moveToLastScreen() {
		Navigator.pop(context, true);
}

  void updateTask(){
    _todoData.task = taskController.text;
}

 
	void _showAlertDialog(String title, String message) {

		AlertDialog alertDialog = AlertDialog(
			title: Text(title),
			content: Text(message),
		);
		showDialog(
				context: context,
				builder: (_) => alertDialog
		);
} 

  void _delete() async {

		moveToLastScreen();

		// Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
		// the detail page by pressing the FAB of NoteList page.
		if (_todoData.id == null) {
			_showAlertDialog('Status', 'No Todo was deleted');
			return;
		}

		// Case 2: User is trying to delete the old note that already has a valid ID.
		int result = await databaseHelper.deleteTodo(_todoData.id);
		if (result != 0) {
			_showAlertDialog('Status', 'Todo Deleted Successfully');
		} else {
			_showAlertDialog('Status', 'Error Occured while Deleting Todo');
		}
}

}