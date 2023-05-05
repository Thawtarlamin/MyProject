import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:go2tv/Screen/LiveMatch.dart';
import 'package:go2tv/Screen/LiveScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
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
      backgroundColor: Colors.black87,
      body: Container(
        child: Column(children: [
          Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                color: Colors.black87,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.tv,
                          color: Colors.white,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Go2Tv",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Expired Date",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "30-05-2024",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "12:00:00",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                color: Colors.black87,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Rows(context),
                    SizedBox(
                      height: 80,
                    ),
                    Rows2(context)
                  ],
                ),
              )),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.black87,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Dates("Day", "400"),
                      SizedBox(
                        width: 10,
                      ),
                      Dates("Hour", "20"),
                      SizedBox(
                        width: 10,
                      ),
                      Dates("Minute", "09"),
                      SizedBox(
                        width: 10,
                      ),
                      Dates("Second", "59")
                    ],
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}

Widget Rows2(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      GestureDetector(
          onTap: () {}, child: Iconss("IPTV", Icons.wifi_channel_sharp)),
      SizedBox(
        width: 2,
        height: 40,
        child: Container(
          color: Colors.white,
        ),
      ),
      GestureDetector(onTap: () {}, child: Iconss("Web", Icons.web)),
      SizedBox(
        width: 2,
        height: 40,
        child: Container(
          color: Colors.white,
        ),
      ),
      GestureDetector(onTap: () {}, child: Iconss("About", Icons.help)),
    ],
  );
}

Widget Rows(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LiveScreen()));
          },
          child: Iconss("Live", Icons.live_tv)),
      SizedBox(
        width: 2,
        height: 40,
        child: Container(
          color: Colors.white,
        ),
      ),
      GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LiveMatch()));
          },
          child: Iconss("Match", Icons.tv)),
      SizedBox(
        width: 2,
        height: 40,
        child: Container(
          color: Colors.white,
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Iconss("Movies", Icons.movie_creation),
      ),
      SizedBox(
        width: 2,
        height: 40,
        child: Container(
          color: Colors.white,
        ),
      ),
      GestureDetector(
        onTap: () {},
        child: Iconss("Highlights", Icons.highlight),
      ),
      SizedBox(
        width: 2,
        height: 40,
        child: Container(
          color: Colors.white,
        ),
      ),
      GestureDetector(onTap: () {}, child: Iconss("Adult", Icons.eighteen_mp)),
    ],
  );
}

Widget Iconss(String text, IconData icons) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Icon(
          icons,
          color: Colors.white,
          size: 30,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ],
    ),
  );
}

Widget Dates(String text, String number) {
  return Column(
    children: [
      Text(
        number,
        style: TextStyle(color: Colors.white),
      ),
      Text(
        text,
        style: TextStyle(color: Colors.white),
      )
    ],
  );
}
