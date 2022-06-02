import 'package:flutter/material.dart';

void main() => runApp(const tabBar());

class tabBar extends StatelessWidget {
  const tabBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarWidget(),
    );
  }
}

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key key}) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetWidgetState();
}

class _TabBarWidgetWidgetState extends State<TabBarWidget> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Color(0xfff79c4f)),
            ),
            Text('',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xfff79c4f)))
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/home.png'),

            ),

            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/home.png"),
             //color: Color(0xFF3A5A98),
            ),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/home.png"),
              //color: Color(0xFF3A5A98),
            ),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/home.png"),
              //color: Color(0xFF3A5A98),
            ),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/images/home.png"),
              //color: Color(0xFF3A5A98),
            ),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );

  }
}



