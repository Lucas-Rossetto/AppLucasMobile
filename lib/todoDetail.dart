import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/todolistDatabase.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:flutter_app/todolist.dart';
import 'package:sqflite/sqflite.dart';


class TodoDetail extends StatefulWidget {

	@override
  State<StatefulWidget> createState() {

    return TodoDetailState();
  }
}

class TodoDetailState extends State<TodoList> {

	DatabaseHelper databaseHelper = DatabaseHelper();
	List<TodoData> todoList;
	int count = 0;

	@override
  Widget build(BuildContext context) {

		if (todoList == null) {
			todoList = List<TodoData>();
			updateListView();
		}

    return Scaffold(

	    appBar: AppBar(
		    title: Text('Notes'),
	    ),

	    body: getNoteListView(),

	    floatingActionButton: FloatingActionButton(
		    onPressed: () {
		      debugPrint('FAB clicked');
		      navigateToDetail(TodoData(1, '', true), 'Add Note');
		    },

		    tooltip: 'Add Note',

		    child: Icon(Icons.add),

	    ),
    );
  }

  ListView getNoteListView() {

		TextStyle taskStyle = Theme.of(context).textTheme.subhead;

		return ListView.builder(
			itemCount: count,
			itemBuilder: (BuildContext context, int position) {
				return Card(
					color: Colors.white,
					elevation: 2.0,
					child: ListTile(

						title: Text(this.todoList[position].task, style: taskStyle,),

						trailing: GestureDetector(
							child: Icon(Icons.delete, color: Colors.grey,),
							onTap: () {
								_delete(context, todoList[position]);
							},
						),


						onTap: () {
							debugPrint("ListTile Tapped");
							navigateToDetail(this.todoList[position],'Edit Note');
						},

					),
				);
			},
		);
  }

  // Returns the priority color
	Color getPriorityColor(int priority) {
		switch (priority) {
			case 1:
				return Colors.red;
				break;
			case 2:
				return Colors.yellow;
				break;

			default:
				return Colors.yellow;
		}
	}

	// Returns the priority icon
	Icon getPriorityIcon(int priority) {
		switch (priority) {
			case 1:
				return Icon(Icons.play_arrow);
				break;
			case 2:
				return Icon(Icons.keyboard_arrow_right);
				break;
			default:
				return Icon(Icons.keyboard_arrow_right);
		}
	}

	void _delete(BuildContext context, TodoData todo) async {

		int result = await databaseHelper.deleteTodo(todo.id);
		if (result != 0) {
			_showSnackBar(context, 'Todo Deleted Successfully');
			updateListView();
		}
	}

	void _showSnackBar(BuildContext context, String message) {

		final snackBar = SnackBar(content: Text(message));
		Scaffold.of(context).showSnackBar(snackBar);
	}

  void navigateToDetail(TodoData todo, String title) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return TodoList(todo, title);
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }

  void updateListView() {

		final Future<Database> dbFuture = databaseHelper.initializeDatabase();
		dbFuture.then((database) {

			Future<List<TodoData>> noteListFuture = databaseHelper.getTodoList();
			noteListFuture.then((todoList) {
				setState(() {
				  this.todoList = todoList;
				  this.count = todoList.length;
				});
			});
		});
  }
}




