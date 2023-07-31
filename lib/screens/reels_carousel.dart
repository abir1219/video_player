import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:video_reels_player/screens/quiz_screen.dart';

class ReelsCarousel extends StatefulWidget {
  final List<Map<String, dynamic>> images;
  final List<Map<String, dynamic>> videos;

  const ReelsCarousel({super.key, required this.images, required this.videos});

  @override
  State<ReelsCarousel> createState() => _ReelsCarouselState();
}

class _ReelsCarouselState extends State<ReelsCarousel> {
  late VideoPlayerController _controller;
  int _currentItem = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(widget.videos[_currentItem]["videoUrl"])
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              CarouselSlider(
                items: widget.images
                    .map((image) => Image.network(image["imageUrl"], fit: BoxFit.cover))
                    .toList(),
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentItem = index;
                      _controller.pause();
                      _controller = VideoPlayerController.network(widget.videos[_currentItem]["videoUrl"])
                        ..initialize().then((_) {
                          _controller.play();
                          _controller.setLooping(true);
                        });
                    });
                  },
                ),
              ),
              Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                    : Container(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images
              .asMap()
              .entries
              .map(
                (entry) => GestureDetector(
              onTap: () {
                setState(() {
                  _currentItem = entry.key;
                  _controller.pause();
                  _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videos[_currentItem]["videoUrl"]))
                    ..initialize().then((_) {
                      _controller.play();
                      _controller.setLooping(true);
                    });
                });
              },
              child: Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: entry.key == _currentItem ? Colors.blue : Colors.grey,
                ),
              ),
            ),
          )
              .toList(),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // Navigate to the next page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizScreen()),
            );
          },
          child: const Text("Take Quiz"),
        ),
      ],
    );
  }
}
