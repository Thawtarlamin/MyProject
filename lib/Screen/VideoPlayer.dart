import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class VideoPlayer extends StatefulWidget {
  final String url;

  const VideoPlayer({super.key, required this.url});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    Wakelock.enable();
    final String agent =
        "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.99 Safari/537.36";
    var refer = 'https://ntuplay.xyz/';
    var url = '';

    if (widget.url.contains('?|')) {
      var ary = widget.url.split('?|');
      url = ary[0];
      var a = ary[1].split('&');
      refer = a[0].replaceAll("Referer=", '');
      videoPlayerController = VideoPlayerController.network(
        url,
        httpHeaders: {'Referer': refer, 'User-Agent': agent},
      );
    } else {
      url = widget.url;
      videoPlayerController = VideoPlayerController.network(
        url,
      );
    }

    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // an arbitrary value, this can be whatever you need it to be

    double getScale() {
      double videoContainerRatio = 0.5;
      double videoRatio = videoPlayerController.value.aspectRatio;
      if (videoRatio < videoContainerRatio) {
        return videoContainerRatio / videoRatio;
      } else {
        return videoRatio / videoContainerRatio;
      }
    }

    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: getScale(),
        allowedScreenSleep: false,
        autoPlay: true,
        looping: false,
        isLive: true,
        startAt: const Duration(milliseconds: 1),
        showControls: true,
        allowFullScreen: false,
        autoInitialize: true,
        customControls: const CupertinoControls(
          backgroundColor: Colors.black,
          iconColor: Colors.red,
          showPlayButton: false,
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
        placeholder: Container(
            color: Colors.black87,
            child: Container(
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  )
                ],
              )),
            )));

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // TODO: implement dispose
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    return Scaffold(
      body: Container(
        child: Chewie(controller: chewieController),
      ),
    );
  }
}
