import 'dart:io';

import 'package:cei_mobile/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

Future<Map<String, dynamic>> submitScanCustomerpi() async {
  final store = enrollmentStore;
  try {
    // Format dates properly (yyyy-MM-dd)
    String? formatDate(DateTime? date) {
      if (date == null) return null;
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }

    String formatDateWithIntl(String inputDate) {
      // Parse the input date
      final originalFormat = DateFormat('dd/MM/yyyy');
      final date = originalFormat.parse(inputDate);

      // Format to the desired output
      final targetFormat = DateFormat('yyyy-MM-dd');
      return targetFormat.format(date);
    }

    // Prepare form fields
    final fields = {
      // Personal Information
      'lastName': store.lastName,
      'firstName': store.firstName,
      'birthdate': formatDateWithIntl(store.dob), // Note: In the store, birthplace contains the birthdate
      'birthplace': store.city ?? '',
      'gender': store.gender ?? '',
      'profession': store.profession,
      'quartier': store.quarter.validate(value: "N/A"),
      'address': store.address,

      // Parent Information
      'lastNameFather': store.lastNameFather,
      'firstNameFather': store.firstNameFather,
      'birthdateFather': store.birthdateFather,
      'birthplaceFather': store.birthplaceFather,
      'lastNameMother': store.lastNameMother,
      'firstNameMother': store.firstNameMother,
      'birthdateMother': store.birthdateMother,
      'birthplaceMother': store.birthplaceMother,

      // ID Document Information
      'typeCarte': store.idType ?? '',
      'numCarte': store.idNumber,
      'expireDateCarte': formatDate(store.expireDate),
      'deleveryDateCarte': formatDate(store.issueDate),

      // Additional information
      'centreId': store.enrollmentCenter?.id?.toString() ?? '1',
    };

    // Prepare files
    final files = <String, File>{};

    // ID Photo
    if (store.idPhoto != null) {
      files['photoIdentite'] = store.idPhoto!;
    }

    // ID Document Photos
    if (store.idFrontPhoto != null) {
      files['photoCarteRecto'] = store.idFrontPhoto!;
    }

    if (store.idBackPhoto != null) {
      files['photoCarteVerso'] = store.idBackPhoto!;
    }

    if (store.documentFacePhoto != null) {
      files['photoIdentiteCarte'] = store.documentFacePhoto!;
    }

    // Add additional documents as multiFiles
    final multiFiles = <String, List<File>>{};

    // Birth certificate (from step1Files)
    List<File> documents = [];
    for (PlatformFile platformFile in store.step1Files) {
      if (platformFile.path != null) {
        documents.add(File(platformFile.path!));
      }
    }

    // Residence certificate (from step6FilesCertificat)
    for (PlatformFile platformFile in store.step6FilesCertificat) {
      if (platformFile.path != null) {
        documents.add(File(platformFile.path!));
      }
    }

    // Utility bills (from step6FilesCIE)
    for (PlatformFile platformFile in store.step6FilesCIE) {
      if (platformFile.path != null) {
        documents.add(File(platformFile.path!));
      }
    }

    if (documents.isNotEmpty) {
      multiFiles['documents'] = documents;
    }

    debugPrint('Fields: $fields');

    // Submit the enrollment
    final response = await apiClient.postFormData(
      '/enrolements/enroler',
      fields: fields,
      files: files,
      multiFiles: documents.isNotEmpty ? multiFiles : null,
    );

    // Parse the response and return
    return response;
  } catch (e) {
    print('Error submitting enrollment: $e');
    throw Exception('$e');
  }
}