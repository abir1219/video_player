import 'package:flutter/material.dart';
import 'package:video_reels_player/screens/reels_carousel.dart';

class NewReels extends StatelessWidget {
  NewReels({super.key});
  final List<Map<String, dynamic>> images = [
    {"imageUrl": "https://wallpapercave.com/wp/wp3246752.jpg"},
    {"imageUrl": "https://wallpapercave.com/wp/wp3246751.jpg"},
    {"imageUrl": "https://wallpapercave.com/wp/wp3246753.jpg"}
  ];

  final List<Map<String, dynamic>> videos = [
    {
      "videoUrl":
      "https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4"
    },
    {
      "videoUrl":
      "https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4"
    },
    {
      "videoUrl":
      "https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reels'),
      ),
      body: ReelsCarousel(images: images, videos: videos),
    );
  }
}
