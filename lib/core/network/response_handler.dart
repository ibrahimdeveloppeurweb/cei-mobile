import 'dart:convert';
import 'package:http/http.dart' as http;
import '../errors/exceptions.dart';

class ResponseHandler {
  dynamic handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        // Check if response has body
        if (response.body.isEmpty) {
          return null;
        }
        try {
          return json.decode(response.body);
        } catch (e) {
          return response.body;
        }
      case 400:
        throw BadRequestException(
            _getErrorMessage(response), response.request?.url.toString());
      case 401:
        throw UnauthorizedException(
            _getErrorMessage(response), response.request?.url.toString());
      case 409:
        throw NotFoundException(
            _getErrorMessage(response), response.request?.url.toString());
      case 403:
        throw ForbiddenException(
            _getErrorMessage(response), response.request?.url.toString());
      case 404:
        throw NotFoundException(
            'Ressource non trouvée', response.request?.url.toString());
      case 422:
        throw InvalidInputException(_getErrorMessage(response));
      case 500:
      case 502:
      case 503:
      case 504:
        throw ServerException('Une erreur serveur s\'est produite',
            response.request?.url.toString());
      default:
        throw FetchDataException(
          'Une erreur s\'est produite lors de la récupération des données. Code d\'erreur : ${response.statusCode}',
          response.request?.url.toString(),
        );
    }
  }

  String _getErrorMessage(http.Response response) {
    try {
      final decoded = json.decode(response.body);

      // Check different error message formats
      if (decoded is Map<String, dynamic>) {
        if (decoded.containsKey('erreurs')) {
          final errors = decoded['erreurs'];
          if (errors is List && errors.isNotEmpty) {
            return errors.first.toString();
          } else if (errors is Map<String, dynamic>) {
            // Return first error message from nested maps
            final firstKey = errors.keys.first;
            final firstError = errors[firstKey];
            if (firstError is List && firstError.isNotEmpty) {
              return firstError.first.toString();
            }
            return firstError.toString();
          }
        } else if (decoded.containsKey('message')) {
          return decoded['message'];
        } else if (decoded.containsKey('error')) {
          final error = decoded['error'];
          if (error is String) {
            return error;
          } else if (error is Map<String, dynamic> &&
              error.containsKey('message')) {
            return error['message'];
          }
        } else if (decoded.containsKey('errors')) {
          print("Errors are .....");
          final errors = decoded['errors'];
          if (errors is List && errors.isNotEmpty) {
            return errors.first.toString();
          } else if (errors is Map<String, dynamic>) {
            // Return first error message from nested maps
            final firstKey = errors.keys.first;
            final firstError = errors[firstKey];
            if (firstError is List && firstError.isNotEmpty) {
              return firstError.first.toString();
            }
            return firstError.toString();
          }
        }
      }
      return response.reasonPhrase ?? 'Unknown error';
    } catch (e) {
      return response.reasonPhrase ?? 'Unknown error';
    }
  }
}
