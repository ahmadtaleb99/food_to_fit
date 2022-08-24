class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed_with_true(this.data) : status = Status.COMPLETED_WITH_TRUE;
  ApiResponse.completed_with_false(this.data) : status = Status.COMPLETED_WITH_FALSE;
  ApiResponse.completed_with_internal_error(this.data,this.message) : status = Status.COMPLETED_WITH_INTERNAL_ERROR;
  ApiResponse.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
  ApiResponse();
}
enum Status { LOADING, COMPLETED_WITH_TRUE, COMPLETED_WITH_FALSE, ERROR,COMPLETED_WITH_INTERNAL_ERROR }