class Failure {}

class ServerFailure extends Failure {
  final num statusCode;
  final String errorMessage;

  ServerFailure({required this.errorMessage, required this.statusCode});
}

class DioFailure extends Failure {}

class ParsingFailure extends Failure {
  final String errorMessage;

  ParsingFailure({required this.errorMessage});
}

class CacheFailure extends Failure {}


