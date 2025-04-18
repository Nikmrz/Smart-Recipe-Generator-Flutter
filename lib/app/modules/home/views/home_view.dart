import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import './Screens/pantry.dart' as firstTab;
import './Screens/home.dart' as secondTab;
import './Screens/favourite.dart' as thirdTab;
import './Screens/profile.dart' as fourthTab;
import './dailog/alert.dart' as alert;

class HomeView extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeView> {
  int _selectedIndex = 0; // Track the selected tab

  final List<Widget> _screens = [
    firstTab.Pantry(),
    secondTab.Home(),
    thirdTab.Favourite(),
    fourthTab.Profile(),
  ];

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Smart Chef    "),
            Image(
              image: AssetImage('./assets/icons/applogo.png'),
              fit: BoxFit.contain,
              height: 35,
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex, // Keeps state of all screens
        children: _screens,
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          FlashyTabBarItem(icon: Icon(Icons.food_bank), title: Text('Pantry')),
          FlashyTabBarItem(icon: Icon(Icons.home), title: Text('Home')),
          FlashyTabBarItem(icon: Icon(Icons.bookmark), title: Text('Favorites')),
          FlashyTabBarItem(icon: Icon(Icons.account_circle_outlined), title: Text('Profile')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert.Alert();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
