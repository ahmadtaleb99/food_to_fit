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

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    patientId = json['patient_id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['account_id'] = this.accountId;
    data['patient_id'] = this.patientId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['date'] = this.date;
    return data;
  }
}