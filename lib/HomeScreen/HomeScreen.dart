import 'dart:io';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:flutter/material.dart';
import 'package:predent/JsonData/ssl_pinning.dart';
import 'package:predent/SignIn/SignIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:predent/Videos/Show_Items.dart';
import 'package:predent/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appwrite/appwrite.dart';
import 'package:predent/main.dart';
import 'dart:core';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/services.dart';

import 'package:predent/AllCourses/AllCourses.dart';

enum stats {
  AllCourses,
  MyCourses,
  Practical,
  Marked,
}

List filternames = [];
List filternames2 = [];
stats currentButton = stats.AllCourses;
var GetAccountEmail;

final key1 = UniqueKey();
final key2 = UniqueKey();

Icon firstFavourite =
    Icon(Icons.star_border_outlined, size: 35, color: Colors.white);

Icon secondFavourite =
    Icon(Icons.star_border_outlined, size: 35, color: Colors.white);

Icon thirdFavourite =
    Icon(Icons.star_border_outlined, size: 35, color: Colors.white);

Icon forthFavourite =
    Icon(Icons.star_border_outlined, size: 35, color: Colors.white);

Icon fifthFavourite =
    Icon(Icons.star_border_outlined, size: 35, color: Colors.white);

Icon sixthFavourite =
    Icon(Icons.star_border_outlined, size: 35, color: Colors.white);

Icon seventhFavourite =
    Icon(Icons.star_border_outlined, size: 35, color: Colors.white);

Color firstButtonIconBackGroundColor = Color(0xff54C0FB);

Color secondButtonIconBackGroundColor = Color(0xffF9AF2A);

Color thirdButtonIconBackGroundColor = Color(0xff737FB4);

Color forthButtonIconBackGroundColor = Color(0xff54AD66);

Color firstButtonBackGround = Colors.white;

Color secondButtonBackGround = Colors.white;

Color thirdButtonBackGround = Colors.white;

Color forthButtonBackGround = Colors.white;

Color firstButtonIcon = Colors.white;

Color secondButtonIcon = Colors.white;

Color thirdButtonIcon = Colors.white;

Color forthButtonIcon = Colors.white;

Color firstButtonText = Colors.black;

Color secondButtonText = Colors.black;

Color thirdButtonText = Colors.black;

Color forthButtonText = Colors.black;

bool materialvisibile = true;
bool morphologyvisible = true;
bool anatomyvisibile = true;
bool histologyvisible = true;
bool chemistryvisible = true;
bool physicsvisibile = true;
bool zoologyvisible = true;
bool showTextCenter = false;

late String material;
late String morphology;
late String anatomy;
late String histology;
late String chemistry;
late String physics;
late String zoology;
late String carving;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String displayName = "";
  String CheckInterface = "";
  late String jailbreakmethod;
  var GetMySubjects;
  late bool jailbroken;
  late bool developerMode;
  String photoUrl = 'nopic';
  String? deviceID;
  String? deviceIdLocal;
  bool? existing;
  var Serial;
  late bool RealDeviceCheckPoint;

  var futs;
  var SubjectsList;

  @override
  void initState() {
    super.initState();
    GetAccount();
    isRealDevice();
    Favoutire();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: futs,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return SingleChildScrollView(
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                body: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await signoutappwrite();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            "Something went WRONG Press to Back",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (CheckInterface == "root") {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Root Devices Aren't Allowed"),
                      InkWell(
                          onTap: () async {
                            await signoutappwrite();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            "Press Here to Logout",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (CheckInterface == "emulator") {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Emulator Devices Aren't Allowed"),
                      InkWell(
                          onTap: () async {
                            await signoutappwrite();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            "Press Here to Logout",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (CheckInterface == "2Devices") {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("User Not Allowed To be Used on Multiple Devices"),
                      InkWell(
                          onTap: () async {
                            await signoutappwrite();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            "Press Here to Logout",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (CheckInterface == "notreg") {
          return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Your User Will be Approved in 24 Hours From Our Side"),
                    InkWell(
                        onTap: () async {
                          await signoutappwrite();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        child: Text("Press Here to Back"))
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          return ColoredSafeArea(
            color: Colors.blue,
            child: WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(appBar: topBar(), body: Body())),
          );
        }

        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinKitThreeInOut(
                      color: Colors.green,
                      size: 50.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out ?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('You Are already logged in'),
                Text('Do You Want to Sign Out'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sign Out'),
              onPressed: () async {
                await signoutappwrite();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn()));
              },
            ),
          ],
        );
      },
    );
  }

  void Favoutire() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getString("material") == "Favourite") {
        firstFavourite = Icon(Icons.star, size: 35, color: Colors.white);
      }
      if (prefs.getString("morphology") == "Favourite") {
        secondFavourite = Icon(Icons.star, size: 35, color: Colors.white);
      }
      if (prefs.getString("anatomy") == "Favourite") {
        thirdFavourite = Icon(Icons.star, size: 35, color: Colors.white);
      }
      if (prefs.getString("histology") == "Favourite") {
        forthFavourite = Icon(Icons.star, size: 35, color: Colors.white);
      }
      if (prefs.getString("chemistry") == "Favourite") {
        fifthFavourite = Icon(Icons.star, size: 35, color: Colors.white);
      }
      if (prefs.getString("physics") == "Favourite") {
        sixthFavourite = Icon(Icons.star, size: 35, color: Colors.white);
      }
      if (prefs.getString("zoology") == "Favourite") {
        seventhFavourite = Icon(Icons.star, size: 35, color: Colors.white);
      }
    });
  }

  Future<dynamic> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceIdLocal = iosDeviceInfo.identifierForVendor;
      return deviceIdLocal;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceIdLocal = androidDeviceInfo.androidId;
      return deviceIdLocal;
    }
  }

  signoutappwrite() async {
    try {
      await account.deleteSessions();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignIn()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Error happened check Your Connection'),
        backgroundColor: Color(0xff57b8eb),
        action: SnackBarAction(
            label: 'Ok', textColor: Colors.black, onPressed: () {}),
      ));
    }
  }

  CheckSameUser() async {
    await checkSSL(dotenv.env['API_SSL']!);
    if (checkedSSL == true) {
      final Serial = await database.listDocuments(
          collectionId: dotenv.env['SERIALS_COLLECTION_ID']!);
      if (Serial.total != 0) {
        if (RealDeviceCheckPoint == true) {
          CheckInterface = "emulator";
          database.updateDocument(
            collectionId: dotenv.env['SERIALS_COLLECTION_ID']!,
            documentId: Serial.documents[0].$id,
            data: {"deviceId": "emulator"},
          );
        } else if (jailbreakmethod == "root") {
          CheckInterface = "root";
          database.updateDocument(
            collectionId: dotenv.env['SERIALS_COLLECTION_ID']!,
            documentId: Serial.documents[0].$id,
            data: {"deviceId": "root"},
          );
        } else if (Root == "root1") {
          CheckInterface = "root";
          database.updateDocument(
            collectionId: dotenv.env['SERIALS_COLLECTION_ID']!,
            documentId: Serial.documents[0].$id,
            data: {"deviceId": "root"},
          );
        } else {
          await getDeviceId();
          deviceID = await Serial.documents[0].data['deviceId'];
          if (await deviceID == deviceIdLocal) {
            // await setuserInfo();
            setState(() {
              SwitchBetweenButtons();
            });
            SubjectsList = await RecentlyCourses();
            GetMySubjects = await LoadMySubject();
            LoadCoursesVar = LoadCourses();
            return Serial.documents[0];
          } else if (deviceID == "new") {
            try {
              await database.updateDocument(
                collectionId: dotenv.env['SERIALS_COLLECTION_ID']!,
                documentId: Serial.documents[0].$id,
                data: {"deviceId": deviceIdLocal},
              );
            } catch (e) {}
            // await setuserInfo();
            setState(() {
              SwitchBetweenButtons();
            });
            SubjectsList = await RecentlyCourses();
            GetMySubjects = await LoadMySubject();
            LoadCoursesVar = LoadCourses();
            return Serial.documents[0];
          } else {
            /// 2 devices
            CheckInterface = "2Devices";
          }
          setState(() {});
          return Serial.documents[0];
        }
      } else {
        CheckInterface = "notreg";
        return null;
      }

      return Serial.documents[0];
    }
  }

  setuserInfo() async {
    final allDocumentsList = await database.listDocuments(
        collectionId: dotenv.env['USER_COLLECTION_ID']!);
    displayName = "";
    material = allDocumentsList.documents[0].data['Material'];
    morphology = allDocumentsList.documents[0].data['Morphology'];
    anatomy = allDocumentsList.documents[0].data['Anatomy'];
    histology = allDocumentsList.documents[0].data['Histology'];
    chemistry = allDocumentsList.documents[0].data['Chemistry'];
    physics = allDocumentsList.documents[0].data['Physics'];
    zoology = allDocumentsList.documents[0].data['Zoology'];
    carving = allDocumentsList.documents[0].data['Carving'];
    //handle Kick User or tell that's not allowed ass.hole
  }

  Widget SearchBar() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
        // on Presses Elevated Button
        onPressed: () {
          showSearch(context: context, delegate: SearchSubjectes());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Search",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w300,
                  fontSize: 15),
            ),
            IconButton(
                // on Presses Search Icon of Button same job --------------
                onPressed: () {
                  showSearch(context: context, delegate: SearchSubjectes());
                },
                icon: Icon(
                  Icons.search,
                  size: 35,
                  color: Colors.black,
                ))
          ],
        ),
      ),
    );
  }

  Widget Body() {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Stack(
        children: [
          BackGround(),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 24.h, left: 35.w),
                  child: Row(
                    children: [
                      SearchBar(),
                      // Filter(),
                    ],
                  ),
                ),
                // Courses Title
                Padding(
                  padding: EdgeInsets.only(
                    top: 18.w,
                    left: 32.w,
                  ),
                  child: Text(
                    "Courses",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                    ),
                  ),
                ),
                // Menus of Buttons
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 27.w, top: 20.h),
                      child: RoundedButton(
                        amountofradius: 25,
                        primary: firstButtonBackGround,
                        press: () {
                          currentButton = stats.AllCourses;
                          SwitchBetweenButtons();
                        },
                        width: 170,
                        height: 58,
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: firstButtonIconBackGroundColor),
                              child: Icon(
                                Icons.local_fire_department,
                                color: firstButtonIcon,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Recently",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: firstButtonText),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 20.h),
                      child: RoundedButton(
                        amountofradius: 25,
                        primary: secondButtonBackGround,
                        press: () {
                          currentButton = stats.MyCourses;
                          Navigator.of(context)
                              .push(_createRoute(AllCourses()));
                        },
                        width: 170,
                        height: 58,
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: secondButtonIconBackGroundColor),
                              child: Icon(
                                Icons.bolt_outlined,
                                size: 35,
                                color: secondButtonIcon,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "All Courses",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: secondButtonText),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 27.w, top: 20.h),
                      child: RoundedButton(
                        amountofradius: 25,
                        primary: thirdButtonBackGround,
                        press: () {
                          currentButton = stats.Practical;
                          SwitchBetweenButtons();
                        },
                        width: 170,
                        height: 58,
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: thirdButtonIconBackGroundColor),
                              child: Icon(
                                Icons.bookmark_border_rounded,
                                size: 35,
                                color: thirdButtonIcon,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "My Courses",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: thirdButtonText),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 20.h),
                      child: RoundedButton(
                        amountofradius: 25,
                        primary: forthButtonBackGround,
                        press: () {
                          currentButton = stats.Marked;
                          SwitchBetweenButtons();
                        },
                        width: 170,
                        height: 58,
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: forthButtonIconBackGroundColor),
                              child: Icon(
                                Icons.star_border_outlined,
                                size: 35,
                                color: forthButtonIcon,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Marked",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: forthButtonText),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 25.w),
                  child: Container(
                      width: double.infinity,
                      height: 270,
                      child: currentButton == stats.AllCourses
                          ? SubjectCardList()
                          : currentButton == stats.Practical
                              ? MySubjects()
                              : SubjectCardList()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  topBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Builder(builder: (BuildContext context) {
        return Visibility(
          visible: false,
          child: IconButton(
            padding: EdgeInsets.only(top: 12),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Opacity(
              opacity: 0.85,
              child: SvgPicture.asset(
                "assests/drawer.svg",
                height: 11,
              ),
            ),
          ),
        );
      }),
      actions: [AvatarProfile()],
    );
  }

  Widget Filter() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        width: 55,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color(0xff45D0F3),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
          ),
          child: Icon(
            Icons.filter_alt_outlined,
            color: Colors.white,
          ),
          // On Pressed Filter Button -----------------
          onPressed: () {},
        ),
      ),
    );
  }

  Widget AvatarProfile() {
    return Padding(
      padding: EdgeInsets.only(top: 12, right: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.white, shape: new CircleBorder()),
        onPressed: () {},
        child: InkWell(
          onTap: _showMyDialog,
          child: photoUrl == 'nopic'
              ? Image.asset('assests/profile.png')
              : Image.network(
                  photoUrl,
                  fit: BoxFit.fill,
                ),
        ),
      ),
    );
  }

  Widget BackGround() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: GradiantHome,
    );
  }

  void SwitchBetweenButtons() {
    // Switch-case
    switch (currentButton) {
      case stats.AllCourses:
        FirstActivated();
        break;
      case stats.MyCourses:
        SecondActivated();
        break;
      case stats.Practical:
        ThirdActivated();
        break;
      case stats.Marked:
        ForthActivated();
        break;
    }
  }

  void AllSubjects() {
    if (materialvisibile == false) {
      materialvisibile = true;
    }
    if (morphologyvisible == false) {
      morphologyvisible = true;
    }
    if (anatomyvisibile == false) {
      anatomyvisibile = true;
    }
    if (histologyvisible == false) {
      histologyvisible = true;
    }
    if (chemistryvisible == false) {
      chemistryvisible = true;
    }
    if (physicsvisibile == false) {
      physicsvisibile = true;
    }
    if (zoologyvisible == false) {
      zoologyvisible = true;
    }
  }

  void mySubjects() {
    if (material[0] == "0" && material[1] == "0") {
      materialvisibile = false;
    } else {
      materialvisibile = true;
    }
    if (morphology[0] == "0" && morphology[1] == "0") {
      morphologyvisible = false;
    } else {
      morphologyvisible = true;
    }
    if (anatomy[0] == "0" && anatomy[1] == "0") {
      anatomyvisibile = false;
    } else {
      anatomyvisibile = true;
    }
    if (histology[0] == "0" && histology[1] == "0") {
      histologyvisible = false;
    } else {
      histologyvisible = true;
    }
    if (chemistry[0] == "0" && chemistry[1] == "0") {
      chemistryvisible = false;
    } else {
      chemistryvisible = true;
    }
    if (physics[0] == "0" && physics[1] == "0") {
      physicsvisibile = false;
    } else {
      physicsvisibile = true;
    }
    if (zoology[0] == "0" && zoology[1] == "0") {
      zoologyvisible = false;
    } else {
      zoologyvisible = true;
    }
  }

  void Practical() {
    if (material[2] == "0" && material[3] == "0") {
      materialvisibile = false;
    } else {
      materialvisibile = true;
    }
    if (morphology[2] == "0" && morphology[3] == "0") {
      morphologyvisible = false;
    } else {
      morphologyvisible = true;
    }
    if (anatomy[2] == "0" && anatomy[3] == "0") {
      anatomyvisibile = false;
    } else {
      anatomyvisibile = true;
    }
    if (histology[2] == "0" && histology[3] == "0") {
      histologyvisible = false;
    } else {
      histologyvisible = true;
    }
    if (chemistry[2] == "0" && chemistry[3] == "0") {
      chemistryvisible = false;
    } else {
      chemistryvisible = true;
    }
    if (physics[2] == "0" && physics[3] == "0") {
      physicsvisibile = false;
    } else {
      physicsvisibile = true;
    }
    if (zoology[2] == "0" && zoology[3] == "0") {
      zoologyvisible = false;
    } else {
      zoologyvisible = true;
    }
  }

  void Marked() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("material") == "Favourite") {
      materialvisibile = true;
    } else
      materialvisibile = false;
    if (prefs.getString("morphology") == "Favourite") {
      morphologyvisible = true;
    } else {
      morphologyvisible = false;
    }
    if (prefs.getString("anatomy") == "Favourite") {
      anatomyvisibile = true;
    } else {
      anatomyvisibile = false;
    }
    if (prefs.getString("histology") == "Favourite") {
      histologyvisible = true;
    } else {
      histologyvisible = false;
    }
    if (prefs.getString("chemistry") == "Favourite") {
      chemistryvisible = true;
    } else {
      chemistryvisible = false;
    }
    if (prefs.getString("physics") == "Favourite") {
      physicsvisibile = true;
    } else {
      physicsvisibile = false;
    }
    if (prefs.getString("zoology") == "Favourite") {
      zoologyvisible = true;
    } else {
      zoologyvisible = false;
    }
  }

  void FirstActivated() {
    setState(() {
      AllSubjects();
      firstButtonIconBackGroundColor = Colors.white;
      if (secondButtonIconBackGroundColor != Color(0xffF9AF2A)) {
        secondButtonIconBackGroundColor = Color(0xffF9AF2A);
      }
      if (thirdButtonIconBackGroundColor != Color(0xff737FB4)) {
        thirdButtonIconBackGroundColor = Color(0xff737FB4);
      }
      if (forthButtonIconBackGroundColor != Color(0xff54AD66)) {
        forthButtonIconBackGroundColor = Color(0xff54AD66);
      }

      firstButtonBackGround = Color(0xff54C0FB);

      if (secondButtonBackGround != Colors.white) {
        secondButtonBackGround = Colors.white;
      }
      if (thirdButtonBackGround != Colors.white) {
        thirdButtonBackGround = Colors.white;
      }
      if (forthButtonBackGround != Colors.white) {
        forthButtonBackGround = Colors.white;
      }

      firstButtonIcon = Color(0xff54C0FB);
      if (secondButtonIcon != Colors.white) {
        secondButtonIcon = Colors.white;
      }

      if (thirdButtonIcon != Colors.white) {
        thirdButtonIcon = Colors.white;
      }
      if (forthButtonIcon != Colors.white) {
        forthButtonIcon = Colors.white;
      }

      firstButtonText = Colors.white;

      if (secondButtonText != Colors.black) {
        secondButtonText = Colors.black;
      }

      if (thirdButtonText != Colors.black) {
        thirdButtonText = Colors.black;
      }

      if (forthButtonText != Colors.black) {
        forthButtonText = Colors.black;
      }
    });
  }

  void SecondActivated() {
    setState(() {
      mySubjects();
      secondButtonIconBackGroundColor = Colors.white;

      if (firstButtonIconBackGroundColor != Color(0xff54C0FB)) {
        firstButtonIconBackGroundColor = Color(0xff54C0FB);
      }
      if (thirdButtonIconBackGroundColor != Color(0xff737FB4)) {
        thirdButtonIconBackGroundColor = Color(0xff737FB4);
      }
      if (forthButtonIconBackGroundColor != Color(0xff54AD66)) {
        forthButtonIconBackGroundColor = Color(0xff54AD66);
      }

      secondButtonBackGround = Color(0xffF9AF2A);

      if (firstButtonBackGround != Colors.white) {
        firstButtonBackGround = Colors.white;
      }
      if (thirdButtonBackGround != Colors.white) {
        thirdButtonBackGround = Colors.white;
      }
      if (forthButtonBackGround != Colors.white) {
        forthButtonBackGround = Colors.white;
      }

      secondButtonIcon = Color(0xffF9AF2A);
      if (firstButtonIcon != Colors.white) {
        firstButtonIcon = Colors.white;
      }

      if (thirdButtonIcon != Colors.white) {
        thirdButtonIcon = Colors.white;
      }
      if (forthButtonIcon != Colors.white) {
        forthButtonIcon = Colors.white;
      }

      secondButtonText = Colors.white;

      if (firstButtonText != Colors.black) {
        firstButtonText = Colors.black;
      }

      if (thirdButtonText != Colors.black) {
        thirdButtonText = Colors.black;
      }

      if (forthButtonText != Colors.black) {
        forthButtonText = Colors.black;
      }
    });
  }

  void ThirdActivated() {
    setState(() {
      thirdButtonIconBackGroundColor = Colors.white;

      if (firstButtonIconBackGroundColor != Color(0xff54C0FB)) {
        firstButtonIconBackGroundColor = Color(0xff54C0FB);
      }
      if (secondButtonIconBackGroundColor != Color(0xffF9AF2A)) {
        secondButtonIconBackGroundColor = Color(0xffF9AF2A);
      }
      if (forthButtonIconBackGroundColor != Color(0xff54AD66)) {
        forthButtonIconBackGroundColor = Color(0xff54AD66);
      }

      thirdButtonBackGround = Color(0xff737FB4);

      if (firstButtonBackGround != Colors.white) {
        firstButtonBackGround = Colors.white;
      }
      if (secondButtonBackGround != Colors.white) {
        secondButtonBackGround = Colors.white;
      }
      if (forthButtonBackGround != Colors.white) {
        forthButtonBackGround = Colors.white;
      }

      thirdButtonIcon = Color(0xff737FB4);
      if (firstButtonIcon != Colors.white) {
        firstButtonIcon = Colors.white;
      }

      if (secondButtonIcon != Colors.white) {
        secondButtonIcon = Colors.white;
      }
      if (forthButtonIcon != Colors.white) {
        forthButtonIcon = Colors.white;
      }

      thirdButtonText = Colors.white;

      if (firstButtonText != Colors.black) {
        firstButtonText = Colors.black;
      }

      if (secondButtonText != Colors.black) {
        secondButtonText = Colors.black;
      }

      if (forthButtonText != Colors.black) {
        forthButtonText = Colors.black;
      }
    });
  }

  void ForthActivated() {
    setState(() {
      Marked();
      forthButtonIconBackGroundColor = Colors.white;

      if (firstButtonIconBackGroundColor != Color(0xff54C0FB)) {
        firstButtonIconBackGroundColor = Color(0xff54C0FB);
      }
      if (secondButtonIconBackGroundColor != Color(0xffF9AF2A)) {
        secondButtonIconBackGroundColor = Color(0xffF9AF2A);
      }
      if (thirdButtonIconBackGroundColor != Color(0xff737FB4)) {
        thirdButtonIconBackGroundColor = Color(0xff737FB4);
      }

      forthButtonBackGround = Color(0xff54AD66);

      if (firstButtonBackGround != Colors.white) {
        firstButtonBackGround = Colors.white;
      }
      if (secondButtonBackGround != Colors.white) {
        secondButtonBackGround = Colors.white;
      }
      if (thirdButtonBackGround != Colors.white) {
        thirdButtonBackGround = Colors.white;
      }

      forthButtonIcon = Color(0xff54AD66);
      if (firstButtonIcon != Colors.white) {
        firstButtonIcon = Colors.white;
      }

      if (secondButtonIcon != Colors.white) {
        secondButtonIcon = Colors.white;
      }
      if (thirdButtonIcon != Colors.white) {
        thirdButtonIcon = Colors.white;
      }

      forthButtonText = Colors.white;

      if (firstButtonText != Colors.black) {
        firstButtonText = Colors.black;
      }

      if (secondButtonText != Colors.black) {
        secondButtonText = Colors.black;
      }

      if (thirdButtonText != Colors.black) {
        thirdButtonText = Colors.black;
      }
    });
  }

  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
      developerMode = await FlutterJailbreakDetection.developerMode;
    } on PlatformException {
      jailbroken = true;
      developerMode = true;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      jailbroken = jailbroken;
      developerMode = developerMode;
    });
    if (jailbroken == true) {
      jailbreakmethod = "Root";
    } else
      jailbreakmethod = "Non-Root";
  }

  isRealDevice() async {
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    RealDeviceCheckPoint = await androidInfo.isPhysicalDevice;

    await initPlatformState();
    setState(() {
      futs = CheckSameUser();
    });
  }

  GetAccount() async {
    GetAccountEmail = await account.get();
  }

  Widget MySubjects() {
    return FutureBuilder<dynamic>(
        future: teams.list(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              checkedSSL == true) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.teams.length,
              itemBuilder: (context, i) {
                return Subject(
                  'assests/materiallec.png',
                  snapshot.data.teams[i].name,
                  "",
                  Color(0xff57b8eb),
                  () {
                    if (checkedSSL == true) {
                      try {
                        heightofpic = 150;
                        widthofpic = 145;

                        ImagetoShow = "assests/1.png";
                        buttonColor = Color(0xff57b8eb);
                        subjectaccess = "1111";
                        subjectname = snapshot.data.teams[i].$id;
                        Navigator.of(context).push(_createRoute(ShowItems()));
                      } catch (e) {
                        print(e);
                      }
                    } else
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              const Text('You Have No Access for this Subject'),
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
                  },
                  materialvisibile,
                  firstFavourite,
                  () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    setState(() {
                      if (prefs.getString("material") == "Favourite") {
                        firstFavourite = Icon(Icons.star_border_outlined,
                            size: 35, color: Colors.white);
                        prefs.remove("material");
                      } else {
                        firstFavourite =
                            Icon(Icons.star, size: 35, color: Colors.white);
                        prefs.setString("material", "Favourite");
                      }
                    });
                  },
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  SubjectCardList() {
    return ListView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [
        Visibility(
          visible: showTextCenter,
          child: Center(
            child: Text("You Have No Subscribed Subjects Here"),
          ),
        ),
        Subject(
          'assests/materiallec.png',
          SubjectsList.documents[0].data['SubjectName'],
          SubjectsList.documents[0].data['DoctorName'],
          Color(0xff57b8eb),
          () {
            if (checkedSSL == true) {
              try {
                heightofpic = 150;
                widthofpic = 145;
                ImagetoShow = "assests/1.png";
                buttonColor = Color(0xff57b8eb);
                subjectaccess = "1111";
                subjectname = SubjectsList.documents[0].data['\$id'];
                Navigator.of(context).push(_createRoute(ShowItems()));
              } catch (e) {
                print(e);
              }
            } else
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('You Have No Access for this Subject'),
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
          },
          materialvisibile,
          firstFavourite,
          () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            setState(() {
              if (prefs.getString("material") == "Favourite") {
                firstFavourite = Icon(Icons.star_border_outlined,
                    size: 35, color: Colors.white);
                prefs.remove("material");
              } else {
                firstFavourite =
                    Icon(Icons.star, size: 35, color: Colors.white);
                prefs.setString("material", "Favourite");
              }
            });
          },
        ),
        Subject(
          'assests/2.png',
          SubjectsList.documents[1].data['SubjectName'],
          SubjectsList.documents[1].data['DoctorName'],
          Color(0xffF9AF2A),
          () async {
            if (checkedSSL == true) {
              try {
                heightofpic = 150;
                widthofpic = 150;

                ImagetoShow = "assests/2.png";
                buttonColor = Color(0xffF9AF2A);
                subjectaccess = "1111";
                subjectname = SubjectsList.documents[1].data['\$id'];
                Navigator.of(context).push(_createRoute(ShowItems()));
              } catch (e) {
                print('Error');
              }
            } else
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('You Have No Access for this Subject'),
                  backgroundColor: Color(0xffF9AF2A),
                  action: SnackBarAction(
                    label: 'Ok',
                    textColor: Colors.black,
                    onPressed: () {
                      // Code to execute.
                    },
                  ),
                ),
              );
          },
          morphologyvisible,
          secondFavourite,
          () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            setState(() {
              if (prefs.getString("morphology") == "Favourite") {
                secondFavourite = Icon(Icons.star_border_outlined,
                    size: 35, color: Colors.white);
                prefs.remove("morphology");
              } else {
                secondFavourite =
                    Icon(Icons.star, size: 35, color: Colors.white);
                prefs.setString("morphology", "Favourite");
              }
            });
          },
        ),
        Subject(
          'assests/3.png',
          SubjectsList.documents[2].data['SubjectName'],
          SubjectsList.documents[2].data['DoctorName'],
          Color(0xff737FB4),
          () {
            if (checkedSSL == true) {
              try {
                heightofpic = 150;
                widthofpic = 150;

                ImagetoShow = "assests/3.png";
                buttonColor = Color(0xff737FB4);
                subjectaccess = "1111";
                subjectname = SubjectsList.documents[2].data['\$id'];
                Navigator.of(context).push(_createRoute(ShowItems()));
              } catch (e) {
                print(e);
              }
            } else
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('You Have No Access for this Subject'),
                  backgroundColor: Color(0xff737FB4),
                  action: SnackBarAction(
                    label: 'Ok',
                    textColor: Colors.black,
                    onPressed: () {
                      // Code to execute.
                    },
                  ),
                ),
              );
          },
          anatomyvisibile,
          thirdFavourite,
          () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            setState(() {
              if (prefs.getString("anatomy") == "Favourite") {
                thirdFavourite = Icon(Icons.star_border_outlined,
                    size: 35, color: Colors.white);
                prefs.remove("anatomy");
              } else {
                thirdFavourite =
                    Icon(Icons.star, size: 35, color: Colors.white);
                prefs.setString("anatomy", "Favourite");
              }
            });
          },
        ),
        Subject(
          'assests/4.png',
          SubjectsList.documents[3].data['SubjectName'],
          SubjectsList.documents[3].data['DoctorName'],
          Color(0xff54AD66),
          () {
            if (checkedSSL == true) {
              try {
                heightofpic = 150;
                widthofpic = 150;

                ImagetoShow = "assests/4.png";
                buttonColor = Color(0xff54AD66);
                subjectname = SubjectsList.documents[3].data['\$id'];
                subjectaccess = "1111";
                Navigator.of(context).push(_createRoute(ShowItems()));
              } catch (e) {
                print('Error');
              }
            } else
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('You Have No Access for this Subject'),
                  backgroundColor: Color(0xff54AD66),
                  action: SnackBarAction(
                    label: 'Ok',
                    textColor: Colors.black,
                    onPressed: () {
                      // Code to execute.
                    },
                  ),
                ),
              );
          },
          histologyvisible,
          forthFavourite,
          () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            setState(() {
              if (prefs.getString("histology") == "Favourite") {
                forthFavourite = Icon(Icons.star_border_outlined,
                    size: 35, color: Colors.white);
                prefs.remove("histology");
              } else {
                forthFavourite =
                    Icon(Icons.star, size: 35, color: Colors.white);
                prefs.setString("histology", "Favourite");
              }
            });
          },
        ),
        Subject(
          'assests/5.png',
          SubjectsList.documents[4].data['SubjectName'],
          SubjectsList.documents[4].data['DoctorName'],
          Color(0xff5DD1D1),
          () {
            if (checkedSSL == true) {
              try {
                bottomposition = 10;
                heightofpic = 150;
                widthofpic = 150;

                ImagetoShow = "assests/5.png";
                buttonColor = Color(0xff5DD1D1);
                subjectname = SubjectsList.documents[4].data['\$id'];
                subjectaccess = "1111";
                Navigator.of(context).push(_createRoute(ShowItems()));
              } catch (e) {
                print('Error');
              }
            } else
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('You Have No Access for this Subject'),
                  backgroundColor: Color(0xff5DD1D1),
                  action: SnackBarAction(
                    label: 'Ok',
                    textColor: Colors.black,
                    onPressed: () {
                      // Code to execute.
                    },
                  ),
                ),
              );
          },
          chemistryvisible,
          fifthFavourite,
          () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            setState(() {
              if (prefs.getString("chemistry") == "Favourite") {
                fifthFavourite = Icon(Icons.star_border_outlined,
                    size: 35, color: Colors.white);
                prefs.remove("chemistry");
              } else {
                fifthFavourite =
                    Icon(Icons.star, size: 35, color: Colors.white);
                prefs.setString("chemistry", "Favourite");
              }
            });
          },
        ),
        Subject(
          'assests/6.png',
          SubjectsList.documents[5].data['SubjectName'],
          SubjectsList.documents[5].data['DoctorName'],
          Color(0xff4E97EB),
          () {
            if (checkedSSL == true) {
              try {
                bottomposition = 10;
                heightofpic = 150;
                widthofpic = 150;

                ImagetoShow = "assests/6.png";
                buttonColor = Color(0xff4E97EB);
                subjectname = SubjectsList.documents[5].data['\$id'];
                subjectaccess = "1111";
                Navigator.of(context).push(_createRoute(ShowItems()));
              } catch (e) {
                print('Error');
              }
            } else
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('You Have No Access for this Subject'),
                  backgroundColor: Color(0xff4E97EB),
                  action: SnackBarAction(
                    label: 'Ok',
                    textColor: Colors.black,
                    onPressed: () {
                      // Code to execute.
                    },
                  ),
                ),
              );
          },
          physicsvisibile,
          sixthFavourite,
          () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            setState(() {
              if (prefs.getString("physics") == "Favourite") {
                sixthFavourite = Icon(Icons.star_border_outlined,
                    size: 35, color: Colors.white);
                prefs.remove("physics");
              } else {
                sixthFavourite =
                    Icon(Icons.star, size: 35, color: Colors.white);
                prefs.setString("physics", "Favourite");
              }
            });
          },
        ),
        Subject(
          'assests/7.png',
          SubjectsList.documents[6].data['SubjectName'],
          SubjectsList.documents[6].data['DoctorName'],
          Color(0xffD390EC),
          () {
            if (checkedSSL == true) {
              try {
                bottomposition = -2;
                heightofpic = 170;
                widthofpic = 150;

                ImagetoShow = "assests/7.png";
                buttonColor = Color(0xffD390EC);
                subjectname = SubjectsList.documents[6].data['\$id'];
                subjectaccess = "1111";
                Navigator.of(context).push(_createRoute(ShowItems()));
              } catch (e) {
                print('Error');
              }
            } else
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('You Have No Access for this Subject'),
                  backgroundColor: Color(0xffD390EC),
                  action: SnackBarAction(
                    label: 'Ok',
                    textColor: Colors.black,
                    onPressed: () {
                      // Code to execute.
                    },
                  ),
                ),
              );
          },
          zoologyvisible,
          seventhFavourite,
          () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            setState(
              () {
                if (prefs.getString("zoology") == "Favourite") {
                  seventhFavourite = Icon(Icons.star_border_outlined,
                      size: 35, color: Colors.white);
                  prefs.remove("zoology");
                } else {
                  seventhFavourite =
                      Icon(Icons.star, size: 35, color: Colors.white);
                  prefs.setString("zoology", "Favourite");
                }
              },
            );
          },
        ),
      ],
    );
  }
}

class ColoredSafeArea extends StatelessWidget {
  final Widget child;
  final Color color;

  const ColoredSafeArea({Key? key, required this.child, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SafeArea(
        child: child,
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  late Color primary;
  late double amountofradius;
  late VoidCallback press;
  late Widget child;
  late double width;
  late double height;

  RoundedButton(
      {Key? key,
      required this.primary,
      required this.amountofradius,
      required this.press,
      required this.child,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: primary,
            elevation: 0.5,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(amountofradius),
            ),
          ),
          // on Presses Elevated Button
          onPressed: press,
          child: child),
    );
  }
}

class Subject extends StatelessWidget {
  late String picture;
  late String subjectname;
  late String drname;
  late Color primary;
  late VoidCallback press;
  late VoidCallback pressfavourite;
  late bool visibility;
  late Icon markedIcon;

  Subject(this.picture, this.subjectname, this.drname, this.primary, this.press,
      this.visibility, this.markedIcon, this.pressfavourite);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: visibility
            ? Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 220,
                        height: 270,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: primary,
                            elevation: 0.5,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25),
                            ),
                          ),
                          // on Presses Elevated Button
                          onPressed: press,
                          child: Column(
                            children: [
                              Image.asset(
                                picture,
                                width: 190,
                                height: 170,
                                alignment: Alignment.center,
                              ),
                              Text(
                                subjectname,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22),
                              ),
                              Text(drname,
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15))
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 9,
                        child:
                            InkWell(onTap: pressfavourite, child: markedIcon),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  )
                ],
              )
            : Visibility(
                visible: visibility,
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 220,
                          height: 270,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primary,
                              elevation: 0.5,
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(25),
                              ),
                            ),
                            // on Presses Elevated Button
                            onPressed: press,
                            child: Column(
                              children: [
                                Image.asset(
                                  picture,
                                  width: 190,
                                  height: 170,
                                  alignment: Alignment.center,
                                ),
                                Text(
                                  subjectname,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 22),
                                ),
                                Text(drname,
                                    style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 15))
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 15,
                          child: markedIcon,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ));
  }
}

class SearchSubjectes extends SearchDelegate {
  var names = [
    dotenv.env['Name1']!,
    dotenv.env['Name2']!,
    dotenv.env['Name3']!,
    dotenv.env['Name4']!,
    dotenv.env['Name5']!,
    dotenv.env['Name6']!,
    dotenv.env['Name7']!,
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: LoadCoursesVar,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                itemCount: query == ""
                    ? snapshot.data.documents.length
                    : filternames.length,
                itemBuilder: (context, i) {
                  return Container(
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
                                bottom: -2,
                                right: 10,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 8,
                                      primary: buttonColor,
                                      shape: new CircleBorder()),
                                  onPressed: () {
                                    if (query == "") {
                                      if (names[i] == "Material") {
                                        if (material != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            heightofpic = 150;
                                            widthofpic = 145;

                                            ImagetoShow = "assests/1.png";
                                            buttonColor = Color(0xff57b8eb);
                                            subjectaccess = material;
                                            subjectname = "material";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (names[i] == "Morphology") {
                                        if (morphology != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            heightofpic = 150;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/2.png";
                                            buttonColor = Color(0xffF9AF2A);
                                            subjectaccess = morphology;
                                            subjectname = "morphology";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (names[i] == "Anatomy") {
                                        if (anatomy != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            heightofpic = 150;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/3.png";
                                            buttonColor = Color(0xff737FB4);
                                            subjectaccess = anatomy;
                                            subjectname = "anatomy";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (names[i] == "Histology") {
                                        if (histology != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            heightofpic = 150;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/4.png";
                                            buttonColor = Color(0xff54AD66);
                                            subjectaccess = histology;
                                            subjectname = "histology";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (names[i] == "Chemistry") {
                                        if (chemistry != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            bottomposition = 10;
                                            heightofpic = 150;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/5.png";
                                            buttonColor = Color(0xff5DD1D1);
                                            subjectaccess = chemistry;
                                            subjectname = "chemistry";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (names[i] == "Physics") {
                                        if (physics != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            bottomposition = 10;
                                            heightofpic = 150;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/6.png";
                                            buttonColor = Color(0xff4E97EB);
                                            subjectaccess = physics;
                                            subjectname = "physics";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (names[i] == "Zoology") {
                                        if (zoology != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            bottomposition = -2;
                                            heightofpic = 170;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/7.png";
                                            buttonColor = Color(0xffD390EC);
                                            subjectaccess = zoology;
                                            subjectname = "zoology";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }
                                    } else {
                                      if (filternames[i] == "Material") {
                                        if (material != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            heightofpic = 150;
                                            widthofpic = 145;

                                            ImagetoShow = "assests/1.png";
                                            buttonColor = Color(0xff57b8eb);
                                            subjectaccess = material;
                                            subjectname = "material";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (filternames[i] == "Morphology") {
                                        if (morphology != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            heightofpic = 150;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/2.png";
                                            buttonColor = Color(0xffF9AF2A);
                                            subjectaccess = morphology;
                                            subjectname = "morphology";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (filternames[i] == "Anatomy") {
                                        if (anatomy != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            heightofpic = 150;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/3.png";
                                            buttonColor = Color(0xff737FB4);
                                            subjectaccess = anatomy;
                                            subjectname = "anatomy";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (filternames[i] == "Histology") {
                                        if (histology != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            heightofpic = 150;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/4.png";
                                            buttonColor = Color(0xff54AD66);
                                            subjectaccess = histology;
                                            subjectname = "histology";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (filternames[i] == "Chemistry") {
                                        if (chemistry != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            bottomposition = 10;
                                            heightofpic = 150;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/5.png";
                                            buttonColor = Color(0xff5DD1D1);
                                            subjectaccess = chemistry;
                                            subjectname = "chemistry";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (filternames[i] == "Physics") {
                                        if (physics != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            bottomposition = 10;
                                            heightofpic = 150;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/6.png";
                                            buttonColor = Color(0xff4E97EB);
                                            subjectaccess = physics;
                                            subjectname = "physics";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }

                                      if (filternames[i] == "Zoology") {
                                        if (zoology != "0000" &&
                                            checkedSSL == true) {
                                          try {
                                            bottomposition = -2;
                                            heightofpic = 170;
                                            widthofpic = 150;

                                            ImagetoShow = "assests/7.png";
                                            buttonColor = Color(0xffD390EC);
                                            subjectaccess = zoology;
                                            subjectname = "zoology";
                                            Navigator.of(context).push(
                                                _createRoute(ShowItems()));
                                          } catch (e) {
                                            print('Error');
                                          }
                                        } else
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                  'You Have No Access for this Subject'),
                                              backgroundColor:
                                                  Color(0xffF9AF2A),
                                              action: SnackBarAction(
                                                label: 'Ok',
                                                textColor: Colors.black,
                                                onPressed: () {
                                                  // Code to execute.
                                                },
                                              ),
                                            ),
                                          );
                                      }
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
                          child: query == ""
                              ? Text("${names[i]}")
                              : Text("${filternames[i]}"),
                        ),
                      ],
                    ),
                  );
                });
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    filternames = [];
    filternames2 = [];
    return FutureBuilder(
        future: LoadCoursesVar,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              filternames.add([
                snapshot.data.documents[i].data['SubjectName'],
                snapshot.data.documents[i].data['\$id']
              ]);
            }
            filternames2 = filternames
                .where((element) =>
                    element.toString().toLowerCase().contains(query))
                .toList();
            return ListView.builder(
              itemCount: query == ""
                  ? snapshot.data.documents.length
                  : filternames2.length,
              itemBuilder: (context, i) {
                return Container(
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
                              bottom: -2,
                              right: 10,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 8,
                                    primary: buttonColor,
                                    shape: new CircleBorder()),
                                onPressed: () {
                                  if (checkedSSL == true) {
                                    bottomposition = -2;
                                    heightofpic = 170;
                                    widthofpic = 150;

                                    ImagetoShow = "assests/7.png";
                                    buttonColor = Color(0xffD390EC);
                                    subjectaccess = "1111";
                                    if (query == "") {
                                      subjectname = snapshot
                                          .data.documents[i].data['\$id'];
                                      Navigator.of(context)
                                          .push(_createRoute(ShowItems()));
                                    } else {
                                      var videoIDs = filternames2[i]
                                          .toString()
                                          .substring(filternames2[i]
                                                  .toString()
                                                  .indexOf(',') +
                                              2);
                                      subjectname = videoIDs.substring(
                                          0, videoIDs.indexOf(']'));
                                      Navigator.of(context)
                                          .push(_createRoute(ShowItems()));
                                    }
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
                          child: query == ""
                              ? Text(
                                  "${snapshot.data.documents[i].data['SubjectName']}")
                              : Text("${filternames2[i][0]}")),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

Route _createRoute(var Page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

// SearchChooseSubjcet() {
//   if (names[i] == "Material") {
//     if ( material != "0000" && checkedSSL == true) {
//       try {
//         heightofpic = 150;
//         widthofpic = 145;
//         currentButton == stats.Practical
//             ? intialindex = 1
//             : intialindex = 0;
//         ImagetoShow = "assests/1.png";
//         buttonColor = Color(0xff57b8eb);
//         subjectaccess = material;
//         subjectname = "material";
//         Navigator.of(context).push(_createRoute());
//       } catch (e) {
//         print('Error');
//       }
//     }
//   }
//
//   if (names[i] == "Material") {
//     if ( material != "0000" && checkedSSL == true) {
//       try {
//         heightofpic = 150;
//         widthofpic = 150;
//         currentButton == stats.Practical
//             ? intialindex = 1
//             : intialindex = 0;
//         ImagetoShow = "assests/2.png";
//         buttonColor = Color(0xffF9AF2A);
//         subjectaccess = morphology;
//         subjectname = "morphology";
//         Navigator.of(context).push(_createRoute());
//       } catch (e) {
//         print('Error');
//       }
//     }
//   }
//
//   if (names[i] == "Material") {
//     if ( material != "0000" && checkedSSL == true) {
//       try {
//         heightofpic = 150;
//         widthofpic = 150;
//         currentButton == stats.Practical
//             ? intialindex = 1
//             : intialindex = 0;
//         ImagetoShow = "assests/3.png";
//         buttonColor = Color(0xff737FB4);
//         subjectaccess = anatomy;
//         subjectname = "anatomy";
//         Navigator.of(context).push(_createRoute());
//       } catch (e) {
//         print('Error');
//       }
//     }
//   }
//
//   if (names[i] == "Material") {
//     if ( material != "0000" && checkedSSL == true) {
//       try {
//         heightofpic = 150;
//         widthofpic = 150;
//         currentButton == stats.Practical
//             ? intialindex = 1
//             : intialindex = 0;
//         ImagetoShow = "assests/4.png";
//         buttonColor = Color(0xff54AD66);
//         subjectaccess = histology;
//         subjectname = "histology";
//         Navigator.of(context).push(_createRoute());
//       } catch (e) {
//         print('Error');
//       }
//     }
//   }
//
//   if (names[i] == "Material") {
//     if ( material != "0000" && checkedSSL == true) {
//       try {
//         bottomposition = 10;
//         heightofpic = 150;
//         widthofpic = 150;
//         currentButton == stats.Practical
//             ? intialindex = 1
//             : intialindex = 0;
//         ImagetoShow = "assests/5.png";
//         buttonColor = Color(0xff5DD1D1);
//         subjectaccess = chemistry;
//         subjectname = "chemistry";
//         Navigator.of(context).push(_createRoute());
//       } catch (e) {
//         print('Error');
//       }
//     }
//   }
//
//   if (names[i] == "Material") {
//     if ( material != "0000" && checkedSSL == true) {
//       try {
//         bottomposition = 10;
//         heightofpic = 150;
//         widthofpic = 150;
//         currentButton == stats.Practical
//             ? intialindex = 1
//             : intialindex = 0;
//         ImagetoShow = "assests/6.png";
//         buttonColor = Color(0xff4E97EB);
//         subjectaccess = physics;
//         subjectname = "physics";
//         Navigator.of(context).push(_createRoute());
//       } catch (e) {
//         print('Error');
//       }
//     }
//   }
//
//   if (names[i] == "Material") {
//     if ( material != "0000" && checkedSSL == true) {
//       try {
//         bottomposition = -2;
//         heightofpic = 170;
//         widthofpic = 150;
//         currentButton == stats.Practical
//             ? intialindex = 1
//             : intialindex = 0;
//         ImagetoShow = "assests/7.png";
//         buttonColor = Color(0xffD390EC);
//         subjectaccess = zoology;
//         subjectname = "zoology";
//         Navigator.of(context).push(_createRoute());
//       } catch (e) {
//         print('Error');
//       }
//     }
//   }
// }
RecentlyCourses() {
  var Recently = database.listDocuments(
    collectionId: dotenv.env['Subjects']!,
    limit: 7,
    orderTypes: ["DESC"]
  );
  return Recently;
}

LoadMySubject() {
  var LoadIt = teams.list();
  return LoadIt;
}
