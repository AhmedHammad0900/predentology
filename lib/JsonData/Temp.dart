// import 'package:dart_appwrite/dart_appwrite.dart';
//
//
// void CreateCollection  () async{
//   Client client1 = Client();
//   Database database1 = Database(client1);
//
//   client1.setEndpoint('https://hammaddev.tk/v1')
//       .setProject('6154b36a55445') // Your project ID
//       .setKey('4e62bd3f2bbb1d3c2397896096da42adc535fe7039838eba286560c70ccca031a163179e6775fce2c557378b74a30132bce302070d881748b2e2df706ff7da336598006494270edd4147e71e3f0a6fcf6ee64470eefeec8eda96dd4a8e090a58274525132a1f957c1a597d34c5ce3df04e41a6cc9451c417c8a0e9c00451be91') // Your secret API key
//       ;
//
//   Future result = database1.createCollection(
//     name: 'ZoologyPrac2',
//     read: [
//       "team:615deb5e9a38f"
//     ],
//     write: [],
//     rules: [
//       {
//         "label": "Name",
//         "key": "Name",
//         "type": "text",
//         "default": "",
//         "required": true,
//         "array": false
//       },
//       {
//         "label": "UrlNormalQuality",
//         "key": "UrlNormalQuality",
//         "type": "text",
//         "default": "",
//         "required": true,
//         "array": false
//       },
//       {
//         "label": "UrlHighQuality",
//         "key": "UrlHighQuality",
//         "type": "text",
//         "default": "",
//         "required": false,
//         "array": false
//       },
//     ],
//   );
// }