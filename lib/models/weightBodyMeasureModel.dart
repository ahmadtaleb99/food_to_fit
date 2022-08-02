class WeightBodyMeasure {
  String? id;
  String? patientId;
  String? bodyMeasureId;
  String? date;
  String? measure;

  WeightBodyMeasure({this.id, this.patientId, this.bodyMeasureId, this.date, this.measure});

  WeightBodyMeasure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    bodyMeasureId = json['body_measure_id'];
    date = json['date'];
    measure = json['measure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['body_measure_id'] = this.bodyMeasureId;
    data['date'] = this.date;
    data['measure'] = this.measure;
    return data;
  }
}