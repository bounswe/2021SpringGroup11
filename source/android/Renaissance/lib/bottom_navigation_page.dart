import 'package:flutter/material.dart';
import 'package:portakal/activity_stream.dart';
import 'package:portakal/create_path.dart';
import 'package:portakal/home_page.dart';
import 'package:portakal/login_page.dart';
import 'package:portakal/models/user.dart';
import 'package:portakal/my_colors.dart';
import 'package:portakal/search_page.dart';
import 'explore_page.dart';
import 'profile_page.dart';
import 'path_page.dart';
import 'package:portakal/models/topic_model.dart';
import 'package:portakal/models/milestone_model.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  final _homeScreen = GlobalKey<NavigatorState>();
  final _exploreScreen = GlobalKey<NavigatorState>();
  final _addScreen = GlobalKey<NavigatorState>();
  final _notificationScreen = GlobalKey<NavigatorState>();
  final _profileScreen = GlobalKey<NavigatorState>();

  //static List<Widget> pages

  void _onItemTapped(int index, BuildContext context) {
    if (_selectedIndex == index) {
      // pop until root
    } else if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          Navigator(
            key: _homeScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
                builder: (context) => HomePage(), settings: route),
          ),
          Navigator(
            key: _exploreScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
                builder: (context) => SearchPage(), settings: route),
          ),
          Navigator(
            key: _addScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
                builder: (context) => CreatePathPage(), settings: route),
          ),
          Navigator(
            key: _notificationScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
                builder: (context) => ActivityStreamPage(), settings: route),
          ),
          Navigator(
            key: _profileScreen,
            onGenerateRoute: (route) => MaterialPageRoute(
                builder: (context) => ProfilePage(user: User.me!),
                settings: route),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (val) => _onItemTapped(val, context),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        iconSize: 36,
        backgroundColor: MyColors.blue,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: MyColors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
            backgroundColor: MyColors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add a path',
            backgroundColor: MyColors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: MyColors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: MyColors.blue,
          ),
        ],
      ),
    );
  }
}
