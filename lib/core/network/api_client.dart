import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:mime/mime.dart';
import '../constants/api_constants.dart';
import '../errors/exceptions.dart';
import 'response_handler.dart';

class TokenManager {
  String? _token;
  String? _refreshToken;

  String? get token => _token;
  String? get refreshToken => _refreshToken;

  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  void setTokens({required String token, String? refreshToken}) {
    _log('Setting tokens');
    _log(
        'New access token: ${token.isNotEmpty ? '***${token.substring(token.length - 5)}' : 'empty'}');
    if (refreshToken != null) {
      _log(
          'New refresh token: ${refreshToken.isNotEmpty ? '***${refreshToken.substring(refreshToken.length - 5)}' : 'empty'}');
    }
    _token = token;
    _refreshToken = refreshToken;
  }

  void clearTokens() {
    _log('Clearing tokens');
    _token = null;
    _refreshToken = null;
  }

  Map<String, String> get authHeaders {
    return isAuthenticated ? {'Authorization': 'Bearer $_token'} : {};
  }

  void _log(String message) {
    print('[TokenManager] $message');
  }
}

class ApiClient {
  final http.Client _client;
  final ResponseHandler _responseHandler;
  final TokenManager _tokenManager;
  final bool _enableLogging;

  ApiClient({
    required http.Client client,
    required ResponseHandler responseHandler,
    required TokenManager tokenManager,
    bool enableLogging = true,
  })  : _client = client,
        _responseHandler = responseHandler,
        _tokenManager = tokenManager,
        _enableLogging = enableLogging;

  void _log(String message) {
    if (!_enableLogging) return;
    print('[ApiClient] $message');
  }

  void _logRequest(String method, Uri uri, Map<String, String> headers,
      [dynamic body]) {
    if (!_enableLogging) return;

    final logLines = [
      '╔═══════════════════════════════════════════════════════════════',
      '║ REQUEST: $method ${uri.path}',
      '╟───────────────────────────────────────────────────────────────',
      '║ URL: ${uri.toString()}',
      '║ Headers:',
    ];

    headers.forEach((key, value) {
      if (key.toLowerCase() == 'authorization') {
        logLines
            .add('║   $key: Bearer ***${value.substring(value.length - 5)}');
      } else {
        logLines.add('║   $key: $value');
      }
    });

    if (body != null) {
      logLines.add('║ Body:');
      if (body is String) {
        logLines.add('║   $body');
      } else if (body is Map) {
        try {
          logLines.add('║   ${jsonEncode(body)}');
        } catch (e) {
          logLines.add('║   $body (non-JSON serializable map)');
        }
      } else {
        logLines.add('║   $body');
      }
    }

    logLines.add(
        '╚═══════════════════════════════════════════════════════════════');
    print(logLines.join('\n'));
  }

  void _logMultipartRequest(http.MultipartRequest request) {
    if (!_enableLogging) return;

    final logLines = [
      '╔═══════════════════════════════════════════════════════════════',
      '║ MULTIPART REQUEST: ${request.method} ${request.url.path}',
      '╟───────────────────────────────────────────────────────────────',
      '║ URL: ${request.url.toString()}',
      '║ Headers:',
    ];

    request.headers.forEach((key, value) {
      if (key.toLowerCase() == 'authorization') {
        logLines
            .add('║   $key: Bearer ***${value.substring(value.length - 5)}');
      } else {
        logLines.add('║   $key: $value');
      }
    });

    // Log fields
    if (request.fields.isNotEmpty) {
      logLines.add('║ Fields:');
      request.fields.forEach((key, value) {
        if (key.toLowerCase().contains('password') ||
            key.toLowerCase().contains('token')) {
          logLines.add('║   $key: ******');
        } else {
          logLines.add('║   $key: $value');
        }
      });
    }

    // Log files
    if (request.files.isNotEmpty) {
      logLines.add('║ Files:');
      for (var file in request.files) {
        logLines
            .add('║   ${file.field}: ${file.filename} (${file.contentType})');
      }
    }

    logLines.add(
        '╚═══════════════════════════════════════════════════════════════');
    print(logLines.join('\n'));
  }

  void _logResponse(http.Response response) {
    if (!_enableLogging) return;

    final logLines = [
      '╔═══════════════════════════════════════════════════════════════',
      '║ RESPONSE: ${response.request?.method} ${response.request?.url.path}',
      '╟───────────────────────────────────────────────────────────────',
      '║ Status: ${response.statusCode}',
      '║ Headers:',
    ];

    response.headers.forEach((key, value) {
      logLines.add('║   $key: $value');
    });

    try {
      final responseBody = jsonDecode(response.body);
      logLines.add('║ Body:');
      logLines.add('║   ${jsonEncode(responseBody)}');
    } catch (e) {
      logLines.add('║ Body: (non-JSON)');
      logLines.add(
          '║   ${response.body.length > 1000 ? '${response.body.substring(0, 1000)}...' : response.body}');
    }

    logLines.add(
        '╚═══════════════════════════════════════════════════════════════');
    print(logLines.join('\n'));
  }

  void _logError(String method, String endpoint, dynamic error) {
    if (!_enableLogging) return;

    final logLines = [
      '╔═══════════════════════════════════════════════════════════════',
      '║ ERROR: $method $endpoint',
      '╟───────────────────────────────────────────────────────────────',
      '║ ${error.toString()}',
      '╚═══════════════════════════════════════════════════════════════',
    ];
    print(logLines.join('\n'));
  }

  // Helper method to handle token refresh and retry
  Future<dynamic> _executeWithTokenRefresh(
      Future<http.Response> Function(Map<String, String> headers)
          apiCall) async {
    try {
      // Include auth headers in the request
      final headers = {...ApiConstants.headers, ..._tokenManager.authHeaders};
      final response = await apiCall(headers);
      return _responseHandler.handleResponse(response);
    } catch (e) {
      // Check if the error is due to token expiration (401 status)
      if (e is UnauthorizedException) {
        _logError('_executeWithTokenRefresh', 'API Call',
            'Unauthorized - attempting token refresh');

        // Try to refresh the token if we have a refresh token
        if (_tokenManager.refreshToken != null) {
          try {
            await _refreshToken();
            _log('Token refresh successful, retrying original request');

            // Retry the API call with new token
            final headers = {
              ...ApiConstants.headers,
              ..._tokenManager.authHeaders
            };
            final response = await apiCall(headers);
            return _responseHandler.handleResponse(response);
          } catch (refreshError) {
            _logError(
                '_executeWithTokenRefresh', 'Token Refresh', refreshError);

            // If token refresh fails, clear tokens and propagate the error
            _tokenManager.clearTokens();
            throw AuthenticationException(
                'Session expired, please login again');
          }
        } else {
          _log('No refresh token available, clearing session');
          _tokenManager.clearTokens();
          throw AuthenticationException('Session expired, please login again');
        }
      }

      // For other exceptions, just rethrow
      if (e is AppException) rethrow;
      throw UnknownException(e.toString());
    }
  }

  // Helper method to handle token refresh for multipart requests
  Future<dynamic> _executeMultipartWithTokenRefresh(
      Future<http.StreamedResponse> Function(Map<String, String> headers)
          apiCall) async {
    try {
      // Include auth headers in the request
      final headers = {...ApiConstants.headers, ..._tokenManager.authHeaders};
      final streamedResponse = await apiCall(headers);

      // Convert StreamedResponse to Response for the handler
      final responseBytes = await streamedResponse.stream.toBytes();
      final response = http.Response(
        String.fromCharCodes(responseBytes),
        streamedResponse.statusCode,
        headers: streamedResponse.headers,
        request: streamedResponse.request,
      );

      return _responseHandler.handleResponse(response);
    } catch (e) {
      // Check if the error is due to token expiration (401 status)
      if (e is UnauthorizedException) {
        _logError('_executeMultipartWithTokenRefresh', 'API Call',
            'Unauthorized - attempting token refresh');

        // Try to refresh the token if we have a refresh token
        if (_tokenManager.refreshToken != null) {
          try {
            await _refreshToken();
            _log('Token refresh successful, retrying original request');

            // Retry the API call with new token
            final headers = {
              ...ApiConstants.headers,
              ..._tokenManager.authHeaders
            };
            final streamedResponse = await apiCall(headers);

            // Convert StreamedResponse to Response for the handler
            final responseBytes = await streamedResponse.stream.toBytes();
            final response = http.Response(
              String.fromCharCodes(responseBytes),
              streamedResponse.statusCode,
              headers: streamedResponse.headers,
              request: streamedResponse.request,
            );

            return _responseHandler.handleResponse(response);
          } catch (refreshError) {
            _logError('_executeMultipartWithTokenRefresh', 'Token Refresh',
                refreshError);

            // If token refresh fails, clear tokens and propagate the error
            _tokenManager.clearTokens();
            throw AuthenticationException(
                'Session expired, please login again');
          }
        } else {
          _log('No refresh token available, clearing session');
          _tokenManager.clearTokens();
          throw AuthenticationException('Session expired, please login again');
        }
      }

      // For other exceptions, just rethrow
      if (e is AppException) rethrow;
      throw UnknownException(e.toString());
    }
  }

  // Method to refresh token
  Future<void> _refreshToken() async {
    try {
      final uri = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.apiVersion + '/token/refresh');
      final body = {'refreshToken': _tokenManager.refreshToken};

      _logRequest('POST', uri, ApiConstants.headers, body);

      final response = await _client
          .post(
            uri,
            headers: ApiConstants.headers,
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(milliseconds: ApiConstants.connectionTimeout),
            onTimeout: () => throw TimeoutException(
                'Refresh token request timed out', '/token/refresh'),
          );

      _logResponse(response);

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['token'] != null) {
        _tokenManager.setTokens(
          token: responseData['token'],
          refreshToken:
              responseData['refreshToken'] ?? _tokenManager.refreshToken,
        );
      } else {
        throw AuthenticationException('Failed to refresh token');
      }
    } catch (e) {
      _logError('_refreshToken', '/token/refresh', e);
      throw AuthenticationException('Token refresh failed: ${e.toString()}');
    }
  }

  // GET request
  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _executeWithTokenRefresh((authHeaders) async {
      try {
        final uri =
            Uri.parse(ApiConstants.baseUrl + ApiConstants.apiVersion + endpoint)
                .replace(queryParameters: queryParameters);

        _logRequest('GET', uri, {...authHeaders, ...?headers});

        final response = await _client.get(
          uri,
          headers: {...authHeaders, ...?headers},
        ).timeout(
          const Duration(milliseconds: ApiConstants.connectionTimeout),
          onTimeout: () =>
              throw TimeoutException('Request timed out', endpoint),
        );

        _logResponse(response);
        return response;
      } on SocketException {
        _logError('GET', endpoint, 'No internet connection');
        throw NetworkException('No internet connection');
      } catch (e) {
        _logError('GET', endpoint, e);
        if (e is AppException) rethrow;
        throw UnknownException(e.toString());
      }
    });
  }

  // POST request
  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _executeWithTokenRefresh((authHeaders) async {
      try {
        final uri =
            Uri.parse(ApiConstants.baseUrl + ApiConstants.apiVersion + endpoint)
                .replace(queryParameters: queryParameters);

        _logRequest('POST', uri, {...authHeaders, ...?headers}, body);

        final response = await _client
            .post(
              uri,
              headers: {...authHeaders, ...?headers},
              body: body != null ? jsonEncode(body) : null,
            )
            .timeout(
              const Duration(milliseconds: ApiConstants.connectionTimeout),
              onTimeout: () =>
                  throw TimeoutException('Request timed out', endpoint),
            );

        _logResponse(response);
        return response;
      } on SocketException {
        _logError('POST', endpoint, 'No internet connection');
        throw NetworkException('No internet connection');
      } catch (e) {
        _logError('POST', endpoint, e);
        if (e is AppException) rethrow;
        throw UnknownException(e.toString());
      }
    });
  }

  // POST FormData with file upload
  Future<dynamic> postFormData(
    String endpoint, {
    Map<String, dynamic>? fields,
    Map<String, File>? files,
    Map<String, List<File>>? multiFiles,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _executeMultipartWithTokenRefresh((authHeaders) async {
      try {
        final uri =
            Uri.parse(ApiConstants.baseUrl + ApiConstants.apiVersion + endpoint)
                .replace(queryParameters: queryParameters);

        final request = http.MultipartRequest('POST', uri);

        // Add headers
        request.headers.addAll({
          ...authHeaders,
          ...?headers,
        });

        // Add text fields
        if (fields != null) {
          fields.forEach((key, value) {
            request.fields[key] = value;
          });
        }

        // Add single files
        if (files != null) {
          for (var entry in files.entries) {
            final file = entry.value;
            final fileName = path.basename(file.path);

            // Try to detect MIME type
            String? mimeType = lookupMimeType(file.path);

            // Default to octet-stream if we can't detect
            final contentType = mimeType != null
                ? MediaType.parse(mimeType)
                : MediaType('application', 'octet-stream');

            final multipartFile = await http.MultipartFile.fromPath(
              entry.key,
              file.path,
              contentType: contentType,
              filename: fileName,
            );

            request.files.add(multipartFile);
          }
        }

        // Add multiple files with the same field name
        if (multiFiles != null) {
          for (var entry in multiFiles.entries) {
            for (var file in entry.value) {
              final fileName = path.basename(file.path);

              // Try to detect MIME type
              String? mimeType = lookupMimeType(file.path);

              // Default to octet-stream if we can't detect
              final contentType = mimeType != null
                  ? MediaType.parse(mimeType)
                  : MediaType('application', 'octet-stream');

              final multipartFile = await http.MultipartFile.fromPath(
                entry.key,
                file.path,
                contentType: contentType,
                filename: fileName,
              );

              request.files.add(multipartFile);
            }
          }
        }

        _logMultipartRequest(request);

        // Send the request
        final streamedResponse = await request.send().timeout(
              const Duration(milliseconds: ApiConstants.connectionTimeout),
              onTimeout: () => throw TimeoutException(
                  'Multipart request timed out', endpoint),
            );

        return streamedResponse;
      } on SocketException {
        _logError('POST (FormData)', endpoint, 'No internet connection');
        throw NetworkException('No internet connection');
      } catch (e) {
        _logError('POST (FormData)', endpoint, e);
        if (e is AppException) rethrow;
        throw UnknownException(e.toString());
      }
    });
  }

  // PUT request
  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _executeWithTokenRefresh((authHeaders) async {
      try {
        final uri =
            Uri.parse(ApiConstants.baseUrl + ApiConstants.apiVersion + endpoint)
                .replace(queryParameters: queryParameters);

        _logRequest('PUT', uri, {...authHeaders, ...?headers}, body);

        final response = await _client
            .put(
              uri,
              headers: {...authHeaders, ...?headers},
              body: body != null ? jsonEncode(body) : null,
            )
            .timeout(
              const Duration(milliseconds: ApiConstants.connectionTimeout),
              onTimeout: () =>
                  throw TimeoutException('Request timed out', endpoint),
            );

        _logResponse(response);
        return response;
      } on SocketException {
        _logError('PUT', endpoint, 'No internet connection');
        throw NetworkException('No internet connection');
      } catch (e) {
        _logError('PUT', endpoint, e);
        if (e is AppException) rethrow;
        throw UnknownException(e.toString());
      }
    });
  }

  // PUT FormData with file upload
  Future<dynamic> putFormData(
    String endpoint, {
    Map<String, String>? fields,
    Map<String, File>? files,
    Map<String, List<File>>? multiFiles,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _executeMultipartWithTokenRefresh((authHeaders) async {
      try {
        final uri =
            Uri.parse(ApiConstants.baseUrl + ApiConstants.apiVersion + endpoint)
                .replace(queryParameters: queryParameters);

        final request = http.MultipartRequest('PUT', uri);

        // Add headers
        request.headers.addAll({
          ...authHeaders,
          ...?headers,
        });

        // Add text fields
        if (fields != null) {
          fields.forEach((key, value) {
            request.fields[key] = value;
          });
        }

        // Add single files
        if (files != null) {
          for (var entry in files.entries) {
            final file = entry.value;
            final fileName = path.basename(file.path);

            // Try to detect MIME type
            String? mimeType = lookupMimeType(file.path);

            // Default to octet-stream if we can't detect
            final contentType = mimeType != null
                ? MediaType.parse(mimeType)
                : MediaType('application', 'octet-stream');

            final multipartFile = await http.MultipartFile.fromPath(
              entry.key,
              file.path,
              contentType: contentType,
              filename: fileName,
            );

            request.files.add(multipartFile);
          }
        }

        // Add multiple files with the same field name
        if (multiFiles != null) {
          for (var entry in multiFiles.entries) {
            for (var file in entry.value) {
              final fileName = path.basename(file.path);

              // Try to detect MIME type
              String? mimeType = lookupMimeType(file.path);

              // Default to octet-stream if we can't detect
              final contentType = mimeType != null
                  ? MediaType.parse(mimeType)
                  : MediaType('application', 'octet-stream');

              final multipartFile = await http.MultipartFile.fromPath(
                entry.key,
                file.path,
                contentType: contentType,
                filename: fileName,
              );

              request.files.add(multipartFile);
            }
          }
        }

        _logMultipartRequest(request);

        // Send the request
        final streamedResponse = await request.send().timeout(
              const Duration(milliseconds: ApiConstants.connectionTimeout),
              onTimeout: () => throw TimeoutException(
                  'Multipart request timed out', endpoint),
            );

        return streamedResponse;
      } on SocketException {
        _logError('PUT (FormData)', endpoint, 'No internet connection');
        throw NetworkException('No internet connection');
      } catch (e) {
        _logError('PUT (FormData)', endpoint, e);
        if (e is AppException) rethrow;
        throw UnknownException(e.toString());
      }
    });
  }

  // DELETE request
  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _executeWithTokenRefresh((authHeaders) async {
      try {
        final uri =
            Uri.parse(ApiConstants.baseUrl + ApiConstants.apiVersion + endpoint)
                .replace(queryParameters: queryParameters);

        _logRequest('DELETE', uri, {...authHeaders, ...?headers}, body);

        final response = await _client
            .delete(
              uri,
              headers: {...authHeaders, ...?headers},
              body: body != null ? jsonEncode(body) : null,
            )
            .timeout(
              const Duration(milliseconds: ApiConstants.connectionTimeout),
              onTimeout: () =>
                  throw TimeoutException('Request timed out', endpoint),
            );

        _logResponse(response);
        return response;
      } on SocketException {
        _logError('DELETE', endpoint, 'No internet connection');
        throw NetworkException('No internet connection');
      } catch (e) {
        _logError('DELETE', endpoint, e);
        if (e is AppException) rethrow;
        throw UnknownException(e.toString());
      }
    });
  }

  // PATCH request
  Future<dynamic> patch(
    String endpoint, {
    Map<String, String>? headers,
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _executeWithTokenRefresh((authHeaders) async {
      try {
        final uri =
            Uri.parse(ApiConstants.baseUrl + ApiConstants.apiVersion + endpoint)
                .replace(queryParameters: queryParameters);

        _logRequest('PATCH', uri, {...authHeaders, ...?headers}, body);

        final response = await _client
            .patch(
              uri,
              headers: {...authHeaders, ...?headers},
              body: body != null ? jsonEncode(body) : null,
            )
            .timeout(
              const Duration(milliseconds: ApiConstants.connectionTimeout),
              onTimeout: () =>
                  throw TimeoutException('Request timed out', endpoint),
            );

        _logResponse(response);
        return response;
      } on SocketException {
        _logError('PATCH', endpoint, 'No internet connection');
        throw NetworkException('No internet connection');
      } catch (e) {
        _logError('PATCH', endpoint, e);
        if (e is AppException) rethrow;
        throw UnknownException(e.toString());
      }
    });
  }

  // Login method that sets the tokens
  Future<dynamic> login(String username, String password) async {
    try {
      final uri =
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.apiVersion}/login');
      final body = {'username': username, 'password': password};

      _logRequest('POST', uri, ApiConstants.headers, body);

      final response = await _client
          .post(
            uri,
            headers: ApiConstants.headers,
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(milliseconds: ApiConstants.connectionTimeout),
            onTimeout: () => throw TimeoutException(
                'Login request timed out', '/auth/login'),
          );

      _logResponse(response);

      final responseData = _responseHandler.handleResponse(response);

      // Store the tokens
      if (responseData['data']['token'] != null) {
        _tokenManager.setTokens(
          token: responseData['data']['token'],
          refreshToken: responseData['data']['refreshToken'],
        );
      }

      return responseData;
    } on SocketException {
      _logError('login', '/auth/login', 'No internet connection');
      throw NetworkException('No internet connection');
    } catch (e) {
      _logError('login', '/auth/login', e);
      if (e is AppException) rethrow;
      throw UnknownException(e.toString());
    }
  }

  // Logout method that clears the tokens
  void logout() {
    _log('Logging out user');
    _tokenManager.clearTokens();
  }
}
