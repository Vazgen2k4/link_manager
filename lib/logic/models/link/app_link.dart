import 'package:flutter/foundation.dart';

class AppLink {
  String? value;
  String? text;
  AppLinkType? type;

  AppLink({this.value, this.text, this.type});

  AppLink.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    text = json['text'];
    
    
    // TODO: После миграции убрать это
    try {
      type = AppLinkType.values.byName(json['type']);
    } catch (e) {
      
      if (kDebugMode) {
        print("Нет типа ссылки");
      }
      
      type = _defineType(value);
    }
  }
  
  
  AppLinkType _defineType(String? link) => switch(link?.split(':').first) {
    "tel" => AppLinkType.phone,
    "http" => AppLinkType.link,
    "https" => AppLinkType.link,
    "mailto" => AppLinkType.email,
    _ => AppLinkType.link,
  };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['value'] = value;
    data['text'] = text;
    data['type'] = type?.toString().split(".").last;

    return data;
  }
}

enum AppLinkType {
  link,
  phone,
  email,
  none,
}
