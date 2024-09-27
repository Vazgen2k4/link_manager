import 'package:link_manager/logic/models/link/app_link.dart';

class Folder {
  String? name;
  int? position; 
  String? link;
  late List<AppLink> appLinks;

  Folder({
    this.name,
    this.position,
    List<AppLink>? appLinks,
    this.link,
  }) : appLinks = appLinks ?? [];

  Folder.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    position = json['position'];
    link = json['link'];
    appLinks = <AppLink>[];
    if (json['AppLinks'] != null) {
      json['AppLinks'].forEach((v) {
        appLinks.add(AppLink.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['position'] = position;
    data['link'] = link;

    data['AppLinks'] = appLinks.map((v) => v.toJson()).toList();

    return data;
  }
}
