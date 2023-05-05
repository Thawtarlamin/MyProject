import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fullscreen/fullscreen.dart';
import 'package:go2tv/Screen/Colum.dart';
import 'package:go2tv/Screen/IframePlayer.dart';

import '../Http/Api.dart';
import '../Modal/MatchModal.dart';
import '../Modal/QualityModal.dart';

class LiveMatch extends StatefulWidget {
  const LiveMatch({super.key});

  @override
  State<LiveMatch> createState() => _LiveMatchState();
}

class _LiveMatchState extends State<LiveMatch> {
  List<MatchModal> _list = [];
  List<QualityModal> _lists = [];
  late bool bol = false;
  @override
  void initState() {
    loading();
    // TODO: implement initState
    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    super.initState();
  }

  loadingQuality(String id) async {
    List<QualityModal> list = await Api.getLink(id);
    if (list.isNotEmpty) {
      setState(() {
        this._lists = list;
      });
    }
  }

  loading() async {
    List<MatchModal> list = await Api.getAllMatchs();
    if (list.isNotEmpty) {
      setState(() {
        this._list = list;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: SystemUiOverlay.values);
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
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(2)),
              child: Row(
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      child: ListView.builder(
                          itemCount: _list.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Quality(_list[index].matchId, context);

                                loadingQuality(_list[index].matchId);
                                setState(() {
                                  bol = true;
                                  _lists.add(new QualityModal(
                                      quality: "Sorry!Link is not availible",
                                      link: ''));
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.black),
                                  margin: const EdgeInsets.all(5.0),
                                  child: match(_list[index])),
                            );
                          }),
                    ),
                  ),
                  Visibility(
                    visible: bol,
                    child: Expanded(
                        child: Container(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: _lists.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (_lists[index].link.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => IframePlayer(
                                                url: _lists[index]
                                                    .link
                                                    .toString())));
                                  }
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: Text(
                                                _lists[index].quality,
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget match(MatchModal modal) {
    Color color = Colors.yellow;
    if (modal.status == "Live") {
      color = Colors.red;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 2),
          child: Text(
            modal.league,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
        Match(modal.home_flag, modal.home_name, modal.time, modal.away_flag,
            modal.away_name),
        Container(
          margin: const EdgeInsets.only(bottom: 2),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(5.0)),
          child: Text(
            modal.status,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget Match(String homeurl, homename, time, awayurl, awayname) {
    if (homename.contains(' ')) {
      homename = homename.replaceAll(" ", "\n");
    }
    if (awayname.contains(' ')) {
      awayname = awayname.replaceAll(" ", "\n");
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Colum(url: homeurl, name: homename),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(5.0)),
          child: Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Colum(url: awayurl, name: awayname)
      ],
    );
  }
}

Quality(String id, context) async {
  List<QualityModal> list = await Api.getLink(id);
  if (list.isNotEmpty) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text("Options!"),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  return SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                      // print(list[index].link);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => IframePlayer(url: list[index].link,)));
                    },
                    child: Center(
                        child: ListTile(
                      title: Text(list[index].quality),
                    )),
                  );
                },
                itemCount: list.length,
              ),
            )
          ],
        );
      },
    );
  }
}
