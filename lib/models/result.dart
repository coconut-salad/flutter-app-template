// ignore: constant_identifier_names
enum Status { OK, FORBIDDEN, ERROR }

class Result<T> {
  Status status;
  String? message;
  T? data;

  Result({required this.status, this.message, this.data});
}
