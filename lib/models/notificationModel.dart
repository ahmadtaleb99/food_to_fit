import 'dart:developer';

import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/resources/language_manager.dart';
import 'package:food_to_fit/widgets/di.dart';

class NotificationModel {
  String? id;
  String? accountId;
  String? patientId;
  String? title;
  String? content;
  String? date;

  NotificationModel(
      {this.id,
      this.accountId,
      this.patientId,
      this.title,
      this.content,
      this.date});

  @override
  String toString() {
    return 'NotificationModel{id: $id, accountId: $accountId, patientId: $patientId, title: $title, content: $content, date: $date}';
  }

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    patientId = json['patient_id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['account_id'] = this.accountId;
    data['patient_id'] = this.patientId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['date'] = this.date;
    return data;
  }
}

class NotificationResponse {
  String? id;
  String? accountId;
  String? patientId;
  String? title;
  String? content;
  String? date;
  String? parameters;
  Map<String, dynamic>? notificationTemplate;

  NotificationResponse({
    this.id,
    this.accountId,
    this.patientId,
    this.title,
    this.content,
    this.date,
    this.parameters,
    this.notificationTemplate,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> map) {
    return NotificationResponse(
      id: map['id'],
      accountId: map['accountId'],
      patientId: map['patientId'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
      parameters: map['parameters'],
      notificationTemplate:
          map['notificationTemplate'] as Map<String, dynamic>?,
    );
  }

  NotificationModel toModel() {
    String _currentAppLanguage = getIT<AppPreferences>().getAppLanguage();

    //general notification written by hand
    if (this.notificationTemplate == null) {
      return NotificationModel(
        id: this.id,
        accountId: this.accountId,
        patientId: this.patientId,
        title: this.title,
        content: this.content,
        date: this.date,
      );
    }

    //automated notification
    else {
      String parsedTitle = notificationTemplate!['title_$_currentAppLanguage'];
      String parsedContent =
          notificationTemplate!['content_$_currentAppLanguage'];

      if (this.parameters != null) {
        String key = parameters!.split('??').first;
        String value = parameters!.split('??')[1];
        parsedContent.replaceAll(key, value);
      }

      return NotificationModel(
        id: this.id,
        accountId: this.accountId,
        patientId: this.patientId,
        title: parsedTitle,
        content: parsedContent,
        date: this.date,
      );
    }
  }

  @override
  String toString() {
    return 'NotificationResponse{id: $id, accountId: $accountId, patientId: $patientId, title: $title, content: $content, date: $date, parameters: $parameters, notificationTemplate: $notificationTemplate}';
  }
}
