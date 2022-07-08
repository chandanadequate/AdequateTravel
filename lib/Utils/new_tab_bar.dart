import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(newTabBar());
}

class newTabBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(title: ''),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int selectedIndex = 0;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar.badge({3: ''},
        items: [
          TabItem(
              icon: ImageIcon(
            AssetImage("assets/images/home.png"),
            //color: Color(0xFF3A5A98),
          ), title: 'Home'),
          TabItem(icon: ImageIcon(
            AssetImage("assets/images/home.png"),
            //color: Color(0xFF3A5A98),
          ), title: 'Games'),
          TabItem(icon: ImageIcon(
            AssetImage("assets/images/home.png"),
            //color: Color(0xFF3A5A98),
          ), title: 'Apps'),
          TabItem(icon: Icons.movie, title: 'Movies'),
          TabItem(icon: Icons.book, title: 'Books'),
        ],
        onTap: onItemTapped,
        activeColor: Colors.amber,
        backgroundColor: Colors.grey,
      ),
    );
  }

  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

}