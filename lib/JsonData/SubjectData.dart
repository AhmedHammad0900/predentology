class Parsing {
  late List<Records> records;

  Parsing({required this.records});

  Parsing.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  late String id;
  late Fields? fields;
  late String createdTime;

  Records({required this.id,required this.fields,required this.createdTime});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fields =
    json['fields'] != null ? new Fields.fromJson(json['fields']) : null;
    createdTime = json['createdTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.fields != null) {
      data['fields'] = this.fields!.toJson();
    }
    data['createdTime'] = this.createdTime;
    return data;
  }
}

class Fields {
  late String? urlHighQuality;
  late String urlNormalQuality;
  late String name;

  Fields({ this.urlHighQuality,required this.urlNormalQuality,required this.name});

  Fields.fromJson(Map<String, dynamic> json) {
    urlHighQuality = json['UrlHighQuality'];
    urlNormalQuality = json['UrlNormalQuality'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UrlHighQuality'] = this.urlHighQuality;
    data['UrlNormalQuality'] = this.urlNormalQuality;
    data['Name'] = this.name;
    return data;
  }
}
