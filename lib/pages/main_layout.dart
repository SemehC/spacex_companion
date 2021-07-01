import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:spacex_companion/pages/launches_page.dart';
import 'package:spacex_companion/pages/rockets_page.dart';

class MainLayout extends StatefulWidget {
  MainLayout({Key? key}) : super(key: key);

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  PageController _pagesController = PageController();

  int _currentIndex = 0;

  buildBottomNavBar() {
    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) {
        _pagesController.animateToPage(i,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        setState(() => _currentIndex = i);
      },
      items: [
        SalomonBottomBarItem(
          icon: Icon(LineIcons.spaceShuttle),
          title: Text("Launches"),
          selectedColor: Colors.blue,
        ),
        SalomonBottomBarItem(
          icon: Icon(LineIcons.rocket),
          title: Text("rockets"),
          selectedColor: Colors.blue,
        ),
        SalomonBottomBarItem(
          icon: Icon(LineIcons.alternateLongArrowDown),
          title: Text("Pads"),
          selectedColor: Colors.blue,
        ),
        SalomonBottomBarItem(
          icon: Icon(LineIcons.dragon),
          title: Text("Dragons"),
          selectedColor: Colors.blue,
        ),
      ],
    );
  }

  buildDrawerSafeArea() {
    return Drawer(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              DrawerHeader(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/spacex_logo.jpg',
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(FontAwesomeIcons.rocket),
                title: Text('SpaceX'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(FontAwesomeIcons.satellite),
                title: Text('StarLink'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(FontAwesomeIcons.userAstronaut),
                title: Text('Crew'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(FontAwesomeIcons.ticketAlt),
                title: Text('FLight Ticket'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavBar(),
      body: PageView(
        controller: _pagesController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LaunchesPage(),
          RocketsPage(),
          Text(""),
          Text(""),
        ],
      ),
      drawer: buildDrawerSafeArea(),
    );
  }
}
