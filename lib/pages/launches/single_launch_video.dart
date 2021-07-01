import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spacex_companion/models/spacex_launch.dart';
import 'package:spacex_companion/widgets/my_animations.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class SingleLaunchVideo extends StatefulWidget {
  SingleLaunchVideo({Key? key, required this.launch}) : super(key: key);
  final SpaceXLaunch launch;
  @override
  _SingleLaunchVideoState createState() => _SingleLaunchVideoState();
}

class _SingleLaunchVideoState extends State<SingleLaunchVideo>
    with AutomaticKeepAliveClientMixin {
  late YoutubePlayerController _controller;
  bool _initializedVideo = false;

  @override
  void initState() {
    super.initState();
    fetchVideoStream();
  }

  @override
  void dispose() {
    if (_initializedVideo) _controller.stop();

    super.dispose();
  }

  fetchVideoStream() async {
    if (widget.launch.links['youtube_id'] != null) {
      _controller = YoutubePlayerController(
        initialVideoId: widget.launch.links['youtube_id'],
        params: YoutubePlayerParams(
          desktopMode: false,
          showControls: true,
          showFullscreenButton: true,
        ),
      );
      setState(() {
        _initializedVideo = true;
      });
    }
  }

  buildVideoPage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.launch.name,
            style: TextStyle(fontSize: 22),
          ),
          SizedBox(height: 22),
          _initializedVideo
              ? Padding(
                  padding:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? const EdgeInsets.all(5.0)
                          : const EdgeInsets.all(50.0),
                  child: YoutubePlayerIFrame(
                    controller: _controller,
                    aspectRatio: 16 / 9,
                  ),
                )
              : Text("Loading"),
          SizedBox(height: 22),
          TextButton.icon(
              onPressed: () => print("Down"),
              icon: Icon(Icons.download),
              label: Text("Download video")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _initializedVideo ? buildVideoPage() : MyAnimations.noVideosFound();
  }

  @override
  bool get wantKeepAlive => true;
}
