import 'package:flutter/material.dart';
import '../Screens/myfavorite.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final List<Map<String, Object>> pages = [
    {'page': MyHomePage(), 'title': 'Home'},
    {'page': MyFavorite(), 'title': "Favoreite"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[index]['title']),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text("Favorite"))
        ],
      ),
      body: pages[index]['page'],
    );
  }
}
// Container(
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child: Container(
//             color: Colors.green,
//           ),
//         ),
//       ),
