import 'package:covidapp/Apiresponse/status.dart';

class ApiResponse<T> {
  Status? state;
  String? message;
  T? data;
  ApiResponse({this.state, this.message, this.data});

  ApiResponse.loading() : state = Status.loading;
  ApiResponse.completed(this.data) : state = Status.loading;
  ApiResponse.error(this.message) : state = Status.error;
  @override
  String toString() {
    return "Status: $state\nData: $data\nMessage: $message";
  }
}
