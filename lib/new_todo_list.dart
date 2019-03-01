// import 'package:flutter/material.dart';
// import 'package:app_lucas/layout_type.dart';
// import 'package:app_lucas/main_app_bar.dart';


// class Todo {

//   Todo({this.title, this.isDone = false});
//   String title;
//   bool isDone;

// }

// class TodoListPage extends StatelessWidget implements HasLayoutGroup {
//   TodoListPage({Key key, this.layoutGroup, this.onLayoutToggle}) : super(key: key);
//   final LayoutGroup layoutGroup;
//   final VoidCallback onLayoutToggle;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MainAppBar(
//         layoutGroup: layoutGroup,
//         layoutType: LayoutType.todo,
//         onLayoutToggle: onLayoutToggle,
//       ),
//       body: Container(
//         child: _buildContent(),
//       ),
//     );
//   }
  
//   Widget _buildContent() {
//     return ListView.builder(
//         itemCount: .length,
//         itemBuilder: (BuildContext content, int index) {
//           Contact contact = allContacts[index];
//           return ContactListTile(contact);
//         });
//   }

// }