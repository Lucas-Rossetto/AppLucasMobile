// import 'package:flutter/material.dart';
// import 'package:app_lucas/layout_type.dart';
// import 'package:app_lucas/rss_feed_page.dart';

// class MainPage extends StatefulWidget {
//   MainPage({Key key}) : super(key: key);

//   @override
//   _MainPageState createState() => new _MainPageState();
// }

// class _MainPageState extends State<MainPage> {

//   LayoutGroup _layoutGroup = LayoutGroup.scrollable;
//   LayoutType _layoutSelection1 = LayoutType.rss;


//   void _onLayoutGroupToggle() {
//     setState(() {
//       _layoutGroup = LayoutGroup.scrollable;
//     });
//   }

//   void _onLayoutSelected(LayoutType selection) {
//     setState(() {
//       _layoutSelection1 = selection;
//     });
//   }

//   void _onSelectTab(int index){
//     if (_layoutGroup ==LayoutGroup.scrollable){
//     switch (index) {
//       case 0:
//         _onLayoutSelected(LayoutType.rss);
//         break;
//       case 1:
//         _onLayoutSelected(LayoutType.todo);
//         break;
//       case 2:
//         _onLayoutSelected(LayoutType.actuality);
//         break;
//       case 3:
//         _onLayoutSelected(LayoutType.whatEver);
//         break;      

//     }
//     }
//   }

//   Color _colorTabMatching({LayoutType layoutSelection}) {
//     //if (_layoutGroup == LayoutGroup.scrollable) {
//       return _layoutSelection1 == layoutSelection ? Colors.orange : Colors.grey;
//     //} 
//   }


//   BottomNavigationBarItem _buildItem(
//       {IconData icon, LayoutType layoutSelection}) {
//     String text = layoutName(layoutSelection);
//     return BottomNavigationBarItem(
//       icon: Icon(
//         icon,
//         color: _colorTabMatching(layoutSelection: layoutSelection),
//       ),
//       title: Text(
//         text,
//         style: TextStyle(
//           color: _colorTabMatching(layoutSelection: layoutSelection),
//         ),
//       ),
//     );
//   }

//   Widget _buildBody() {
//     LayoutType layoutSelection = _layoutSelection1;
//       switch (layoutSelection) {
//         case LayoutType.rss:
//           return null;
//       //      return RSSFeedPage(layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
//         case LayoutType.todo:
//           return TodoListPage(layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
//         case LayoutType.actuality:
//           return ActualityPage(layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
//         case LayoutType.whatEver:
//           return WhatEverPage(layoutGroup: _layoutGroup, onLayoutToggle: _onLayoutGroupToggle);
//     }
//     return null;


//   }

//   Widget _buildBottomNavigationBar() {
//        return BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: [
//           _buildItem(
//               icon: Icons.rss_feed, layoutSelection: LayoutType.rss),
//           _buildItem(
//               icon: Icons.list, layoutSelection: LayoutType.todo),
//           _buildItem(icon: Icons.arrow_drop_down_circle, layoutSelection: LayoutType.actuality),
//           _buildItem(
//               icon: Icons.watch_later, layoutSelection: LayoutType.whatEver),
//         ],
//         onTap: _onSelectTab,
//       );
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildBody(),
//       bottomNavigationBar: _buildBottomNavigationBar(),
//     );
//   }


// }
