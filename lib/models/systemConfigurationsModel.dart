class SystemConfigurations {
  int? id;
  String? configOptions;
  String? value;

  SystemConfigurations({this.id, this.configOptions, this.value});

  SystemConfigurations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    configOptions = json['config_options'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['config_options'] = this.configOptions;
    data['value'] = this.value;
    return data;
  }
}