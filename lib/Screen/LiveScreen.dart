import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:go2tv/Modal/CategoryModal.dart';
import 'package:go2tv/Modal/SubCategoryModal.dart';
import 'package:go2tv/Screen/VideoPlayer.dart';
import '../Http/Api.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  late bool bol = false;
  List<CategoryModal> _list = [];
  List<SubCategoryModal> _listy = [];

  loading() async {
    var response = await Api.getCategory();
    List<CategoryModal> list = response as List<CategoryModal>;

    setState(() {
      _list = list;
    });
  }

  SubLoading(String url) async {
    var response = await Api.getSubCategory(url);
    List<SubCategoryModal> list = response as List<SubCategoryModal>;
    setState(() {
      _listy = list;
    });
  }

  @override
  void initState() {
    loading();
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
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight
              ]);
              Navigator.pop(context);
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(color: Colors.black87),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    color: Colors.black87,
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: _list.length,
                          itemBuilder: (context, index) {
                            var thumb = _list[index].thumb.toString();
                            if (thumb.isEmpty) {
                              thumb = 'https://i.imgur.com/Jo3Dqvh.jpg';
                            }
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  bol = true;
                                });
                                SubLoading(_list[index].m3u_link);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(2)),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Image.network(
                                              thumb,
                                              width: 30,
                                              height: 30,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.network(
                                                  'https://i.imgur.com/Jo3Dqvh.jpg',
                                                  width: 30,
                                                  height: 30,
                                                );
                                              },
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: Text(
                                              _list[index].title.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            );
                          }),
                    ),
                  )),
                  Visibility(
                    visible: bol,
                    child: Expanded(
                        child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black87,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: _listy.length,
                            itemBuilder: (context, index) {
                              var thumb = _listy[index].thumbSquare.toString();
                              if (thumb.isEmpty) {
                                thumb = 'https://i.imgur.com/Jo3Dqvh.jpg';
                              }
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoPlayer(
                                              url: _listy[index]
                                                  .mediaUrl
                                                  .toString())));
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                thumb,
                                                width: 30,
                                                height: 30,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.network(
                                                    'https://i.imgur.com/Jo3Dqvh.jpg',
                                                    width: 30,
                                                    height: 30,
                                                  );
                                                },
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Text(
                                                _listy[index].title.toString(),
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              );
                            }),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
