import 'package:flutter/material.dart';

Color FirstSubjectColor = Color(0xff57B8EB);
Color SecondSubjectColor = Color(0xffF9AF2A);
Color ThirdSubjectColor = Color(0xff737FB4);
Color ForthSubjectColor = Color(0xff54AD66);
Color FifthSubjectColor = Color(0xff5DD1D1);
Color SixthSubjectColor = Color(0xff4E97EB);
Color SeventhSubjectColor = Color(0xffD390EC);

TextStyle RegularSan =
    TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w400);

TextStyle SemiBoldSan =
    TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w600);

TextStyle BoldSan = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w700,
  );

TextStyle SubTitleSan = TextStyle(
  fontFamily: 'OpenSans',
  fontWeight: FontWeight.w400,
  color: Color(0xff68696B)
);

BoxDecoration GradiantSignIn = BoxDecoration(

    gradient: LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [

    Color(0xff69F0C5).withOpacity(0.32),
    Color(0xff589DD9).withOpacity(0.32),
    Color(0xff0A95F5).withOpacity(0.85).withOpacity(0.32),
    Color(0xff0857F5).withOpacity(0.32),
  ]
));

BoxDecoration GradiantHome = BoxDecoration(

    gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [

          Color(0xffD8E0E8).withOpacity(0.55),
          Color(0xffDDE5E9).withOpacity(1),
          Color(0xffEFF9FF).withOpacity(1),

        ]
    ));

BoxDecoration HomeGradient = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xffEFF9FF),
    Color(0xffDDE5E9),
    Color(0xffD8E0E8),
  ],
));

BoxDecoration DrawerBackGround = BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xffCFD9FE),
    Color(0xffA5B6F1),
    Color(0xffB0DAFB),
  ],
));
