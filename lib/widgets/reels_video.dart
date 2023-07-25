import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:video_reels_player/widgets/qreels_widgets.dart';
import 'package:video_reels_player/widgets/video_player_fullscreen_widget.dart';

class ReelsVideo extends StatefulWidget {
  final String src;

  const ReelsVideo({super.key, required this.src});

  @override
  State<ReelsVideo> createState() => _ReelsVideoState();
}

class _ReelsVideoState extends State<ReelsVideo> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        widget.src))
      ..initialize().then((value) {
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
        _videoPlayerController.setVolume(1);
        setState(() {
        });
      });
    // initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    // _chewieController.dispose();
    super.dispose();
  }

  Future initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.src));
    await Future.wait([_videoPlayerController.initialize()]);
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        showControls: false,
        fullScreenByDefault: true,
        allowFullScreen: true,
        allowMuting: false,
        allowPlaybackSpeedChanging: false,
        allowedScreenSleep: false,
        showOptions: false,
        looping: true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerFullscreenWidget(controller: _videoPlayerController);

      _videoPlayerController.value.isInitialized
            ? AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController),
        )
            : const Center(child: CircularProgressIndicator(color: Colors.white,backgroundColor: Colors.black,),);
  }
}
