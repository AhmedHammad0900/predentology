import 'package:ssl_pinning_plugin/ssl_pinning_plugin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

bool checkedSSL = false;

Future checkSSL(String requestURL) async {

  String _fingerprint =
  dotenv.env['SSL_SHA']! ;
  List<String> allowedShA1FingerprintList = [];
  allowedShA1FingerprintList.add(_fingerprint);
  try {
    await SslPinningPlugin.check(
      serverURL: requestURL,
      httpMethod: HttpMethod.Get,
      sha: SHA.SHA1,
      allowedSHAFingerprints: allowedShA1FingerprintList,
      timeout: 60,
    ).then((value) {
      if (value == "CONNECTION_SECURE") {
        checkedSSL = true;
      } else if (value == "CONNECTION_NOT_SECURE") {
        checkedSSL = false;
      } else {
        checkedSSL = false;
      }
    });
    return checkedSSL;
  } catch (e) {
  }
}