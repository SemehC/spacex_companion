import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:spacex_companion/models/spacex_launch.dart';
import 'package:spacex_companion/pages/launches/single_launch_images.dart';
import 'package:spacex_companion/pages/launches/single_launch_general_info.dart';
import 'package:spacex_companion/pages/launches/single_launch_video.dart';

class SingleLaunchPage extends StatefulWidget {
  SingleLaunchPage({Key? key, required this.launch}) : super(key: key);
  final SpaceXLaunch launch;
  @override
  _SingleLaunchPageState createState() => _SingleLaunchPageState();
}

class _SingleLaunchPageState extends State<SingleLaunchPage> {
  PageController _pagesController = PageController();

  int _currentIndex = 0;

  handlePageChange(int i) async {
    _pagesController
        .animateToPage(i,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut)
        .then((value) {
      if (i == 2) {
        print("Changing rotation ");
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      }
    });
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
      title: Text(widget.launch.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildLaunchAppBar(),
      bottomNavigationBar: buildBottomNavBar(),
      body: PageView(
        controller: _pagesController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SingleLaunchGeneralInfo(launch: widget.launch),
          SingleLaunchImages(launch: widget.launch),
          SingleLaunchVideo(launch: widget.launch),
        ],
      ),
    );
  }
}
