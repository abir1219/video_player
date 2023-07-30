import 'dart:convert';

import 'package:get/get.dart';

import 'model/reels_model.dart';

class ReelsController extends GetxController {
  RxList<Images> imageList = <Images>[].obs;
  RxList<Videos> videoList = <Videos>[].obs;
  RxList<Mcq> mcqList = <Mcq>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    String jsonString = '''{ 
      "images":[
        {"imageUrl": "https://wallpapercave.com/wp/wp3246752.jpg"},
        {"imageUrl": "https://wallpapercave.com/wp/wp3246751.jpg"},
        {"imageUrl": "https://wallpapercave.com/wp/wp3246753.jpg"}
      ],
  "videos":[
    {"videoUrl":"https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4"},
    {"videoUrl":"https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4"},
  {"videoUrl":"https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4"}
  ],
  "mcq":[
    {
      "question": "What is the capital of France?",
      "options": ["London", "Paris", "Berlin", "Madrid"],
      "correctAnswerIndex": 1
    },
    {
      "question": "Which planet is known as the 'Red Planet'?",
      "options": ["Venus", "Mars", "Jupiter", "Neptune"],
      "correctAnswerIndex": 1
    },
    {
      "question": "What is the chemical symbol for water?",
      "options": ["H2O", "CO2", "O2", "NaCl"],
      "correctAnswerIndex": 0
    }
  ]
}''';

    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    List<dynamic> imageData = jsonData['images'];
    List<dynamic> videoData = jsonData['videos'];
    List<dynamic> mcqData = jsonData['mcq'];

    imageList.assignAll(
        imageData.map((data) => Images(imageUrl: data['imageUrl'])).toList());

    videoList.assignAll(
        videoData.map((data) => Videos(videoUrl: data['videoUrl'])).toList());

    mcqList.assignAll(
      mcqData
          .map((data) => Mcq(
                question: data['question'],
                options: List<String>.from(data['options']),
                correctAnswerIndex: data['correctAnswerIndex'],
              ))
          .toList(),
    );
  }
}
