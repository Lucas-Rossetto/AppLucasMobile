import 'package:flutter/material.dart';
import 'package:flutter_app/models/todolistDatabase.dart';
import 'package:flutter_app/utils/database_helper.dart';

// class TodoApp extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new TodoList(_todoData),
//       debugShowCheckedModeBanner: false,
//    );
//   }
// }




class TodoList extends StatefulWidget {

  final TodoData _todoData;
  final String appBarTitle;

  TodoList(this._todoData,this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
  return TodoListState(this._todoData , this.appBarTitle);
  }
  // @override
  // createState() => new TodoListState();
}

// class _TodoList extends InheritedWidget {

// final TodoListState data;

// _TodoList({Key key , this.data , Widget child}) { 
  
//   super(key : key , child: child);

// }
// @override
// bool updateShouldNotify(_TodoList old){
//   return true;
// }

// }

class TodoListState extends State<TodoList> {

  TextEditingController taskController = TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<String> _todoItems = [];
  TodoData _todoData;
  String appBarTitle;
  int count = 0;
  TodoListState(this._todoData, this.appBarTitle);

  // List<TodoData> testTodo = [];

  // final bloc = TodoBloc();

  // @override
  // void dispose() {
  //   bloc.dispose();
  //   super.dispose();
  // }


  // void _addTodoItem(String task) {
  //   // Only add the task if the user actually entered something
  //   if(task.length > 0) {
  //     // Putting our code inside "setState" tells the app that our state has changed, and
  //     // it will automatically re-render the list
  //     //setState(() => _todoItems.add(task));
  //     setState(() => _todoItems.add(_todoData.toString()));
  //     }
  // }


  @override
  Widget build(BuildContext context) {


    taskController.text = _todoData.task;


    return new Scaffold(
     //   appBar: new AppBar(
     //   title: new Text('Todo List')
     //  ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: new Icon(Icons.add),
      ),
    );
  }



  void _save() async {

    
  int result;
    
    if(_todoData.id == null){
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
 

  void _removeTodoItem(int index) {
    setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Mark "${_todoItems[index]}" as done?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('CANCEL'),
              // The alert is actually part of the navigation stack, so to close it, we
              // need to pop it.
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('MARK AS DONE'),
              onPressed: () {
                databaseHelper.deleteTodo(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {

     return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
}

  //   return Scaffold(
  //     body: FutureBuilder<List<TodoData>>(
  //       future: DBProvider.db.getAllTodoLists(),
  //       builder: (BuildContext context , AsyncSnapshot<List<TodoData>> snapshot) {
  //         if (snapshot.hasData) {
  //           return new ListView.builder(
  //             itemCount: snapshot.data.length,
  //             itemBuilder: (context, index) {
  //               TodoData item = snapshot.data[index];
  //       // itemBuilder will be automatically be called as many times as it takes for the
  //       // list to fill up its available space, which is most likely more than the
  //       // number of todo items we have. So, we need to check the index is OK.
  //       if(index < _todoItems.length) {
  //         return _buildTodoItem(_todoItems[index], index);
  //       }
  //     },
  //   );
  // }
  //       },
  //     ),
  //   );
  // }
  // Build a single todo item
  Widget _buildTodoItem(String todoText, int index) {
    return new ListTile(
      title: new Text(todoText),

      onTap: () => _promptRemoveTodoItem(index)
    );
  }

  void _pushAddTodoScreen() {


    TextStyle textStyle = Theme.of(context).textTheme.title;
    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well as adding
      // a back button to close it

      
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Add a new task')
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
                ] 
              ),
              ),

          ]
        ),
        ),
          );
        }
      ),
    );
  }
  

            // body: new RaisedButton(
            //   onPressed : () {
            //     setState(() {
            //     debugPrint("Save button clicked");  
            //     Navigator.pop(context); // Close the add todo screen
            //     _save();
            //     });
            //   }
            // ),
  
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
}

// import 'package:flutter/material.dart';
// import 'package:flutter_app/todolistDatabase.dart';
// import 'package:flutter_app/database.dart';
// import 'package:flutter_app/BLOCS/DatabaseBloc.dart';

// class TodoApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new TodoList(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class TodoList extends StatefulWidget {

//   @override
//   createState() => new TodoListState();

// }

// // class _TodoList extends InheritedWidget {

// // final TodoListState data;

// // _TodoList({Key key , this.data , Widget child}) { 
  
// //   super(key : key , child: child);

// // }
// // @override
// // bool updateShouldNotify(_TodoList old){
// //   return true;
// // }

// // }


// class TodoListState extends State<TodoList> {
//   List<String> _todoItems = [];
//   List<TodoData> testTodo = [];

//   final bloc = TodoBloc();

//   @override
//   void dispose() {
//     bloc.dispose();
//     super.dispose();
//   }


//   void _addTodoItem(String task) {
//     // Only add the task if the user actually entered something
//     if(task.length > 0) {
//       // Putting our code inside "setState" tells the app that our state has changed, and
//       // it will automatically re-render the list
//       setState(() => _todoItems.add(task));
//     }
//   }


//   void _removeTodoItem(int index) {
//     setState(() => _todoItems.removeAt(index));
//   }

//   void _promptRemoveTodoItem(int index) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return new AlertDialog(
//           title: new Text('Mark "${_todoItems[index]}" as done?'),
//           actions: <Widget>[
//             new FlatButton(
//               child: new Text('CANCEL'),
//               // The alert is actually part of the navigation stack, so to close it, we
//               // need to pop it.
//               onPressed: () => Navigator.of(context).pop()
//             ),
//             new FlatButton(
//               child: new Text('MARK AS DONE'),
//               onPressed: () {
//                 _removeTodoItem(index);
//                 Navigator.of(context).pop();
//               }
//             )
//           ]
//         );
//       }
//     );
//   }

//   // Build the whole list of todo items
//   Widget _buildTodoList() {
//     return new ListView.builder(
//       itemBuilder: (context, index) {
//         // itemBuilder will be automatically be called as many times as it takes for the
//         // list to fill up its available space, which is most likely more than the
//         // number of todo items we have. So, we need to check the index is OK.
//         if(index < _todoItems.length) {
//           return _buildTodoItem(_todoItems[index], index);
//         }
//       },
//     );
//   }

//   // Build a single todo item
//   Widget _buildTodoItem(String todoText, int index) {
//     return new ListTile(
//       title: new Text(todoText),

//       onTap: () => _promptRemoveTodoItem(index)
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//    //   appBar: new AppBar(
//      //   title: new Text('Todo List')
//     //  ),
//       body: _buildTodoList(),
//       floatingActionButton: new FloatingActionButton(
//         onPressed: _pushAddTodoScreen,
//         tooltip: 'Add task',
//         child: new Icon(Icons.add),
        

    
//       ),
//     );
//   }

  

//   void _pushAddTodoScreen() {
//     // Push this page onto the stack
//     Navigator.of(context).push(
//     //   // MaterialPageRoute will automatically animate the screen entry, as well as adding
//     //   // a back button to close it
//       new MaterialPageRoute(
//           builder: (context) {
//           return new Scaffold(
//             appBar: new AppBar(
//               title: new Text('Add a new task')
//             ),
//             //   body:StreamBuilder<List<TodoData>>(
//             //     stream: bloc.todo,
//             //     builder: (BuildContext context , AsyncSnapshot<List<TodoData>> snapshot) {
//             //       if(snapshot.hasData) {
//             //         return ListView.builder(
//             //           itemCount: snapshot.data.length,
//             //           itemBuilder: (BuildContext context , int index) {
//             //             TodoData item  = snapshot.data[index];
//             //              return new TextField(
//             //                key:UniqueKey(),
//             //                onSubmitted: (val){
//             //                  _addTodoItem(item.task);
//             //                },

//             //         );
                  
//               body: new TextField(
//                autofocus: true,
//                onSubmitted: (val) {
//                  bloc.add(val.id);
//                 Navigator.pop(context); // Close the add todo screen
//               },
//                     );
//               decoration: new InputDecoration(
//                 hintText: 'Enter something to do...',
//                 contentPadding: const EdgeInsets.all(16.0)
//               );
//       );

//       }
//       )

//     );
      
//   }
// }