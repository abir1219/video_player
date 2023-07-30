import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:video_reels_player/reels_controller.dart';
import 'package:video_reels_player/screens/page_one.dart';
import 'package:video_reels_player/screens/page_two.dart';
import 'package:video_reels_player/widgets/reels_video.dart';

import '../widgets/qreels_widgets.dart';

class QReels extends StatefulWidget {
  const QReels({super.key});

  @override
  State<QReels> createState() => _QReelsState();
}

class _QReelsState extends State<QReels> {
  final List<dynamic> videos = [
    'https://assets.mixkit.co/videos/preview/mixkit-taking-photos-from-different-angles-of-a-model-34421-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-young-mother-with-her-little-daughter-decorating-a-christmas-tree-39745-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-mother-with-her-little-daughter-eating-a-marshmallow-in-nature-39764-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-winter-fashion-cold-looking-woman-concept-video-39874-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-womans-feet-splashing-in-the-pool-1261-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4',
    'https://wallpapercave.com/wp/wp3246752.jpg',
    'https://wallpapercave.com/wp/wp3246751.jpg',
    'https://wallpapercave.com/wp/wp3246753.jpg',
    // PageOne(),
    // PageTwo(),
  ];

  final List<Widget> pages = [
    const PageOne(),
    const PageTwo(),
  ];

  var controller = Get.find<ReelsController>();


  @override
  Widget build(BuildContext context) {
    debugPrint("Total Length=${controller.imageList.length+controller.imageList.length+controller.imageList.length}");

    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Swiper(
          itemHeight: MediaQuery.of(context).size.height,
          itemCount: videos.length,//controller.imageList.length+controller.imageList.length+controller.imageList.length,//videos.length,
          scrollDirection: Axis.vertical,
          autoplay: true,
         duration: 1500,
          // autoplayDelay: 3,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                ReelsVideo(src: videos[index]),
                // ReelsVideo(pages: pages[index]),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    footerTag(),
                    Container(
                      // height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(bottom: 100.w),
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          interactionWithUser(
                              icons: Icons.favorite_border,
                              count: "1.1k",
                              function: () {
                                debugPrint("Like");
                              }),
                          interactionWithUser(
                              icons: Icons.comment,
                              count: "1001",
                              function: () {
                                debugPrint("Comment");
                              }),
                          interactionWithUser(
                              icons: Icons.send,
                              count: "3.2k",
                              function: () {
                                debugPrint("Share");
                              }),
                          interactionWithUser(
                              icons: Icons.filter_alt_outlined,
                              function: () {
                                debugPrint("Share");
                              }),
                        ],
                      ),
                    )
                  ],
                ),

              ],);
          },
        ),
        //floatingActionButton: FloatingActionButton(onPressed: () {  },child: Icon(Icons.filter_alt_outlined,color: Colors.black,size: 24.w,),backgroundColor: Colors.white),
      ),
    );
  }
}
