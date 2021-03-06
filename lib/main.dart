import 'package:flutter_app/fab_with_icons.dart';
import 'package:flutter_app/fab_bottom_app_bar.dart';
import 'package:flutter_app/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/todolistDatabase.dart';
import 'package:flutter_app/todolist.dart';
import 'package:flutter_app/layout_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_app/myapp.dart';
import 'package:flutter_app/todoDetail.dart';
import 'package:flutter_app/rss_feed_page.dart';
import 'dart:math' as math;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // final Store<AppState> store = Store<AppState>(
  //   appReducer,
  //   initialState: AppState.initial(),
  //   middleware: createStoreMiddleware(),


final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  primaryColor: Colors.black,
  accentColor: Colors.black,
  brightness: Brightness.light,
);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
       theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: MyHomePage(title: 'Bienvenue !'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  LayoutType layoutType = LayoutType.rss;
  //TodoApp todoapp = new TodoApp();
  //BuildContext context;
   
   Color _colorTabMatching({LayoutType layoutSelection}) {
      return layoutType == layoutSelection ? Colors.orange : Colors.grey;
    }
  
   BottomNavigationBarItem _buildItem(
      {IconData icon, LayoutType layoutSelection}) {
    String text = layoutName(layoutSelection);
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: _colorTabMatching(layoutSelection: layoutSelection),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(layoutSelection: layoutSelection),
        ),
      ),
    );
  }


  Widget _buildBottomNavigationBar() {

      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(
              icon: Icons.rss_feed, layoutSelection: LayoutType.rss),
          _buildItem(
              icon: Icons.list, layoutSelection: LayoutType.todo),
          _buildItem(icon: Icons.list, layoutSelection: LayoutType.actuality),
          _buildItem(
              icon: Icons.list, layoutSelection: LayoutType.whatEver),
        ],
        onTap: _selectedTab,
      );
  }

  void _selectedTab(int index) {

     setState(() {
      switch(index){

        case 0:
          layoutType = LayoutType.rss;
          break;
        case 1:
          layoutType = LayoutType.todo;
          break;
        case 2:
          layoutType = LayoutType.actuality;
          break;
        case 3:
          layoutType = LayoutType.whatEver;
          break;
        default:
          return "Page d'accueil";    

      }

    });
  }
  //     if (index == 0) {
  //       _lastSelected = "Flux RSS";
      
  //     }

  //     if (index == 1) {
  //       return TodoApp();
  //     }

  //     if (index == 2) {
  //       _lastSelected = 'Fil d actualité';
  //     }

  //     if (index == 3) {
  //       _lastSelected = 'TAB: 1888';
  //     }

  //   });
  // }


  Widget _buildBody(){

    if(layoutType == LayoutType.rss){

      return RSSHomePage();
    }

    if(layoutType == LayoutType.todo){

      return TodoDetail();
      //return TodoList(this._todoData,"appBar");
    }

    if(layoutType == LayoutType.whatEver){
      return PhonePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
       ),

        body: _buildBody(),

      //   body: FutureBuilder<List<TodoData>>(
      //     future: DBProvider.db.getAllTodoLists(),
      //     builder: (BuildContext context, AsyncSnapshot<List<TodoData>> snapshot) {
      //       if (snapshot.hasData) {
      //          return ListView.builder(
      //         itemCount: snapshot.data.length,
      //         itemBuilder: (BuildContext context, int index) {
      //           TodoData item = snapshot.data[index];
      //           return Dismissible(
      //             key: UniqueKey(),
      //             background: Container(color: Colors.red),
      //             onDismissed: (direction) {
      //               DBProvider.db.deleteTodoList(item.id);
      //             },
      //             child: ListTile(
      //               title: new Text(item.task),
      //               leading: Text(item.id.toString()),
      //               trailing: Checkbox(
      //                 onChanged: (bool value) {
      //                   DBProvider.db.blockOrUnblock(item);
      //                   setState(() {});
      //                 },
      //                 value: item.checked,
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     } else {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
      
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async {
      //     TodoData rnd = testTodo[math.Random().nextInt(testTodo.length)];
      //     await DBProvider.db.newTodoList(rnd);
      //     setState(() {});
      //   },
//),
      bottomNavigationBar: _buildBottomNavigationBar(),
       
    );

  }
}

      //   child: new Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
            
              

      //     ],
          
      //     // style: TextStyle(fontSize: 32.0),
      //     // ),
        
      //   // ),
      //   ),
      // ),
   
//         // centerItemText: 'A',
//         color: Colors.grey,
//         selectedColor: Colors.red,
//         //notchedShape: CircularNotchedRectangle(),
//         onTabSelected: _selectedTab,
//         items: [
//           FABBottomAppBarItem(iconData: Icons.rss_feed, text: 'RSS'),
//           FABBottomAppBarItem(iconData: Icons.list, text: 'Todo list'),
//           FABBottomAppBarItem(iconData: Icons.list, text: 'Actualités'),
//           FABBottomAppBarItem(iconData: Icons.list, text: '???'),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       floatingActionButton: _buildFab(
//           context), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }






// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Widget titleSection = Container(
//       padding: const EdgeInsets.all(32),
//       child: Row(
//         children: [
//           Expanded(
//             /*1*/
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /*2*/
//                 Container(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: Text(
//                     'Oeschinen Lake Campground',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   'Kandersteg, Switzerland',
//                   style: TextStyle(
//                     color: Colors.grey[500],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           /*3*/
//           Icon(
//             Icons.star,
//             color: Colors.red[500],
//           ),
//           Text('41'),
//         ],
//       ),
//     );
//    
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//        title: 'Startup Name Generator',
// 	     home: RandomWords(),
//     );
//   }
// }

// class RandomWordsState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];
//   final _biggerFont = const TextStyle(fontSize: 18.0);

//   Widget _buildSuggestions() {
//     return ListView.builder(
//         padding: const EdgeInsets.all(16.0),
//         itemBuilder: /*1*/ (context, i) {
//           if (i.isOdd) return Divider(); /*2*/

//           final index = i ~/ 2; /*3*/
//           if (index >= _suggestions.length) {
//             _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//           }
//           return _buildRow(_suggestions[index]);
//         });
//   }

//   Widget _buildRow(WordPair pair) {
//     return ListTile(
//       title: Text(
//         pair.asPascalCase,
//         style: _biggerFont,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Startup Name Generator'),
//       ),
//       body: _buildSuggestions(),
//     );
//   }
// }

// class RandomWords extends StatefulWidget {
//   @override
//   RandomWordsState createState() => new RandomWordsState();
// }

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have clicked the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.display1,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }


