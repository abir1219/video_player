import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:video_reels_player/widgets/video_player_fullscreen_widget.dart';

class ReelsVideo extends StatefulWidget {
  final String src;

  const ReelsVideo({super.key, required this.src});

  @override
  State<ReelsVideo> createState() => _ReelsVideoState();
}

class _ReelsVideoState extends State<ReelsVideo> {
  late VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = null;
    _initializePlayer();
    super.initState();
    /*_videoPlayerController =
    VideoPlayerController.networkUrl(Uri.parse(widget.src))
      ..initialize().then((value) {
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
        _videoPlayerController.setVolume(1);
        setState(() {});
      });*/
    // initializePlayer();
  }

  Future<void> _initializePlayer() async {
    final fileInfo = await checkCacheFor(widget.src);
    if (fileInfo == null) {
      debugPrint("File Info: Null}");
      if (!widget.src.contains(".jpg")) {
        _videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(widget.src));
        await _videoPlayerController!.initialize().then((value) {
          cachedForUrl(widget.src);
          _videoPlayerController!.play();
          _videoPlayerController!.setLooping(true);
          _videoPlayerController!.setVolume(1);
          setState(() {});
        });
      }else{
        cachedForUrl(widget.src);
      }
    } else {
      final file = fileInfo!.file;
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
    return !widget.src.contains(".jpg")
        ? (_videoPlayerController != null)
            ? ((_videoPlayerController!.value.isInitialized)
                ? VideoPlayerFullscreenWidget(
                    controller: _videoPlayerController!)
                : const Text('Loading...'))
            : const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                ),
              )
        //VideoPlayerFullscreenWidget(controller: _videoPlayerController)
        : SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              widget.src,
              fit: BoxFit.cover,
            ),
          );

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
  Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

//:cached Url Data
  void cachedForUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value) {
      print('downloaded successfully done for $url');
    });
  }
}
