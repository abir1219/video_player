
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_reels_player/screens/new_reels.dart';
import 'package:video_reels_player/screens/q_reels.dart';

import 'binding/controller_binding.dart';

void main() {
  runApp(
      // DevicePreview(
      //   enabled: true,
      //   builder: (BuildContext context) =>
        const MyApp(),
      // )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375,812),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Video Reels',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home:const QReels(), //NewReels(),//const QReels(),
          initialBinding: ControllerBinding(),
        );
      },
    );
  }
}
