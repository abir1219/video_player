import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BasicOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const BasicOverlayWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
    children: <Widget>[
      buildPlay(),
      /*Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: buildIndicator(),
      ),*/
    ],
  );

  Widget buildIndicator() => VideoProgressIndicator(
    controller,
    allowScrubbing: false,
  );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
    alignment: Alignment.center,
    color: Colors.black26,
    child: const Icon(Icons.play_arrow, color: Colors.white, size: 80),
  );
}