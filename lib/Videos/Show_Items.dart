import 'dart:io';
import 'dart:typed_data';
import 'package:appwrite/appwrite.dart';

import 'package:flutter/material.dart';
import 'package:predent/HomeScreen/HomeScreen.dart';
import 'package:predent/JsonData/GetPost.dart';
import 'package:predent/JsonData/SubjectData.dart';
import 'package:predent/JsonData/ssl_pinning.dart';
import 'package:predent/main.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:core';
import 'package:better_player/better_player.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:headset_connection_event/headset_event.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
late String subjectaccess;
String subjectnametoshow = "";

int intialindex = 2;
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
  final _headsetPlugin = HeadsetEvent();
  HeadsetState? _headsetState;
  TabController? _tabController;
  Future<dynamic>? fetchLec1;
  Future<dynamic>? fetchPrac1;
  Future<dynamic>? fetchLec2;
  Future<dynamic>? fetchPrac2;

  late BetterPlayerController _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(overlay: Text("ssss")),
      betterPlayerDataSource: betterPlayerDataSource);
  late BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network, CurrentPlaying);

  late String UrlLec1;
  late String UrlLec2;
  late String UrlPrac1;
  late String UrlPrac2;
  var myvideo;
  late String CurrentPlaying = "";
  String VideoName = "No Data";

  @override
  void initState() {
    super.initState();
    checkSSL(dotenv.env['API_SSL']!);
    if (checkedSSL == true) {
      betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, CurrentPlaying);
      _betterPlayerController = BetterPlayerController(
          BetterPlayerConfiguration(
            controlsConfiguration: (
                BetterPlayerControlsConfiguration(
                    enableMute: false
                )
            ),
            overlay: Container(
                child: Center(child: Text(GetAccountEmail.email))),
          ),
          betterPlayerDataSource: betterPlayerDataSource);
      this._headsetState == HeadsetState.CONNECT
          ? _betterPlayerController.setVolume(100)
          : _betterPlayerController.setVolume(0);

      _tabController =
          new TabController(length: 4, vsync: this, initialIndex: intialindex);
      fetchLec1 = getJsonLec1();
      fetchLec2 = getJsonLec2();
      fetchPrac1 = getJsonPrac1();
      fetchPrac2 = getJsonPrac2();
    }

    /// if headset is plugged
    _headsetPlugin.getCurrentState.then((_val) {
      setState(() {
        _headsetState = _val;
        this._headsetState == HeadsetState.CONNECT
            ? _betterPlayerController.setVolume(100)
            : _betterPlayerController.setVolume(0);
      });
    });

    /// Detect the moment headset is plugged or unplugged
    _headsetPlugin.setListener((_val) {
      setState(() {
        _headsetState = _val;
        this._headsetState == HeadsetState.CONNECT
            ? _betterPlayerController.setVolume(100)
            : _betterPlayerController.setVolume(0);
      });
    });
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
            Padding(
              padding: EdgeInsets.only(top: 30.0.h),
              child: IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios)),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.332,
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: FutureBuilder(
                      future: fetchLec2,
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
                          subjectnametoshow,
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
                        if (!snapshot.hasData && checkedSSL == true) {
                          return Center(
                              child: Text(
                                  "There Are No Videos Uploaded Until Now"));
                        }
                        if (snapshot.connectionState == ConnectionState.done &&
                            checkedSSL == true) {
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: 1,
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
                                                                'LIST_STORAGE_FILES']! + subjectname + "/files/" +                                                            snapshot
                                                                    .data
                                                                    .documents[i]
                                                                    .data[
                                                                'VideoID'] +
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
                                                                'LIST_STORAGE_FILES']! + subjectname + "/files/" +
                                                            snapshot
                                                                    .data
                                                                    .documents[i]
                                                                    .data[
                                                                'VideoID'] +
                                                            "/view";
                                                        betterPlayerDataSource =
                                                            BetterPlayerDataSource(
                                                                BetterPlayerDataSourceType
                                                                    .network,
                                                                CurrentPlaying,
                                                                headers: {
                                                              'X-Appwrite-Project':
                                                                  dotenv.env[
                                                                      'PROJECT_ID']!,
                                                              'cookie': cookie,
                                                            });
                                                        _betterPlayerController =
                                                            BetterPlayerController(
                                                                BetterPlayerConfiguration(
                                                                  controlsConfiguration:
                                                                      (BetterPlayerControlsConfiguration(
                                                                          enableMute:
                                                                              false)),
                                                                  overlay:
                                                                      Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Opacity(
                                                                            opacity: 0.5,
                                                                            child: Text(
                                                                        GetAccountEmail
                                                                              .email,
                                                                        style: TextStyle(
                                                                              fontSize: 35,
                                                                              color:
                                                                                  Colors.black),
                                                                      ),
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                betterPlayerDataSource:
                                                                    betterPlayerDataSource);
                                                        this._headsetState ==
                                                                HeadsetState
                                                                    .CONNECT
                                                            ? _betterPlayerController
                                                                .setVolume(100)
                                                            : _betterPlayerController
                                                                .setVolume(0);
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
                      }),
                  FutureBuilder(
                      future: fetchPrac1,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (subjectaccess[1] == "1") {
                          if (!snapshot.hasData && checkedSSL == true) {
                            return Center(
                                child: Text(
                                    "There Are No Videos Uploaded Until Now"));
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              checkedSSL == true) {
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
                                                                  'LIST_STORAGE_FILES']! + subjectname + "files//" +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'VideoID'] +
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
                                                                  'LIST_STORAGE_FILES']! + subjectname + "files//" +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'VideoID'] +
                                                              "/view";
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
                                                                  BetterPlayerConfiguration(
                                                                    controlsConfiguration:
                                                                        (BetterPlayerControlsConfiguration(
                                                                            enableMute:
                                                                                false)),
                                                                    overlay:
                                                                        Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Opacity(
                                                                              opacity: 0.5,
                                                                              child: Text(
                                                                          GetAccountEmail
                                                                                .email,
                                                                          style: TextStyle(
                                                                                fontSize: 35,
                                                                                color: Colors.black),
                                                                        ),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  betterPlayerDataSource:
                                                                      betterPlayerDataSource);
                                                          this._headsetState ==
                                                                  HeadsetState
                                                                      .CONNECT
                                                              ? _betterPlayerController
                                                                  .setVolume(
                                                                      100)
                                                              : _betterPlayerController
                                                                  .setVolume(0);
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
                        if (subjectaccess[2] == "1") {
                          if (!snapshot.hasData && checkedSSL == true) {
                            return Center(
                                child: Text(
                                    "There Are No Videos Uploaded Until Now"));
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              checkedSSL == true) {
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
                                                                  'LIST_STORAGE_FILES']! + subjectname + "/files/" +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'VideoID'] +
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
                                                                  'LIST_STORAGE_FILES']! + subjectname + "/files/" +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'VideoID'] +
                                                              "/view";
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
                                                                  BetterPlayerConfiguration(
                                                                    controlsConfiguration:
                                                                        (BetterPlayerControlsConfiguration(
                                                                            enableMute:
                                                                                false)),
                                                                    overlay:
                                                                        Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Opacity(
                                                                              opacity: 0.5,
                                                                              child: Text(
                                                                          GetAccountEmail
                                                                                .email,
                                                                          style: TextStyle(
                                                                                fontSize: 35,
                                                                                color: Colors.black),
                                                                        ),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  betterPlayerDataSource:
                                                                      betterPlayerDataSource);
                                                          this._headsetState ==
                                                                  HeadsetState
                                                                      .CONNECT
                                                              ? _betterPlayerController
                                                                  .setVolume(
                                                                      100)
                                                              : _betterPlayerController
                                                                  .setVolume(0);
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
                          if (!snapshot.hasData && checkedSSL == true) {
                            return Center(
                                child: Text(
                                    "There Are No Videos Uploaded Until Now"));
                          }
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              checkedSSL == true) {
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
                                                                  'LIST_STORAGE_FILES']! + subjectname + "/files/" +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'VideoID'] +
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
                                                                  'LIST_STORAGE_FILES']! + subjectname + "/files/" +
                                                              snapshot
                                                                      .data
                                                                      .documents[i]
                                                                      .data[
                                                                  'VideoID'] +
                                                              "/view";
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
                                                                  BetterPlayerConfiguration(
                                                                    controlsConfiguration:
                                                                        (BetterPlayerControlsConfiguration(
                                                                            enableMute:
                                                                                false)),
                                                                    overlay:
                                                                        Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Opacity(
                                                                              opacity: 0.5,
                                                                              child: Text(
                                                                          GetAccountEmail
                                                                                .email,
                                                                          style: TextStyle(
                                                                                fontSize: 35,
                                                                                color: Colors.black),
                                                                        ),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  betterPlayerDataSource:
                                                                      betterPlayerDataSource);
                                                          this._headsetState ==
                                                                  HeadsetState
                                                                      .CONNECT
                                                              ? _betterPlayerController
                                                                  .setVolume(
                                                                      100)
                                                              : _betterPlayerController
                                                                  .setVolume(0);
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
    try {
      var response = await database
          .listDocuments(collectionId: subjectname, limit: 100, queries: [
        Query.equal('Term', 'FirstTerm'),
        Query.equal('LP', 'Lecture'),
      ], orderTypes: [
        "DESC"
      ]);
      print("${dotenv.env['END_POINT']! + dotenv.env['LIST_STORAGE_FILES']! + subjectname + "/files/" + response.documents.first.data['VideoID']}") ;
      await client.cookieJar
          .loadForRequest(Uri.parse(
              "${dotenv.env['END_POINT']! + dotenv.env['LIST_STORAGE_FILES']! + subjectname + "/files/" + response.documents.first.data['VideoID']}"))
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
      // setState(() {
      //   VideoName = response.documents.first.data['Name'];
      //   CurrentPlaying = dotenv.env['END_POINT']! +
      //       dotenv.env['LIST_STORAGE_FILES']! + subjectname + "files/" +
      //       response.documents.first.data['VideoID'] +
      //       "/view";
      //   betterPlayerDataSource = BetterPlayerDataSource(
      //       BetterPlayerDataSourceType.network, CurrentPlaying,
      //       headers: {
      //         'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
      //         'cookie': cookie,
      //       });
      //   _betterPlayerController = BetterPlayerController(
      //       BetterPlayerConfiguration(),
      //       betterPlayerDataSource: betterPlayerDataSource);
      // });

      return response;
    } catch (e) {}
  }

  getJsonLec2() async {
    try {
      var response = await database
          .listDocuments(collectionId: subjectname, limit: 100, queries: [
        Query.equal('Term', 'SecondTerm'),
        Query.equal('LP', 'Lecture'),
      ], orderTypes: [
        "DESC"
      ]);
      await client.cookieJar
          .loadForRequest(Uri.parse(
              "${dotenv.env['END_POINT']! + dotenv.env['LIST_STORAGE_FILES']! + subjectname + "/files/" + response.documents.first.data['VideoID']}"))
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
      setState(() {
        VideoName = response.documents.first.data['Name'];
        CurrentPlaying = dotenv.env['END_POINT']! +
            dotenv.env['LIST_STORAGE_FILES']! + subjectname + "/files/" +
            response.documents.first.data['VideoID'] +
            "/view";
        betterPlayerDataSource = BetterPlayerDataSource(
            BetterPlayerDataSourceType.network, CurrentPlaying,
            headers: {
              'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
              'cookie': cookie,
            });
        _betterPlayerController = BetterPlayerController(
            BetterPlayerConfiguration(
              controlsConfiguration:
                  (BetterPlayerControlsConfiguration(enableMute: false)),
              overlay: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Opacity(
                    opacity: 0.5,
                    child: Text(
                      GetAccountEmail.email,
                      style: TextStyle(fontSize: 35, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            betterPlayerDataSource: betterPlayerDataSource);
        this._headsetState == HeadsetState.CONNECT
            ? _betterPlayerController.setVolume(100)
            : _betterPlayerController.setVolume(0);
      });

      return response;
    } catch (e) {}
  }

  getJsonPrac1() async {
    try {
      var response = await database
          .listDocuments(collectionId: subjectname, limit: 100, queries: [
        Query.equal('Term', 'FirstTerm'),
        Query.equal('LP', 'Practical'),
      ], orderTypes: [
        "DESC"
      ]);
      await client.cookieJar
          .loadForRequest(Uri.parse(
              "${dotenv.env['END_POINT']! + dotenv.env['LIST_STORAGE_FILES']! + subjectname + "/files/" + response.documents.first.data['VideoID']}"))
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
      // setState(() {
      //   VideoName = response.documents.first.data['Name'];
      //   CurrentPlaying = dotenv.env['END_POINT']! +
      //       dotenv.env['LIST_STORAGE_FILES']! + subjectname + "files/" +
      //       response.documents.first.data['VideoID'] +
      //       "/view";
      //   betterPlayerDataSource = BetterPlayerDataSource(
      //       BetterPlayerDataSourceType.network, CurrentPlaying,
      //       headers: {
      //         'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
      //         'cookie': cookie,
      //       });
      //   _betterPlayerController = BetterPlayerController(
      //       BetterPlayerConfiguration(),
      //       betterPlayerDataSource: betterPlayerDataSource);
      // });

      return response;
    } catch (e) {}
  }

  getJsonPrac2() async {
    try {
      var response = await database
          .listDocuments(collectionId: subjectname, limit: 100, queries: [
        Query.equal('Term', 'SecondTerm'),
        Query.equal('LP', 'Practical'),
      ], orderTypes: [
        "DESC"
      ]);
      await client.cookieJar
          .loadForRequest(Uri.parse(
              "${dotenv.env['END_POINT']! + dotenv.env['LIST_STORAGE_FILES']! + subjectname + "/files/" + response.documents.first.data['VideoID']}"))
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
      // setState(() {
      //   VideoName = response.documents.first.data['Name'];
      //   CurrentPlaying = dotenv.env['END_POINT']! +
      //       dotenv.env['LIST_STORAGE_FILES']! + subjectname + "files/" +
      //       response.documents.first.data['VideoID'] +
      //       "/view";
      //   betterPlayerDataSource = BetterPlayerDataSource(
      //       BetterPlayerDataSourceType.network, CurrentPlaying,
      //       headers: {
      //         'X-Appwrite-Project': dotenv.env['PROJECT_ID']!,
      //         'cookie': cookie,
      //       });
      //   _betterPlayerController = BetterPlayerController(
      //       BetterPlayerConfiguration(),
      //       betterPlayerDataSource: betterPlayerDataSource);
      // });

      return response;
    } catch (e) {}
  }
}
