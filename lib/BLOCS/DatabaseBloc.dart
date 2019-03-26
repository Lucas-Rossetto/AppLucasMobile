// import 'dart:async';

// import 'package:flutter_app/database.dart';
// import 'package:flutter_app/todolistDatabase.dart';

// class TodoBloc {
//   final _clientController = StreamController<List<TodoData>>.broadcast();

//   get todo => _clientController.stream;

//   dispose() {
//     _clientController.close();
//   }

//   getTodo() async {
//     _clientController.sink.add(await DBProvider.db.getAllTodoLists());
//   }

//    TodoBloc() {
//     getTodo();
//   }

//   blockUnblock(TodoData todo) {
//     DBProvider.db.blockOrUnblock(todo);
//     getTodo();
//   }

//   delete(int id) {
//     DBProvider.db.deleteTodoList(id);
//     getTodo();
//   }

//   add(TodoData todo) {
//     DBProvider.db.newTodoList(todo);
//     getTodo();
//   }
// }