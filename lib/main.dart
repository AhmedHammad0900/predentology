import 'package:appwrite/appwrite.dart';
import 'package:cookie_jar/src/cookie_jar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:http/http.dart' as http;
import 'package:predent/HomeScreen/HomeScreen.dart';
import 'package:predent/JsonData/GetPost.dart';
import 'package:predent/JsonData/Temp.dart';
import 'package:predent/SignIn/SignIn.dart';
import 'package:appwrite/client_io.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';


late Account account;
late ClientIO client;
MyAppState myAppState = MyAppState() ;
late Database database;
late bool acclog = false ;

SignInState AuthScreen = SignInState();
late Storage storage;

late FlutterSecureStorage SecureStorage;
AppWrite checkLogin = AppWrite();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  await dotenv.load(fileName: ".env");
  client = ClientIO();
  database = Database(client);
  SecureStorage = FlutterSecureStorage();
  await client
          .setEndpoint(dotenv.env['END_POINT_SDK_NO_ERROR']!) // Your API Endpoint
          .setProject(dotenv.env['PROJECT_ID']!) // Your project ID
      ;
  storage = Storage(client);
  account = Account(client);
  try {
    var isLogggedHuman = await account.get();
    acclog = true ;
  } catch (e) {
    acclog = false ;
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool? jailbroken;
  bool? developerMode;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dentology',
      theme: ThemeData(),
      home: acclog == false ? SignIn() : HomeScreen(),
    );
  }



}
