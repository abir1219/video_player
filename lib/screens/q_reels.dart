import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_reels_player/widgets/reels_video.dart';

import '../widgets/qreels_widgets.dart';

class QReels extends StatefulWidget {
  const QReels({super.key});

  @override
  State<QReels> createState() => _QReelsState();
}

class _QReelsState extends State<QReels> {
  final List<String> videos = [
    'http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4',
    'http://www.exit109.com/~dnn/clips/RW20seconds_2.mp4',
    'http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4',
    'http://www.exit109.com/~dnn/clips/RW20seconds_2.mp4',
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: Swiper(
          itemHeight: MediaQuery.of(context).size.height,
          itemCount: videos.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                ReelsVideo(src: videos[index]),
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
