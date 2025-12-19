// Classe de base pour les exceptions
abstract class AppException implements Exception {
  final String message;
  final String? prefix;
  final String? url;

  AppException(this.message, this.prefix, this.url);

  @override
  String toString() {
    return message;
  }
}

// Types d'exceptions spécifiques
class FetchDataException extends AppException {
  FetchDataException(String message, String? url)
      : super(message, "Erreur lors de la communication : ", url);
}

class BadRequestException extends AppException {
  BadRequestException(String message, String? url)
      : super(message, "Requête invalide : ", url);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String message, String? url)
      : super(message, "Non autorisé : ", url);
}

class ForbiddenException extends AppException {
  ForbiddenException(String message, String? url)
    : super(message, "Non autorisé : ", url);
}

class NotFoundException extends AppException {
  NotFoundException(String message, String? url)
      : super(message, "Ressource non trouvée : ", url);
}

class InvalidInputException extends AppException {
  InvalidInputException(String message)
      : super(message, "Entrée invalide : ", null);
}

class ServerException extends AppException {
  ServerException(String message, String? url)
      : super(message, "Erreur du serveur : ", url);
}

class CacheException extends AppException {
  CacheException(String message)
      : super(message, "Erreur de cache : ", null);
}

class NetworkException extends AppException {
  NetworkException(String message)
      : super(message, "Erreur réseau : ", null);
}

class AuthenticationException extends AppException {
  AuthenticationException(String message)
      : super(message, "Erreur d'authentification : ", null);
}

class TimeoutException extends AppException {
  TimeoutException(String message, String? url)
      : super(message, "Délai d'attente dépassé : ", url);
}

class UnknownException extends AppException {
  UnknownException(String message)
      : super(message, "Erreur inconnue : ", null);
}
