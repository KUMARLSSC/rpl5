import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_web_video_player/flutter_web_video_player.dart';

class VideoPage extends StatelessWidget {
  final String? url;
  const VideoPage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebVideoPlayer(
        src: url,
        autoPlay: true,
      ),
    );
  }
}
