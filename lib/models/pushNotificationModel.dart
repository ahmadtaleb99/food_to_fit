import 'dart:developer';

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });

  String? title;
  String? body;

  factory PushNotification.fromJson(Map<String, dynamic> json) {

    log(json.toString());
    return PushNotification(
      title: json["data"]["title"],
      body: json["data"]["body"],
    );
  }
}