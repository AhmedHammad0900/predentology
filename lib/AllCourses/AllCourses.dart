import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:predent/HomeScreen/HomeScreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../JsonData/ssl_pinning.dart';
import '../Videos/Show_Items.dart';
import 'package:predent/HomeScreen//HomeScreen.dart';
import '../main.dart';
import '../theme.dart';
Future<dynamic>? LoadCoursesVar ;
class AllCourses extends StatefulWidget {
  const AllCourses({Key? key}) : super(key: key);

  @override
  State<AllCourses> createState() => _AllCoursesState();
}

class _AllCoursesState extends State<AllCourses> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LoadCoursesVar,
      builder: (BuildContext context,
          AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            checkedSSL == true) {
          return Scaffold(
            body: Column(
              children: [
                Container(
                  height: 100.h,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0.h),
                    child: Row(
                      children: [
                        IconButton(onPressed: () {
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back_ios)),
                        Text(
                          "All Courses",
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 25.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.4,
                        child: Container(
                          decoration: GradiantSignIn,
                        ),
                      ),
                      GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisExtent: 250),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, i) {
                            return DoctorCard(snapshot.data.documents[i]!.data['SubjectName']!, snapshot.data.documents[i].data['DoctorName'], snapshot.data.documents[i]!.data['Photo']!, () {                                if ( checkedSSL == true) {
                              try {
                                heightofpic = 150;
                                widthofpic = 150;
                                ImagetoShow = "assests/4.png";
                                buttonColor = Color(0xff54AD66);
                                subjectname = snapshot.data.documents[i].data['\$id'];
                                subjectaccess = "1111";
                                Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) => ShowItems(),
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
                                ));
                              } catch (e) {
                                print('Error');
                              }
                            } else
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'You Have No Access for this Subject'),
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
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget DoctorCard(String SubjectName, String DrName, String Photo, VoidCallback Pressed) {
    return InkWell(
      onTap: Pressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff0A95F5).withOpacity(0.7)),
                        width: 170.w,
                        height: 240.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              Photo,
                              fit: BoxFit.fitWidth,
                              width: 170.w,
                              height: 130.h,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0.w, right: 8.w, top: 3.h),
                                child: Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        SubjectName,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp,
                                            color: Colors.white),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top :8.0),
                                            child: Text(
                                              DrName,
                                              style: TextStyle(
                                                  fontFamily: 'OpenSans',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13.sp,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))),
              ),
            ],
          )
        ],
      ),
    );
  }



}

LoadCourses() async {
  var LoadCourses = await database.listDocuments(
    collectionId: dotenv.env['Subjects']!,
    limit: 100,
  );
  return LoadCourses ;
}