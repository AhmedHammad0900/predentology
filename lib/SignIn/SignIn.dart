import 'package:flutter/material.dart';
import 'package:predent/HomeScreen/HomeScreen.dart';
import 'package:predent/JsonData/GetPost.dart';
import 'package:predent/JsonData/ssl_pinning.dart';
import 'package:predent/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:appwrite/appwrite.dart';
import 'package:predent/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignIn extends StatefulWidget {
  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  static TextEditingController EmailController = TextEditingController();
  static TextEditingController PasswordController = TextEditingController();
  AppWrite appWrite = AppWrite();
  final KeyOfSignIn = GlobalKey<FormState>();
  String? ErrorBorder;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    EmailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    checkSSL(dotenv.env['API_SSL']!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
              ),
              Container(
                decoration: GradiantSignIn,
                width: 375.34.w,
                height: 352.08.h,
                child: Image.asset(
                  'assests/casual.png',
                  alignment: Alignment.center,
                ),
              ),
              Positioned(
                top: 315.h,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(top: 25.h, left: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign In",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w700,
                              color: Color(0xff3487FF),
                              fontSize: 30.sp),
                        ),
                        Form(
                          key: KeyOfSignIn,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.h, left: 15.w),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Email can't be empty";
                                      } else if (!value.contains("@")) {
                                        return "Enter valid email please";
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      setState(() {
                                        ErrorBorder = null;
                                      });
                                    },
                                    controller: EmailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3487FF),
                                      fontSize: 16.sp,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 0, left: 15.w),
                                child: Container(
                                  color: Colors.white,
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Password Can't be Empty";
                                      } else
                                        return null;
                                    },
                                    onTap: () {
                                      setState(() {
                                        ErrorBorder = null;
                                      });
                                    },
                                    obscureText: true,
                                    controller: PasswordController,
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff3487FF),
                                      fontSize: 16.sp,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      errorText: ErrorBorder,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15, top: 15),
                              width: MediaQuery.of(context).size.width * 0.80,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (KeyOfSignIn.currentState!.validate()) {
                                    SignWithAppWrite();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 16.5,
                                    ),
                                    primary: Colors.white,
                                    side: BorderSide(
                                      width: 2.0,
                                      color: Color(0xff676565),
                                    )),
                                child: Text(
                                  'Log In',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xff676565), fontSize: 17),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15.0, left: 15),
                              child: Text(
                                "OR",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15, left: 15),
                              child: RoundedButton(
                                amountofradius: 25,
                                primary: Color(0xff4285F4),
                                press: () {
                                  SignInGoogleAppwrite();
                                },
                                width: MediaQuery.of(context).size.width * 0.75,
                                height: 55,
                                child: Row(
                                  children: [
                                    Padding(
                                      child: Image.asset(
                                        'assests/google.png',
                                        height: 42,
                                      ),
                                      padding:
                                          EdgeInsets.only(left: 0, right: 30),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Sign In With Google",
                                          style: TextStyle(
                                            fontFamily: 'OpenSans',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late bool exist;
  late bool isSignedIn;

  void SignInGoogleAppwrite() async {
    if (checkedSSL == true) {
      try {
        await account.createOAuth2Session(
            provider: 'google',
            success: "");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (e) {
        print(e);
      }
    }
  }

  void SignWithAppWrite() async {
    if (checkedSSL == true) {
      try {
        var result = await account.createSession(
            email: SignInState.EmailController.text,
            password: SignInState.PasswordController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } catch (e) {
        setState(() {
          ErrorBorder = "$e";
          print(e);
        });
      }
    }
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(Root),
                Text(Root2),
                Text(Root3),
                Text(Root4),
                Text(Root5),
                Text(Root6),
                Text(Root7),
                Text(Root8),
                Text(Root9),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



}
