class Language {
  String code;

  Map<String, dynamic> toMap() {
    return {
      'code': this.code,
    };
  }

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      code: map['name'] as String,
    );
  }

  Language({
    required this.code,
  });
}