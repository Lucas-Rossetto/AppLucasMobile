import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/models/todolistDatabase.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

  String todoTable = 'todo_table';
	String colId = 'id';
	String colTask = 'task';
	String colChecked = 'checked';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'notes.db';

		// Open/create the database at a given path
		var todoDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return todoDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
				'$colTask TEXT, $colChecked BOOL)');
	}

	// Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getTodoMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
		var result = await db.query(todoTable);
		return result;
	}

	// Insert Operation: Insert a Note object to database
	Future<int> insertTodo(TodoData todo) async {
		Database db = await this.database;
		var result = await db.insert(todoTable, todo.toMap());
		return result;
	}


  Future<int> insertTask(TodoData todo) async {
		Database db = await this.database;
		var result = await db.insert(todoTable, todo.toMap());
		return result;
	}


	// Update Operation: Update a Note object and save it to database
	Future<int> updateTodo(TodoData todo) async {
		var db = await this.database;
		var result = await db.update(todoTable, todo.toMap(), where: '$colId = ?', whereArgs: [todo.id]);
		return result;
	}

	// Delete Operation: Delete a Note object from database
	Future<int> deleteTodo(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $todoTable WHERE $colId = $id');
		return result;
	}

	// Get number of Note objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $todoTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
	Future<List<TodoData>> getTodoList() async {

		var todoMapList = await getTodoMapList(); // Get 'Map List' from database
		int count = todoMapList.length;         // Count the number of map entries in db table

		List<TodoData> todoList = List<TodoData>();
		// For loop to create a 'Note List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			todoList.add(TodoData.fromMapObject(todoMapList[i]));
		}

		return todoList;
	}

}
