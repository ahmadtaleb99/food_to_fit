class DietProgram {
  String? id;
  String? patientId;
  String? type;
  String? condition;
  String? daysNumber;
  String? caloriePlanId;
  String? createdAt;

  DietProgram(
      {this.id,
        this.patientId,
        this.type,
        this.condition,
        this.daysNumber,
        this.caloriePlanId,
        this.createdAt});

  DietProgram.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    type = json['type'];
    condition = json['condition'];
    daysNumber = json['days_number'];
    caloriePlanId = json['calorie_plan_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['type'] = this.type;
    data['condition'] = this.condition;
    data['days_number'] = this.daysNumber;
    data['calorie_plan_id'] = this.caloriePlanId;
    data['created_at'] = this.createdAt;
    return data;
  }
}