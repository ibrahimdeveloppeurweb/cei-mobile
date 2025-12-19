// lib/features/enrollment/utils/document_utils.dart

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

class DocumentUtils {
  /// Format date from YYYYMMDD format to DD/MM/YYYY
  static String formatDate(String date) {
    try {
      // Regula renvoie souvent les dates au format YYYYMMDD
      if (date.length == 8) {
        return "${date.substring(6, 8)}/${date.substring(4, 6)}/${date.substring(0, 4)}";
      }
      return date;
    } catch (e) {
      return date;
    }
  }

  /// Parse date string to DateTime
  static DateTime? parseDate(String date) {
    try {
      // Handle "YYYYMMDD" format
      if (date.length == 8 && !date.contains('/')) {
        int year = int.parse(date.substring(0, 4));
        int month = int.parse(date.substring(4, 6));
        int day = int.parse(date.substring(6, 8));
        return DateTime(year, month, day);
      }

      // Handle "DD/MM/YYYY" format
      else if (date.contains('/')) {
        List<String> parts = date.split('/');
        if (parts.length == 3) {
          int day = int.parse(parts[0]);
          int month = int.parse(parts[1]);
          int year = int.parse(parts[2]);
          return DateTime(year, month, day);
        }
      }

      return null;
    } catch (e) {
      print('Error parsing date: $e for date: $date');
      return null;
    }
  }

  /// Map document type from Regula to human-readable format
  static String? mapDocumentType(String? documentType) {
    if (documentType == null) return null;

    if (documentType.contains('ID') || documentType.contains('IDENTITY')) {
      return 'Carte Nationale d\'Identité';
    } else if (documentType.contains('PASSPORT')) {
      return 'Passeport';
    } else if (documentType.contains('DRIVING') || documentType.contains('DRIVER')) {
      return 'Permis de conduire';
    } else if (documentType.contains('RESIDENCE')) {
      return 'Carte de séjour';
    }

    return documentType;
  }

  /// Helper to get field value with multiple possible keys
  static String getFieldValue(Map<String, dynamic> fields, List<String> possibleKeys, {String defaultValue = ''}) {
    for (String key in possibleKeys) {
      if (fields.containsKey(key) && fields[key] != null && fields[key].toString().isNotEmpty) {
        return fields[key].toString();
      }
    }
    return defaultValue;
  }

  /// Create a temporary file with a random name
  static Future<File> createTempFileWithRandomName(Uint8List bytes, String prefix) async {
    final tempDir = Directory.systemTemp;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomSuffix = (100000 + Random().nextInt(900000)); // 6-digit random number
    final fileName = '${prefix}_${timestamp}_$randomSuffix.jpg';
    final filePath = '${tempDir.path}/$fileName';

    final file = File(filePath);
    return await file.writeAsBytes(bytes);
  }
}