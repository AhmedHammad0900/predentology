import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:predent/HomeScreen/HomeScreen.dart';
import 'package:predent/JsonData/GetPost.dart';
import 'package:predent/SignIn/SignIn.dart';
import 'package:appwrite/client_io.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freerasp/talsec_app.dart';
String Root = " " ;
String Root2 = " ";
String Root3 = " ";
String Root4 = " ";
String Root5 = " ";
String Root6 = " ";
String Root7 = " ";
String Root8 = " ";
String Root9 = " ";
late Account account;
late ClientIO client;
MyAppState myAppState = MyAppState() ;
late Database database;
late bool acclog = false ;
late Teams teams ;
SignInState AuthScreen = SignInState();
late Storage storage;

late FlutterSecureStorage SecureStorage;
AppWrite checkLogin = AppWrite();

void main() async {
  await initSecurityState();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  await dotenv.load(fileName: ".env");
    client = ClientIO();
    database = Database(client);
  teams = Teams(client);
    SecureStorage = FlutterSecureStorage();
    await client
        .setEndpoint(dotenv.env['END_POINT_SDK_NO_ERROR']!) // Your API Endpoint
        .setProject(dotenv.env['PROJECT_ID']!) ;
    storage = Storage(client);
    account = Account(client);
    try {
      var isLogggedHuman = await account.get();
      acclog = true;
    } catch (e) {
      acclog = false;
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
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dentology',
        theme: ThemeData(),
        home: acclog == false ? SignIn() : HomeScreen(),
      ),
    );
  }



}

Future<void> initSecurityState() async {

  TalsecConfig config = TalsecConfig(

    // For Android
    androidConfig: AndroidConfig(
      expectedPackageName: 'com.firstdentology.hammad',
      expectedSigningCertificateHash: '5A:B2:F7:C7:27:CC:11:50:44:CC:A9:B0:34:DF:54:57:DD:CD:28:4C',
    ),

    // Common email for Alerts and Reports
    watcherMail: 'ahmedhammad0900@gmail.com',
  );

  TalsecCallback callback = await TalsecCallback(
    // For Android
    androidCallback: AndroidCallback(
      onRootDetected: () => Root ='root',
      onEmulatorDetected: () => Root = 'root',
      onHookDetected: () => Root3 = 'Jailbreak detected',
      onTamperDetected: () => Root4 ='Passcode change detected',
      onDeviceBindingDetected: () => Root5 = 'Passcode detected',
      onUntrustedInstallationDetected: () => Root6 ='Simulator detected',
    ),

    // For iOS
    iosCallback: IOScallback(
      onSignatureDetected: () => Root ='Signature detected',
      onRuntimeManipulationDetected: () =>  Root2 = 'Runtime manipulation detected',
      onJailbreakDetected: () =>  Root = 'root',
      onPasscodeChangeDetected: () => Root4 ='Passcode change detected',
      onPasscodeDetected: () =>  Root5 = 'Passcode detected',
      onSimulatorDetected: () =>  Root ='root',
      onMissingSecureEnclaveDetected: () =>  Root7 = 'Missing secure enclave detected',
      onDeviceChangeDetected: () =>  Root8 ='Device change detected',
      onDeviceIdDetected: () =>  Root9 = 'Device ID detected',
    ),

    // Common for both platforms
    onDebuggerDetected: () => Root = "root",

  );

  TalsecApp app = TalsecApp(
    config: config,
    callback: callback,
  );

  app.start();



}