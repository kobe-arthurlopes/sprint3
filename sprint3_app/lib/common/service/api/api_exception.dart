class ApiException implements Exception {
  final String userMessage;
  final String debugMessage;
  final int? statusCode;

  ApiException({required this.userMessage, required this.debugMessage, this.statusCode});

  @override
  String toString() => 'ApiExpection(statusCode: $statusCode, message: $debugMessage)';
}