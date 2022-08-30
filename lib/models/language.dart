class Language {
  final String code;
  final String name;
  final bool isDefault;

  const Language({
    required this.code,
    required this.name,
    required this.isDefault,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': this.code,
      'name': this.name,
      'is_default': this.isDefault,
    };
  }

  factory Language.fromJson(Map<String, dynamic> map) {

    return Language(
      code: map['code'] as String,
      name: map['name'] as String,
      isDefault: map['is_default'] ,
    );
  }
}