class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});

  @override
  String toString() => 'NetworkException: $message';
}

class InvalidResponseException implements Exception {
  final String message;

  InvalidResponseException({required this.message});

  @override
  String toString() => 'InvalidResponseException: $message';
}

class GenericException implements Exception {
  final String message;

  GenericException({required this.message});

  @override
  String toString() => 'GenericException: $message';
}
