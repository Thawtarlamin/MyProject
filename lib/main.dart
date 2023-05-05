import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullscreen/fullscreen.dart';
import 'Screen/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));
  });
}
