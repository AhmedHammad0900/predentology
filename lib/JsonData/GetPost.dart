import 'dart:convert' as convert;
import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:predent/SignIn/SignIn.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:predent/main.dart';
import 'package:predent/Videos/Show_Items.dart';

class AppWrite {
  Map<String, String> headers = {
    'X-Appwrite-Project': dotenv.env['PROJECT_ID']!
  };

  // getSessionEmail() async {
  //   Future result = account.createSession(
  //       email: SignInState.EmailController.text,
  //       password: SignInState.PasswordController.text);
  // }
  //
  // getSessionGoogle() async {
  //   var result = await account.createOAuth2Session(provider: 'google');
  // }
  //
  //
  // getToken() async {
  //   http.Response response = await http.post(
  //       Uri.parse(dotenv.env['END_POINT']! + dotenv.env['TOKEN_ACCOUNT']!),
  //       headers: headers);
  // }







// getVideo() async {
//   http.Response response = await http.get(
//       Uri.parse(
//           "${dotenv.env['END_POINT']! + dotenv.env['LIST_STORAGE_FILES']! + response1.documents.last.data['UrlNormalQuality'] + "view?project=" + dotenv.env['PROJECT_ID']!}"),
//   headers:
//       headers);
// }
 }

String getCookies(List<Cookie> cookies) {
  return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
}