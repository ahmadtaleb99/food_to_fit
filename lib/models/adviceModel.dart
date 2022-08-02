class Advice <T> {
  int? id;
  String? title;
  String? imageUrl;
  String? body;

  Advice({this.id, this.title, this.imageUrl, this.body});

  Advice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageUrl = json['image_url'];
    body = json['body'];
  }

}