class Visit {
  String? id;
  String? patientId;
  String? dateTime;
  String? diagnosis;
  String? paymentId;
  Payment? payment;

  Visit(
      {this.id,
      this.patientId,
      this.dateTime,
      this.diagnosis,
      this.paymentId,
      this.payment});

  Visit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    dateTime = json['date_time'];
    diagnosis = json['diagnosis'];
    paymentId = json['payment_id'];
    payment =
        json['payment'] != null ?  Payment.fromJson(json['payment']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['date_time'] = this.dateTime;
    data['diagnosis'] = this.diagnosis;
    data['payment_id'] = this.paymentId;
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    return data;
  }
}

class Payment {
  String? id;
  String? patientId;
  String? date;
  String? amount;
  String? notes;
  String? type;

  Payment(
      {this.id, this.patientId, this.date, this.amount, this.notes, this.type});

  Payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    date = json['date'];
    amount = json['amount'];
    notes = json['notes'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['notes'] = this.notes;
    data['type'] = this.type;
    return data;
  }
}
