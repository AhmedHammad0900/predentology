//// To parse this JSON data, do
//
//     final allDocuments = allDocumentsFromJson(jsonString);
/*
import 'dart:convert';

AllDocuments allDocumentsFromJson(String str) => AllDocuments.fromJson(json.decode(str));

String allDocumentsToJson(AllDocuments data) => json.encode(data.toJson());

class AllDocuments {
  AllDocuments({
    this.sum,
    this.documents,
  });

  int? sum ;
  List<Document>? documents;

  factory AllDocuments.fromJson(Map<String, dynamic> json) => AllDocuments(
    sum: json["sum"],
    documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sum": sum,
    "documents": List<dynamic>.from(documents!.map((x) => x.toJson())),
  };
}

class Document {
  Document({
    this.id,
    this.collection,
    this.permissions,
    this.material,
    this.morphology,
    this.anatomy,
    this.histology,
    this.chemistry,
    this.physics,
    this.zoology,
    this.carving,
    this.deviceId,
  });

  String? id;
  String? collection;
  Permissions? permissions;
  String? material;
  String? morphology;
  String? anatomy;
  String? histology;
  String? chemistry;
  String? physics;
  String? zoology;
  String? carving;
  String? deviceId;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    id: json["\u0024id"],
    collection: json["\u0024collection"],
    permissions: Permissions.fromJson(json["\u0024permissions"]),
    material: json["Material"],
    morphology: json["Morphology"],
    anatomy: json["Anatomy"],
    histology: json["Histology"],
    chemistry: json["Chemistry"],
    physics: json["Physics"],
    zoology: json["Zoology"],
    carving: json["Carving"],
    deviceId: json["deviceId"],
  );

  Map<String, dynamic> toJson() => {
    "\u0024id": id,
    "\u0024collection": collection,
    "\u0024permissions": permissions!.toJson(),
    "Material": material,
    "Morphology": morphology,
    "Anatomy": anatomy,
    "Histology": histology,
    "Chemistry": chemistry,
    "Physics": physics,
    "Zoology": zoology,
    "Carving": carving,
    "deviceId": deviceId,
  };
}

class Permissions {
  Permissions({
    this.read,
    this.write,
  });

  List<String>? read;
  List<String>? write;

  factory Permissions.fromJson(Map<String, dynamic> json) => Permissions(
    read: List<String>.from(json["read"].map((x) => x)),
    write: List<String>.from(json["write"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "read": List<dynamic>.from(read!.map((x) => x)),
    "write": List<dynamic>.from(write!.map((x) => x)),
  };
}*/
