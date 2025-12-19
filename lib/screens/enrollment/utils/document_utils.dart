import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class IdDocumentUtils {
  // Méthode mise à jour pour mapper les types de documents selon Regula
  static String mapDocumentType(String docType) {
    if (docType.isEmpty) return '';

    final type = docType.toUpperCase().trim();

    switch (type) {
      case 'CNI':
      case 'IDENTITYCARD':
      case 'IDENTITY_CARD':
      case 'CARTE_NATIONALE_IDENTITE':
        return 'Carte Nationale d\'Identité';

      case 'PASSPORT':
      case 'PASSEPORT':
        return 'Passeport';

      case 'PERMIS':
      case 'CHAUFFEUNLICENSE':
      case 'CHAUFFEUR_LICENSE':
      case 'DRIVING_LICENSE':
      case 'PERMIS_CONDUIRE':
        return 'Permis de conduire';

      case 'CARTE_SEJOUR':
      case 'RESIDENCE_PERMIT':
        return 'Carte de séjour';

      case 'ATTESTATION_IDENTITE':
      case 'ATTESTATION':
      case 'TEMPORARY_IDENTITY_CARD':
        return 'Attestation d\'identité';
      case 'TemporaryIdentityCard':
        return 'Attestation d\'identité';
      default:
      // Si le type n'est pas reconnu, retourner le type original mais formaté
        return _formatDocumentTypeName(docType);
    }
  }

  // Méthode helper pour formater les noms de documents non reconnus
  static String _formatDocumentTypeName(String originalType) {
    if (originalType.isEmpty) return 'Document non identifié';

    // Remplacer les underscores par des espaces et capitaliser
    String formatted = originalType
        .replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty
        ? word[0].toUpperCase() + word.substring(1)
        : word)
        .join(' ');

    return formatted;
  }

  // Méthode pour vérifier si le document est une CNI valide
  static bool isValidCNI(String? docType) {
    if (docType == null || docType.isEmpty) return false;

    final normalizedType = docType.toUpperCase().trim();
    return normalizedType == 'CNI' ||
        normalizedType == 'CARTE NATIONALE D\'IDENTITÉ' ||
        normalizedType == 'IDENTITYCARD' ||
        normalizedType == 'IDENTITY_CARD';
  }

  // Méthode pour obtenir le code du type de document
  static String getDocumentTypeCode(String? docType) {
    if (docType == null || docType.isEmpty) return '';

    switch (docType.toUpperCase().trim()) {
      case 'CARTE NATIONALE D\'IDENTITÉ':
      case 'CNI':
        return 'CNI';
      case 'PASSEPORT':
      case 'PASSPORT':
        return 'PASSPORT';
      case 'PERMIS DE CONDUIRE':
      case 'PERMIS':
        return 'PERMIS';
      case 'CARTE DE SÉJOUR':
        return 'SEJOUR';
      case 'ATTESTATION D\'IDENTITÉ':
        return 'ATTESTATION';
      case 'TemporaryIdentityCard':
        return 'ATTESTATION';
      default:
        return 'OTHER';
    }
  }

  // Méthode pour obtenir la description du document
  static String getDocumentDescription(String? docType) {
    if (docType == null || docType.isEmpty) return 'Document non identifié';

    switch (docType.toUpperCase().trim()) {
      case 'CARTE NATIONALE D\'IDENTITÉ':
      case 'CNI':
        return 'Carte Nationale d\'Identité ivoirienne';
      case 'PASSEPORT':
      case 'PASSPORT':
        return 'Passeport de la République de Côte d\'Ivoire';
      case 'PERMIS DE CONDUIRE':
      case 'PERMIS':
        return 'Permis de conduire ivoirien';
      case 'CARTE DE SÉJOUR':
        return 'Carte de séjour pour étrangers';
      case 'ATTESTATION D\'IDENTITÉ':
        return 'Attestation d\'identité temporaire';
      case 'TemporaryIdentityCard':
        return 'Attestation d\'identité temporaire';
      default:
        return docType;
    }
  }

  // Méthode pour vérifier si le document permet l'enrôlement électoral
  static bool isEligibleForEnrollment(String? docType) {
    if (docType == null || docType.isEmpty) return false;

    // Selon le Code Électoral ivoirien, seule la CNI est acceptée pour l'enrôlement
    return isValidCNI(docType);
  }

  // Méthode pour obtenir le message d'erreur selon le type de document
  static String getDocumentErrorMessage(String? docType) {
    if (docType == null || docType.isEmpty) {
      return 'Type de document non détecté. Veuillez re-scanner votre pièce d\'identité.';
    }

    if (isValidCNI(docType)) {
      return ''; // Pas d'erreur
    }

    final code = getDocumentTypeCode(docType);
    switch (code) {
      case 'PASSPORT':
        return 'Le passeport n\'est pas accepté pour l\'enrôlement électoral. '
            'Conformément au Code Électoral ivoirien, seule la Carte Nationale d\'Identité (CNI) est requise.';
      case 'PERMIS':
        return 'Le permis de conduire n\'est pas accepté pour l\'enrôlement électoral. '
            'Vous devez présenter votre Carte Nationale d\'Identité (CNI).';
      case 'SEJOUR':
        return 'La carte de séjour n\'est pas valide pour l\'enrôlement électoral. '
            'Les ressortissants étrangers doivent d\'abord obtenir la nationalité ivoirienne.';
      case 'ATTESTATION':
        return 'L\'attestation d\'identité n\'est pas suffisante pour l\'enrôlement électoral. '
            'Veuillez vous procurer une Carte Nationale d\'Identité (CNI) valide.';
      default:
        return 'Ce type de document ($docType) n\'est pas accepté pour l\'enrôlement électoral. '
            'Seule la Carte Nationale d\'Identité (CNI) ivoirienne est requise.';
    }
  }

  // Méthodes existantes conservées...
  static String getFieldValue(Map<String, dynamic> fields, List<String> possibleKeys) {
    for (String key in possibleKeys) {
      if (fields.containsKey(key) && fields[key] != null) {
        return fields[key].toString().trim();
      }
    }
    return '';
  }

  static String formatDate(String dateString) {
    if (dateString.isEmpty) return '';

    try {
      // Essayer différents formats de date
      DateTime? date;

      // Format YYYY-MM-DD
      if (dateString.contains('-') && dateString.length >= 10) {
        date = DateTime.tryParse(dateString);
      }
      // Format DD/MM/YYYY
      else if (dateString.contains('/')) {
        final parts = dateString.split('/');
        if (parts.length == 3) {
          final day = int.tryParse(parts[0]);
          final month = int.tryParse(parts[1]);
          final year = int.tryParse(parts[2]);
          if (day != null && month != null && year != null) {
            date = DateTime(year, month, day);
          }
        }
      }
      // Format DDMMYYYY
      else if (dateString.length == 8) {
        final day = int.tryParse(dateString.substring(0, 2));
        final month = int.tryParse(dateString.substring(2, 4));
        final year = int.tryParse(dateString.substring(4, 8));
        if (day != null && month != null && year != null) {
          date = DateTime(year, month, day);
        }
      }

      if (date != null) {
        return "${date.day.toString().padLeft(2, '0')}/"
            "${date.month.toString().padLeft(2, '0')}/"
            "${date.year}";
      }
    } catch (e) {
      print('Erreur lors du formatage de la date: $e');
    }

    return dateString; // Retourner la date originale si le formatage échoue
  }

  static DateTime? parseDate(String dateString) {
    if (dateString.isEmpty) return null;

    try {
      // Format DD/MM/YYYY
      if (dateString.contains('/')) {
        final parts = dateString.split('/');
        if (parts.length == 3) {
          final day = int.tryParse(parts[0]);
          final month = int.tryParse(parts[1]);
          final year = int.tryParse(parts[2]);
          if (day != null && month != null && year != null) {
            return DateTime(year, month, day);
          }
        }
      }
      // Format YYYY-MM-DD
      else if (dateString.contains('-')) {
        return DateTime.tryParse(dateString);
      }
      // Format DDMMYYYY
      else if (dateString.length == 8) {
        final day = int.tryParse(dateString.substring(0, 2));
        final month = int.tryParse(dateString.substring(2, 4));
        final year = int.tryParse(dateString.substring(4, 8));
        if (day != null && month != null && year != null) {
          return DateTime(year, month, day);
        }
      }
    } catch (e) {
      print('Erreur lors du parsing de la date: $e');
    }

    return null;
  }

  static Future<File> createTempFileWithRandomName(Uint8List bytes, String prefix) async {
    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(10000);
    final fileName = '${prefix}_${timestamp}_$random.jpg';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(bytes.toList());
    return file;
  }
}