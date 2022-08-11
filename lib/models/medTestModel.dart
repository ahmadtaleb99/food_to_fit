class MedicalTest {
  MedicalTestDetails? medicalTestDetails;
  List<MedicalTestProperties>? medicalTestProperties;
  List<MedicalTestImages>? medicalTestImages;

  MedicalTest(
      {this.medicalTestDetails,
        this.medicalTestProperties,
        this.medicalTestImages});

  MedicalTest.fromJson(Map<String, dynamic> json) {
    medicalTestDetails = json['medical_test_details'] != null
        ?  MedicalTestDetails.fromJson(json['medical_test_details'])
        : null;
    if (json['medical_test_properties'] != null) {
      medicalTestProperties =  [];
      json['medical_test_properties'].forEach((v) {
        medicalTestProperties!.add( MedicalTestProperties.fromJson(v));
      });
    }
    if (json['medical_test_images'] != null) {
      medicalTestImages =  [];
      json['medical_test_images'].forEach((v) {
        medicalTestImages!.add( MedicalTestImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.medicalTestDetails != null) {
      data['medical_test_details'] = this.medicalTestDetails!.toJson();
    }
    if (this.medicalTestProperties != null) {
      data['medical_test_properties'] =
          this.medicalTestProperties!.map((v) => v.toJson()).toList();
    }
    if (this.medicalTestImages != null) {
      data['medical_test_images'] =
          this.medicalTestImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicalTestDetails {
  String? id;
  String? patientId;
  String? date;
  String? fillStatus;

  MedicalTestDetails({this.id, this.patientId, this.date, this.fillStatus});

  MedicalTestDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    date = json['date'];
    fillStatus = json['fill_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['date'] = this.date;
    data['fill_status'] = this.fillStatus;
    return data;
  }
}

class MedicalTestProperties {
  String? name;
  List<Properties>? properties;


  MedicalTestProperties({this.name, this.properties});

  MedicalTestProperties.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['properties'] != null) {
      properties =  [];
      json['properties'].forEach((v) {
        properties!.add( Properties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = this.name;
    if (this.properties != null) {
      data['properties'] = this.properties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Properties {
  int? id;
  int? typeId;
  double? from;
  double? to;
  String? name;
  String? type;
  String? value;

  Properties({this.id, this.typeId, this.name, this.type,  this.value});

  Properties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['type_id'];
    name = json['name'];
    if(json['range'] != null ) from = double.parse(json['range']['from'].toString());
    type = json['type'];
    if(json['range'] != null ) to = double.parse(json['range']['to'].toString());
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['type_id'] = this.typeId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

class MedicalTestImages {
  String? id;
  String? medicalTestId;
  String? imagePath;

  MedicalTestImages({this.id, this.medicalTestId, this.imagePath});

  MedicalTestImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medicalTestId = json['medical_test_id'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['medical_test_id'] = this.medicalTestId;
    data['image_path'] = this.imagePath;
    return data;
  }
}