class ErrorResponse {
  bool? status;
  String? message;

  ErrorResponse({this.status, this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      status: json['status'],
      message: json['message'],
    );
  }

}