abstract class Failure {

  final String message;
  Failure({required this.message});
}
class ServerFailure extends Failure {
  final int? statusCode;
  ServerFailure({required String message, this.statusCode}) : super(message: message);
  @override
  String toString() => 'ServerFailure: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}
class NetworkFailure extends Failure {
  NetworkFailure({required String message}) : super(message: message);
  @override
  String toString() => 'NetworkFailure: $message';
}
class InvalidResponseFailure extends Failure {
  InvalidResponseFailure({required String message}) : super(message: message);
  @override
  String toString() => 'InvalidResponseFailure: $message';
}
class GenericFailure extends Failure {
  GenericFailure({required String message}) : super(message: message);
  @override
  String toString() => 'GenericFailure: $message';


}