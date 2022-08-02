class Day {
  String? id;
  String? dietProgramId;
  String? mealsNumber;
  List<Meals>? meals;

  Day({this.id, this.dietProgramId, this.mealsNumber, this.meals});

  Day.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dietProgramId = json['diet_program_id'];
    mealsNumber = json['meals_number'];
    if (json['meals'] != null) {
      meals =  [];
      json['meals'].forEach((v) {
        meals!.add( Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['diet_program_id'] = this.dietProgramId;
    data['meals_number'] = this.mealsNumber;
    if (this.meals != null) {
      data['meals'] = this.meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meals {
  String? id;
  String? name;
  String? dayId;
  String? englishTextualExplanation;
  String? arabicTextualExplanation;
  String? time;

  Meals(
      {this.id,
        this.name,
        this.dayId,
        this.englishTextualExplanation,
        this.arabicTextualExplanation,
        this.time});

  Meals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dayId = json['day_id'];
    englishTextualExplanation = json['english_textual_explanation'];
    arabicTextualExplanation = json['arabic_textual_explanation'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['day_id'] = this.dayId;
    data['english_textual_explanation'] = this.englishTextualExplanation;
    data['arabic_textual_explanation'] = this.arabicTextualExplanation;
    data['time'] = this.time;
    return data;
  }
}