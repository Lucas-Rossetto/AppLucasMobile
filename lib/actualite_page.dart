// import 'package:flutter/material.dart';

// void main() => runApp(new MyApp());

// class Constant{
//   static String base_url = "https://newsapi.org";
//   static String key = "apiactu"; 
// }

// class MyApp extends StatelessWidget {

// @override
// Widget build(BuildContext context){

// new Card(
//     elevation: 3.0,
//     child: new GestureDetector(
//       child: new Container(
//         child: Column(
//           children: <Widget>[
//             new Padding(
//               padding: EdgeInsets.all(15.0),
//               child: Text(
//                 "BitCoin",
//                 style: TextStyle(
//                     fontSize: 50.0, color: Colors.blueGrey),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//       onTap: () {
//         var id = 1;
//         Navigator.push(
//             context,
//             new MaterialPageRoute(
//               builder: (BuildContext context) =>
//                   new NewsFeedPage(id),
//             ));
//       },
//     )
//   );
// }

// Future<List<News>> fatchNews(http.Client client, id) async {
//   String url;
//   if (id == 1) {
//     url = Constant.base_url +
//         "everything?q=bitcoin&sortBy=publishedAt&apiKey=" +
//         Constant.key;
// }
//   final response = await client.get(url);
//   return compute(parsenews, response.body);
// }