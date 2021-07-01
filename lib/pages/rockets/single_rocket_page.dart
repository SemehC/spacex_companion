import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:spacex_companion/models/spacex_rocket.dart';
import 'package:spacex_companion/pages/rockets/single_rocket_general_info.dart';
import 'package:spacex_companion/pages/rockets/single_rocket_images.dart';

class SingleRocketPage extends StatefulWidget {
  SingleRocketPage({Key? key, required this.rocket}) : super(key: key);
  final SpaceXRocket rocket;

  @override
  _SingleRocketPageState createState() => _SingleRocketPageState();
}

class _SingleRocketPageState extends State<SingleRocketPage> {
  PageController _pagesController = PageController();

  int _currentIndex = 0;

  handlePageChange(int i) async {
    _pagesController.animateToPage(i,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);

    setState(() => _currentIndex = i);
  }

  buildBottomNavBar() {
    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) {
        handlePageChange(i);
      },
      items: [
        SalomonBottomBarItem(
          icon: Icon(LineIcons.info),
          title: Text("General Info"),
          selectedColor: Colors.blue,
        ),
        SalomonBottomBarItem(
          icon: Icon(LineIcons.image),
          title: Text("Images"),
          selectedColor: Colors.blue,
        ),
        SalomonBottomBarItem(
          icon: Icon(LineIcons.video),
          title: Text("Videos"),
          selectedColor: Colors.blue,
        ),
      ],
    );
  }

  buildLaunchAppBar() {
    return AppBar(
      title: Text(widget.rocket.name),
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
          SingelRocketGeneralInfo(rocket: widget.rocket),
          SingleRocketImages(rocket: widget.rocket),
          Text(""),
        ],
      ),
    );
  }
}
