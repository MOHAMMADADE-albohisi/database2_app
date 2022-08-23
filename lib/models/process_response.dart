// ignore: camel_case_types
class processResponse {
  final bool success;
  final String message;

  processResponse({
    required this.message,
    this.success = false,
  });
}
