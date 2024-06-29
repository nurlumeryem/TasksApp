class Failure {
  String message;

  Failure(this.message);
}

class ServiceError extends Failure {
  ServiceError(super.message);
}

class UnImplementedError extends Failure {
  UnImplementedError(super.message);
}
