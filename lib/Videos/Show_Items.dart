import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:predent/HomeScreen/HomeScreen.dart';
import 'package:predent/JsonData/GetPost.dart';
import 'package:predent/JsonData/SubjectData.dart';
import 'package:predent/main.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:core';
import 'package:better_player/better_player.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:predent/Videos/Show_Items.dart';

late String subjectaccess;
int intialindex = 0;
double heightofpic = 150;
double widthofpic = 150;
Color buttonColor = Color(0xffD390EC);
late String cookie;

String ImagetoShow = "assests/7.png";
late String subjectname;
double bottomposition = 5;
late AppWrite AppWrite1;

class ShowItems extends StatefulWidget {
  const ShowItems({Key? key}) : super(key: key);

  @override
  _ShowItemsState createState() => _ShowItemsState();
}

class _ShowItemsState extends State<ShowItems>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  Future<dynamic>? fetchLec1;
  Future<dynamic>? fetchPrac1;
  Future<dynamic>? fetchLec2;
  Future<dynamic>? fetchPrac2;

  late BetterPlayerController _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(),
      betterPlayerDataSource: betterPlayerDataSource);
  late BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network, CurrentPlaying);

  late String UrlLec1;
  late String UrlLec2;
  late String UrlPrac1;
  late String UrlPrac2;
  var myvideo;
  late String CurrentPlaying = "";
  String VideoName = "Loading ..";

  @override
  void initState() {
    super.initState();
    betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, CurrentPlaying);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
    _tabController =
        new TabController(length: 4, vsync: this, initialIndex: intialindex);
    if (subjectaccess != "0000") {
      fetchLec1 = getJsonLec1();
      fetchLec2 = getJsonLec2();
      fetchPrac1 = getJsonPrac1();
      fetchPrac2 = getJsonPrac2();
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    _betterPlayerController.pause();
  }

  @override
  void dispose() {
    _betterPlayerController.pause();
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await onBackPressed();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.332,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.40,
                  child: FutureBuilder(
                    future:
                        currentButton == stats.Practical ? fetchLec2 : fetchLec1,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return BetterPlayer(
                          controller: _betterPlayerController,
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(20),
                      )),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        VideoName,
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          subjectname.capitalize(),
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xff5f5f5a)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 20),
              child: new Container(
                child: TabBar(
                  physics: BouncingScrollPhysics(),
                  isScrollable: true,
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Color(0xffA8A8A8),
                  indicator: DotIndicator(color: Colors.black, radius: 0),
                  tabs: [
                    Tab(
                      text: 'Lectures 1st',
                    ),
                    Tab(
                      text: 'Practical 1st',
                    ),
                    Tab(
                      text: 'Lectures 2nd',
                    ),
                    Tab(
                      text: 'Practical 2nd',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  FutureBuilder(
                      future: fetchLec1,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (subjectaccess[0] == "1") {
                          if (!snapshot.hasData) {
                            return Center(
                                child: Text("There Are No Videos Uploaded Until Now"));
                          }
                          if (snapshot.connectionState == ConnectionState.done) {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 120,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: widthofpic,
                                            height: heightofpic,
                                            child: Stack(
                                              children: [
                                                Image.asset(ImagetoShow),
                                                Positioned(
                                                  bottom: bottomposition,
                                                  right: 10,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        elevation: 8,
                                                        primary: buttonColor,
                                                        shape:
                                                            new CircleBorder()),
                                                    onPressed: () {
                                                      if (CurrentPlaying !=
                                                          dotenv.env[
                                                                  'END_POINT']! +
                                                              dotenv.env[
                                                                  'LIST_STORAGE_FILES']! +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'UrlNormalQuality'] +
                                                              "/view") {
                                                        setState(() {
                                                          VideoName = snapshot
                                                              .data
                                                              .documents[i]
                                                              .data['Name'];
                                                          CurrentPlaying = dotenv
                                                                      .env[
                                                                  'END_POINT']! +
                                                              dotenv.env[
                                                                  'LIST_STORAGE_FILES']! +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'UrlNormalQuality'] +
                                                              "/view";
                                                          if (snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'urlHighQuality'] ==
                                                              "null") {
                                                            betterPlayerDataSource =
                                                                BetterPlayerDataSource(
                                                                    BetterPlayerDataSourceType
                                                                        .network,
                                                                    CurrentPlaying,
                                                                    headers: {
                                                                  'X-Appwrite-Project':
                                                                      dotenv.env[
                                                                          'PROJECT_ID']!,
                                                                  'cookie':
                                                                      cookie,
                                                                });
                                                            _betterPlayerController =
                                                                BetterPlayerController(
                                                                    BetterPlayerConfiguration(),
                                                                    betterPlayerDataSource:
                                                                        betterPlayerDataSource);
                                                          } else {
                                                            betterPlayerDataSource =
                                                                BetterPlayerDataSource(
                                                                    BetterPlayerDataSourceType
                                                                        .network,
                                                                    CurrentPlaying,
                                                                    headers: {
                                                                  'X-Appwrite-Project':
                                                                      dotenv.env[
                                                                          'PROJECT_ID']!,
                                                                  'cookie':
                                                                      cookie,
                                                                },
                                                                    resolutions: {
                                                                  "Normal":
                                                                      CurrentPlaying,
                                                                  "HD": dotenv.env[
                                                                          'END_POINT']! +
                                                                      dotenv.env[
                                                                          'LIST_STORAGE_FILES']! +
                                                                      snapshot
                                                                          .data
                                                                          .documents[
                                                                              i]
                                                                          .data['UrlHighQuality'] +
                                                                      "/view",
                                                                });
                                                            _betterPlayerController =
                                                                BetterPlayerController(
                                                                    BetterPlayerConfiguration(),
                                                                    betterPlayerDataSource:
                                                                        betterPlayerDataSource);
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                                "${snapshot.data.documents[i].data['Name']}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        }
                        return Center(
                            child: Text("You have No Access for this part"));
                      }),
                  FutureBuilder(
                      future: fetchLec2,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (subjectaccess[1] == "1") {
                          if (!snapshot.hasData) {
                            return Center(
                                child: Text("There Are No Videos Uploaded Until Now"));
                          }
                          if (snapshot.connectionState == ConnectionState.done) {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 120,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: widthofpic,
                                            height: heightofpic,
                                            child: Stack(
                                              children: [
                                                Image.asset(ImagetoShow),
                                                Positioned(
                                                  bottom: bottomposition,
                                                  right: 10,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        elevation: 8,
                                                        primary: buttonColor,
                                                        shape:
                                                            new CircleBorder()),
                                                    onPressed: () {
                                                      if (CurrentPlaying !=
                                                          dotenv.env[
                                                                  'END_POINT']! +
                                                              dotenv.env[
                                                                  'LIST_STORAGE_FILES']! +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'UrlNormalQuality'] +
                                                              "/view") {
                                                        setState(() {
                                                          VideoName = snapshot
                                                              .data
                                                              .documents[i]
                                                              .data['Name'];
                                                          CurrentPlaying = dotenv
                                                                      .env[
                                                                  'END_POINT']! +
                                                              dotenv.env[
                                                                  'LIST_STORAGE_FILES']! +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'UrlNormalQuality'] +
                                                              "/view";
                                                          if (snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'urlHighQuality'] ==
                                                              "null") {
                                                            betterPlayerDataSource =
                                                                BetterPlayerDataSource(
                                                                    BetterPlayerDataSourceType
                                                                        .network,
                                                                    CurrentPlaying,
                                                                    headers: {
                                                                  'X-Appwrite-Project':
                                                                      dotenv.env[
                                                                          'PROJECT_ID']!,
                                                                  'cookie':
                                                                      cookie,
                                                                });
                                                            _betterPlayerController =
                                                                BetterPlayerController(
                                                                    BetterPlayerConfiguration(),
                                                                    betterPlayerDataSource:
                                                                        betterPlayerDataSource);
                                                          } else {
                                                            betterPlayerDataSource =
                                                                BetterPlayerDataSource(
                                                                    BetterPlayerDataSourceType
                                                                        .network,
                                                                    CurrentPlaying,
                                                                    headers: {
                                                                  'X-Appwrite-Project':
                                                                      dotenv.env[
                                                                          'PROJECT_ID']!,
                                                                  'cookie':
                                                                      cookie,
                                                                },
                                                                    resolutions: {
                                                                  "Normal":
                                                                      CurrentPlaying,
                                                                  "HD": dotenv.env[
                                                                          'END_POINT']! +
                                                                      dotenv.env[
                                                                          'LIST_STORAGE_FILES']! +
                                                                      snapshot
                                                                          .data
                                                                          .documents[
                                                                              i]
                                                                          .data['UrlHighQuality'] +
                                                                      "/view",
                                                                });
                                                            _betterPlayerController =
                                                                BetterPlayerController(
                                                                    BetterPlayerConfiguration(),
                                                                    betterPlayerDataSource:
                                                                        betterPlayerDataSource);
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                                "${snapshot.data.documents[i].data['Name']}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                          return Center(child: CircularProgressIndicator());
                        }
                        return Center(
                            child: Text("You have No Access for this part"));
                      }),
                  FutureBuilder(
                      future: fetchPrac1,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (subjectaccess[2] == "1") {
                          if (!snapshot.hasData) {
                            return Center(
                                child: Text("There Are No Videos Uploaded Until Now"));
                          }
                          if (snapshot.connectionState == ConnectionState.done) {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 120,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: widthofpic,
                                            height: heightofpic,
                                            child: Stack(
                                              children: [
                                                Image.asset(ImagetoShow),
                                                Positioned(
                                                  bottom: bottomposition,
                                                  right: 10,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        elevation: 8,
                                                        primary: buttonColor,
                                                        shape:
                                                            new CircleBorder()),
                                                    onPressed: () {
                                                      if (CurrentPlaying !=
                                                          dotenv.env[
                                                                  'END_POINT']! +
                                                              dotenv.env[
                                                                  'LIST_STORAGE_FILES']! +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'UrlNormalQuality'] +
                                                              "/view") {
                                                        setState(() {
                                                          VideoName = snapshot
                                                              .data
                                                              .documents[i]
                                                              .data['Name'];
                                                          CurrentPlaying = dotenv
                                                                      .env[
                                                                  'END_POINT']! +
                                                              dotenv.env[
                                                                  'LIST_STORAGE_FILES']! +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'UrlNormalQuality'] +
                                                              "/view";
                                                          if (snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'urlHighQuality'] ==
                                                              "null") {
                                                            betterPlayerDataSource =
                                                                BetterPlayerDataSource(
                                                                    BetterPlayerDataSourceType
                                                                        .network,
                                                                    CurrentPlaying,
                                                                    headers: {
                                                                  'X-Appwrite-Project':
                                                                      dotenv.env[
                                                                          'PROJECT_ID']!,
                                                                  'cookie':
                                                                      cookie,
                                                                });
                                                            _betterPlayerController =
                                                                BetterPlayerController(
                                                                    BetterPlayerConfiguration(),
                                                                    betterPlayerDataSource:
                                                                        betterPlayerDataSource);
                                                          } else {
                                                            betterPlayerDataSource =
                                                                BetterPlayerDataSource(
                                                                    BetterPlayerDataSourceType
                                                                        .network,
                                                                    CurrentPlaying,
                                                                    headers: {
                                                                  'X-Appwrite-Project':
                                                                      dotenv.env[
                                                                          'PROJECT_ID']!,
                                                                  'cookie':
                                                                      cookie,
                                                                },
                                                                    resolutions: {
                                                                  "Normal":
                                                                      CurrentPlaying,
                                                                  "HD": dotenv.env[
                                                                          'END_POINT']! +
                                                                      dotenv.env[
                                                                          'LIST_STORAGE_FILES']! +
                                                                      snapshot
                                                                          .data
                                                                          .documents[
                                                                              i]
                                                                          .data['UrlHighQuality'] +
                                                                      "/view",
                                                                });
                                                            _betterPlayerController =
                                                                BetterPlayerController(
                                                                    BetterPlayerConfiguration(),
                                                                    betterPlayerDataSource:
                                                                        betterPlayerDataSource);
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                                "${snapshot.data.documents[i].data['Name']}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        }
                        return Center(
                            child: Text("You have No Access for this part"));
                      }),
                  FutureBuilder(
                      future: fetchPrac2,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (subjectaccess[3] == "1") {
                          if (!snapshot.hasData) {
                            return Center(
                                child: Text("There Are No Videos Uploaded Until Now"));
                          }
                          if (snapshot.connectionState == ConnectionState.done) {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 120,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: widthofpic,
                                            height: heightofpic,
                                            child: Stack(
                                              children: [
                                                Image.asset(ImagetoShow),
                                                Positioned(
                                                  bottom: bottomposition,
                                                  right: 10,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        elevation: 8,
                                                        primary: buttonColor,
                                                        shape:
                                                            new CircleBorder()),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (CurrentPlaying !=
                                                            snapshot
                                                                .data!
                                                                .records![i]
                                                                .fields
                                                                .urlNormalQuality) {
                                                          VideoName = snapshot
                                                              .data!
                                                              .records![i]
                                                              .fields
                                                              .name;
                                                          CurrentPlaying = snapshot
                                                              .data!
                                                              .records![i]
                                                              .fields
                                                              .urlNormalQuality;
                                                          if (snapshot
                                                                  .data
                                                                  .records[i]
                                                                  .fields!
                                                                  .urlHighQuality ==
                                                              null) {
                                                            betterPlayerDataSource =
                                                                BetterPlayerDataSource(
                                                                    BetterPlayerDataSourceType
                                                                        .network,
                                                                    CurrentPlaying);
                                                            _betterPlayerController =
                                                                BetterPlayerController(
                                                                    BetterPlayerConfiguration(),
                                                                    betterPlayerDataSource:
                                                                        betterPlayerDataSource);
                                                          } else {
                                                            betterPlayerDataSource =
                                                                BetterPlayerDataSource(
                                                                    BetterPlayerDataSourceType
                                                                        .network,
                                                                    CurrentPlaying,
                                                                    resolutions: {
                                                                  "Normal":
                                                                      CurrentPlaying,
                                                                  "HD": snapshot
                                                                      .data
                                                                      .records[i]
                                                                      .fields!
                                                                      .urlHighQuality!,
                                                                });
                                                            _betterPlayerController =
                                                                BetterPlayerController(
                                                                    BetterPlayerConfiguration(),
                                                                    betterPlayerDataSource:
                                                                        betterPlayerDataSource);
                                                          }
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      size: 25,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                                "${snapshot.data!.records![i].fields.name}"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        }
                        return Center(
                            child: Text("You have No Access for this part"));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }
  onBackPressed() {
    Navigator.of(context).pop();
    _betterPlayerController.pause();
  }
  getJsonLec1() async {
    await whichSubjecttoShowLec1();
    var response = await database.listDocuments(
      collectionId: UrlLec1,
    );
    await client.cookieJar
        .loadForRequest(Uri.parse(
            "${dotenv.env['END_POINT']! + dotenv.env['LIST_STORAGE_FILES']! + response.documents.last.data['UrlNormalQuality']}"))
        .then((cookies) {
      cookie = getCookies(cookies);
      if (cookie.isNotEmpty) {}
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('UnAccepted Session'),
          backgroundColor: Color(0xff57b8eb),
          action: SnackBarAction(
            label: 'Ok',
            textColor: Colors.black,
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
    });
    if (subjectaccess[0] == "1" && intialindex == 0) {
      setState(() {
        VideoName = response.documents.last.data['Name'];
        CurrentPlaying = dotenv.env['END_POINT']! +
            dotenv.env['LIST_STORAGE_FILES']! +
            response.documents.last.data['UrlNormalQuality'] +
            "/view";
        if (response.documents.last.data['UrlHighQuality'] == "null") {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              headers: {
                'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
                'cookie': cookie,
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        } else {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              headers: {
                'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
                'cookie': cookie,
              },
              resolutions: {
                "Normal": CurrentPlaying,
                "HD": dotenv.env['END_POINT']! +
                    dotenv.env['LIST_STORAGE_FILES']! +
                    response.documents.last.data['UrlHighQuality'] +
                    "/view" +
                    dotenv.env['PROJECT_ID']!,
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        }
      });
    } else if (subjectaccess[0] != "1" && intialindex == 0) {
      setState(() {
        VideoName = "UnAccepted Permission";
        CurrentPlaying = "";
        if (response.documents.last.data['UrlHighQuality'] == "") {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying);
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        } else {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              resolutions: {
                "Normal": CurrentPlaying,
                "HD": "",
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        }
      });
    }

    return response;
  }

  getJsonLec2() async {
    await whichSubjecttoShowLec2();
    var response = await database.listDocuments(
      collectionId: UrlLec2,
    );
    await client.cookieJar
        .loadForRequest(Uri.parse(
            "${dotenv.env['END_POINT']! + dotenv.env['LIST_STORAGE_FILES']! + response.documents.last.data['UrlNormalQuality']}"))
        .then((cookies) {
      cookie = getCookies(cookies);
      if (cookie.isNotEmpty) {}
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('UnAccepted Session'),
          backgroundColor: Color(0xff57b8eb),
          action: SnackBarAction(
            label: 'Ok',
            textColor: Colors.black,
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
    });
    if (subjectaccess[1] == "1" && intialindex == 1) {
      setState(() {
        VideoName = response.documents.last.data['Name'];
        CurrentPlaying = dotenv.env['END_POINT']! +
            dotenv.env['LIST_STORAGE_FILES']! +
            response.documents.last.data['UrlNormalQuality'] +
            "/view";
        if (response.documents.last.data['UrlHighQuality'] == "null") {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              headers: {
                'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
                'cookie': cookie,
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        } else {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              headers: {
                'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
                'cookie': cookie,
              },
              resolutions: {
                "Normal": CurrentPlaying,
                "HD": dotenv.env['END_POINT']! +
                    dotenv.env['LIST_STORAGE_FILES']! +
                    response.documents.last.data['UrlHighQuality'] +
                    "/view" +
                    dotenv.env['PROJECT_ID']!,
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        }
      });
    } else if (subjectaccess[1] != "1" && intialindex == 1) {
      setState(() {
        VideoName = "UnAccepted Permission";
        CurrentPlaying = "";
        if (response.documents.last.data['UrlHighQuality'] == "") {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying);
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        } else {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              resolutions: {
                "Normal": CurrentPlaying,
                "HD": "",
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        }
      });
    }

    return response;
  }

  getJsonPrac1() async {
    await whichSubjecttoShowPrac1();
    var response = await database.listDocuments(
      collectionId: UrlPrac1,
    );
    await client.cookieJar
        .loadForRequest(Uri.parse(
            "${dotenv.env['END_POINT']! + dotenv.env['LIST_STORAGE_FILES']! + response.documents.last.data['UrlNormalQuality']}"))
        .then((cookies) {
      cookie = getCookies(cookies);
      if (cookie.isNotEmpty) {}
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('UnAccepted Session'),
          backgroundColor: Color(0xff57b8eb),
          action: SnackBarAction(
            label: 'Ok',
            textColor: Colors.black,
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
    });
    if (subjectaccess[2] == "1" && intialindex == 2) {
      setState(() {
        VideoName = response.documents.last.data['Name'];
        CurrentPlaying = dotenv.env['END_POINT']! +
            dotenv.env['LIST_STORAGE_FILES']! +
            response.documents.last.data['UrlNormalQuality'] +
            "/view";
        if (response.documents.last.data['UrlHighQuality'] == "null") {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              headers: {
                'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
                'cookie': cookie,
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        } else {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              headers: {
                'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
                'cookie': cookie,
              },
              resolutions: {
                "Normal": CurrentPlaying,
                "HD": dotenv.env['END_POINT']! +
                    dotenv.env['LIST_STORAGE_FILES']! +
                    response.documents.last.data['UrlHighQuality'] +
                    "/view" +
                    dotenv.env['PROJECT_ID']!,
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        }
      });
    } else if (subjectaccess[2] != "1" && intialindex == 2) {
      setState(() {
        VideoName = "UnAccepted Permission";
        CurrentPlaying = "";
        if (response.documents.last.data['UrlHighQuality'] == "") {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying);
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        } else {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              resolutions: {
                "Normal": CurrentPlaying,
                "HD": "",
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        }
      });
    }

    return response;
  }

  getJsonPrac2() async {
    await whichSubjecttoShowPrac2();
    var response = await database.listDocuments(
      collectionId: UrlPrac2,
    );
    await client.cookieJar
        .loadForRequest(Uri.parse(
            "${dotenv.env['END_POINT']! + dotenv.env['LIST_STORAGE_FILES']! + response.documents.last.data['UrlNormalQuality']}"))
        .then((cookies) {
      cookie = getCookies(cookies);
      if (cookie.isNotEmpty) {}
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('UnAccepted Session'),
          backgroundColor: Color(0xff57b8eb),
          action: SnackBarAction(
            label: 'Ok',
            textColor: Colors.black,
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
    });
    if (subjectaccess[3] == "1" && intialindex == 3) {
      setState(() {
        VideoName = response.documents.last.data['Name'];
        CurrentPlaying = dotenv.env['END_POINT']! +
            dotenv.env['LIST_STORAGE_FILES']! +
            response.documents.last.data['UrlNormalQuality'] +
            "/view";
        if (response.documents.last.data['UrlHighQuality'] == "null") {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              headers: {
                'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
                'cookie': cookie,
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        } else {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              headers: {
                'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
                'cookie': cookie,
              },
              resolutions: {
                "Normal": CurrentPlaying,
                "HD": dotenv.env['END_POINT']! +
                    dotenv.env['LIST_STORAGE_FILES']! +
                    response.documents.last.data['UrlHighQuality'] +
                    "/view" +
                    dotenv.env['PROJECT_ID']!,
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        }
      });
    } else if (subjectaccess[3] != "1" && intialindex == 3) {
      setState(() {
        VideoName = "UnAccepted Permission";
        CurrentPlaying = "";
        if (response.documents.last.data['UrlHighQuality'] == "") {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying);
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        } else {
          betterPlayerDataSource = BetterPlayerDataSource(
              BetterPlayerDataSourceType.network, CurrentPlaying,
              resolutions: {
                "Normal": CurrentPlaying,
                "HD": "",
              });
          _betterPlayerController = BetterPlayerController(
              BetterPlayerConfiguration(),
              betterPlayerDataSource: betterPlayerDataSource);
        }
      });
    }

    return response;
  }

  whichSubjecttoShowLec1() {
    if (subjectname == "material") {
      UrlLec1 = dotenv.env['Subject1Lec1']!;
    }
    if (subjectname == "morphology") {
      UrlLec1 = dotenv.env['Subject2Lec1']!;
    }
    if (subjectname == "anatomy") {
      UrlLec1 = dotenv.env['Subject3Lec1']!;
    }
    if (subjectname == "histology") {
      UrlLec1 = dotenv.env['Subject4Lec1']!;
    }
    if (subjectname == "chemistry") {
      UrlLec1 = dotenv.env['Subject5Lec1']!;
    }
    if (subjectname == "physics") {
      UrlLec1 = dotenv.env['Subject6Lec1']!;
    }
    if (subjectname == "zoology") {
      UrlLec1 = dotenv.env['Subject7Lec1']!;
    }
  }

  whichSubjecttoShowLec2() {
    if (subjectname == "material") {
      UrlLec2 = dotenv.env['Subject1Lec2']!;
    }
    if (subjectname == "morphology") {
      UrlLec2 = dotenv.env['Subject2Lec2']!;
    }
    if (subjectname == "anatomy") {
      UrlLec2 = dotenv.env['Subject3Lec2']!;
    }
    if (subjectname == "histology") {
      UrlLec2 = dotenv.env['Subject4Lec2']!;
    }
    if (subjectname == "chemistry") {
      UrlLec2 = dotenv.env['Subject5Lec2']!;
    }
    if (subjectname == "physics") {
      UrlLec2 = dotenv.env['Subject6Lec2']!;
    }
    if (subjectname == "zoology") {
      UrlLec2 = dotenv.env['Subject7Lec2']!;
    }
  }

  whichSubjecttoShowPrac1() {
    if (subjectname == "material") {
      UrlPrac1 = dotenv.env['Subject1Prac1']!;
    }
    if (subjectname == "morphology") {
      UrlPrac1 = dotenv.env['Subject2Prac1']!;
    }
    if (subjectname == "anatomy") {
      UrlPrac1 = dotenv.env['Subject3Prac1']!;
    }
    if (subjectname == "histology") {
      UrlPrac1 = dotenv.env['Subject4Prac1']!;
    }
    if (subjectname == "chemistry") {
      UrlPrac1 = dotenv.env['Subject5Prac1']!;
    }
    if (subjectname == "physics") {
      UrlPrac1 = dotenv.env['Subject6Prac1']!;
    }
    if (subjectname == "zoology") {
      UrlPrac1 = dotenv.env['Subject7Prac1']!;
    }
  }

  whichSubjecttoShowPrac2() {
    if (subjectname == "material") {
      UrlPrac2 = dotenv.env['Subject1Prac2']!;
    }
    if (subjectname == "morphology") {
      UrlPrac2 = dotenv.env['Subject2Prac2']!;
    }
    if (subjectname == "anatomy") {
      UrlPrac2 = dotenv.env['Subject3Prac2']!;
    }
    if (subjectname == "histology") {
      UrlPrac2 = dotenv.env['Subject4Prac2']!;
    }
    if (subjectname == "chemistry") {
      UrlPrac2 = dotenv.env['Subject5Prac2']!;
    }
    if (subjectname == "physics") {
      UrlPrac2 = dotenv.env['Subject6Prac2']!;
    }
    if (subjectname == "zoology") {
      UrlPrac2 = dotenv.env['Subject7Prac2']!;
    }
  }

  whichIndextoFetch() {
    if (intialindex == 0) {
      return fetchLec1;
    }
    if (intialindex == 1) {
      return fetchLec2;
    }
    if (intialindex == 2) {
      return fetchPrac1;
    }
    return fetchPrac2;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
