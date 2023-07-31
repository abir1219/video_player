import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_reels_player/controller/reels_controller.dart';
import 'package:video_reels_player/screens/page_one.dart';
import 'package:video_reels_player/widgets/video_player_fullscreen_widget.dart';

import '../model/reels_model.dart';

class ReelsVideo extends StatefulWidget {
  final dynamic src;

  final List<Images> images;
  final List<Videos> videos;
  final List<Mcq> mcq;

  const ReelsVideo(
      {super.key,
      this.src,
      required this.images,
      required this.videos,
      required this.mcq});

  @override
  State<ReelsVideo> createState() => _ReelsVideoState();
}

class _ReelsVideoState extends State<ReelsVideo> {
  late VideoPlayerController? _videoPlayerController;
  List<File> imageFile = [];

  var controller = Get.find<ReelsController>();

  @override
  void initState() {
    _videoPlayerController = null;
    /*if (widget.src != null) {
      _initializePlayer();
    }*/
    if (widget.videos.isNotEmpty) {
      _initializePlayer();
    }
    super.initState();
    /*_videoPlayerController =
    VideoPlayerController.networkUrl(Uri.parse(widget.src!))
      ..initialize().then((value) {
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
        _videoPlayerController.setVolume(1);
        setState(() {});
      });*/
    // initializePlayer();
  }

  Future<void> _initializePlayer() async {
    debugPrint(
        "VIDEO[${controller.index.value}] => ${widget.videos[controller.index.value].videoUrl!}");

    if (widget.videos.isNotEmpty) {
      final fileInfo =
          await checkCacheFor(widget.videos[controller.index.value].videoUrl);
      // debugPrint("File Info=>${fileInfo}");
      if (fileInfo == null) {
        debugPrint("File Info: Null}");
        _videoPlayerController = VideoPlayerController.networkUrl(
            Uri.parse(widget.videos[controller.index.value].videoUrl!));
        await _videoPlayerController!.initialize().then((value) {
          cachedForUrl(widget.videos[controller.index.value].videoUrl);
          _videoPlayerController!.play();
          _videoPlayerController!.setLooping(true);
          _videoPlayerController!.setVolume(1);
          setState(() {});
        });
      } else {
        final file = fileInfo.file;
        debugPrint("File Info: ${fileInfo.file.basename}");
        _videoPlayerController = VideoPlayerController.file(file);
        await _videoPlayerController!.initialize().then((value) {
          _videoPlayerController!.play();
          _videoPlayerController!.setLooping(true);
          _videoPlayerController!.setVolume(1);
          setState(() {});
        });
      }
    }
  }

  @override
  void dispose() {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }
    // _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.mcq.isNotEmpty){
      return const PageOne();
    }

    if(_videoPlayerController != null && _videoPlayerController!.value.isInitialized){
     return VideoPlayerFullscreenWidget(controller: _videoPlayerController!);
    }

    return Container();


     // return PageOne();
    /*return (_videoPlayerController != null)
        ? ((_videoPlayerController!.value.isInitialized)
            ? VideoPlayerFullscreenWidget(controller: _videoPlayerController!)
            : const Text('Loading...'))
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
            ),
          );*/

    /*_videoPlayerController!.value.isInitialized
        ? AspectRatio(
            aspectRatio: _videoPlayerController!.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController!),
          )
        : const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              backgroundColor: Colors.black,
            ),
          );*/
  }

  //: check for cache
  Future<FileInfo?> checkCacheFor(String? url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url!);
    return value;
  }

//:cached Url Data
  void cachedForUrl(String? url) async {
    await DefaultCacheManager().getSingleFile(url!).then((value) {
      print('downloaded successfully done for $url');
    });
  }
}
