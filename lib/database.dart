// import 'dart:async';
// import 'dart:io';

// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// //import 'package:sqlite_demo/TodoListModel.dart';
// import 'package:sqflite/sqflite.dart';
// //import 'package:flutter_app/todolist.dart';
// import 'package:flutter_app/todolistDatabase.dart';


// class DBProvider {
//   DBProvider._();
//   static final DBProvider db = DBProvider._();


//   static Database _database;

//   Future<Database> get database async {
//     if (_database != null)
//     return _database;

//     // if _database is null we instantiate it
//     _database = await initDB();
//     return _database;
// }


// initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "Todo.db");
//     return await openDatabase(path, version: 1, onOpen: (db) {
//     }, onCreate: (Database db, int version) async {
//       await db.execute("CREATE TABLE TodoData ("
//           "id INTEGER PRIMARY KEY,"
//           "task TEXT,"
//           "checked BIT"
//           ")");
//     });
//   }

//  newTodoList(TodoData newTodoList) async {
//     final db = await database;
//     //get the biggest id in the table
//     var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM TodoData");
//     int id = table.first["id"];
//     //insert to the table using the new id
//     var raw = await db.rawInsert(
//         "INSERT Into TodoData (id,task,checked)"
//         " VALUES (?,?,?)",
//         [id, newTodoList.task , newTodoList.checked]);
//     return raw;
//   }

//   blockOrUnblock(TodoData todolist) async {
//     final db = await database;
//     TodoData blocked = TodoData(
//         id: todolist.id,
//         task: todolist.task,
//         checked: todolist.checked);
//     var res = await db.update("TodoData", blocked.toMap(),
//         where: "id = ?", whereArgs: [todolist.id]);
//     return res;
//   }

//   updateTodoList(TodoData newTodoList) async {
//     final db = await database;
//     var res = await db.update("TodoData", newTodoList.toMap(),
//         where: "id = ?", whereArgs: [newTodoList.id]);
//     return res;
//   }

//   getTodoList(int id) async {
//     final db = await database;
//     var res = await db.query("TodoData", where: "id = ?", whereArgs: [id]);
//     return res.isNotEmpty ? TodoData.fromMap(res.first) : null;
//   }

//   Future<List<TodoData>> getBlockedTodoLists() async {
//     final db = await database;

//     print("works");
//     // var res = await db.rawQuery("SELECT * FROM TodoList WHERE blocked=1");
//     var res = await db.query("TodoData", where: "blocked = ? ", whereArgs: [1]);

//     List<TodoData> list =
//         res.isNotEmpty ? res.map((c) => TodoData.fromMap(c)).toList() : [];
//     return list;
//   }

//   Future<List<TodoData>> getAllTodoLists() async {
//     final db = await database;
//     var res = await db.query("TodoData");
//     List<TodoData> list =
//         res.isNotEmpty ? res.map((c) => TodoData.fromMap(c)).toList() : [];
//     return list;
//   }

//   deleteTodoList(int id) async {
//     final db = await database;
//     return db.delete("TodoData", where: "id = ?", whereArgs: [id]);
//   }

//   deleteAll() async {
//     final db = await database;
//     db.rawDelete("Delete * from TodoData");
//   }
// }
