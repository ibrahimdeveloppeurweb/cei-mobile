// Ce fichier sera placé dans: lib/services/regula_service.dart

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_reader_api/flutter_document_reader_api.dart'
    as doc_reader;
import 'package:flutter_face_api/flutter_face_api.dart' as face_api;
import 'package:nb_utils/nb_utils.dart';

typedef ProgressCallback = void Function(String message, double? progress);

class RegulaService {
  static final RegulaService _instance = RegulaService._internal();

  factory RegulaService() {
    return _instance;
  }

  RegulaService._internal();

  // Instances des SDKs Regula
  final documentReader = doc_reader.DocumentReader.instance;
  final faceSdk = face_api.FaceSDK.instance;

  // États d'initialisation
  bool _isDocReaderInitialized = false;
  bool _isFaceSdkInitialized = false;

  // Initialisation du Document Reader

  Future<bool> initializeDocumentReader({ProgressCallback? onProgress}) async {
    if (_isDocReaderInitialized) return true;

    try {
      // Callback pour l'initialisation
      void databaseProgressCallback(doc_reader.PrepareProgress progress) {
        if (onProgress != null) {
          // Convertir la progression en pourcentage (0-100)
          double progressPercent = (progress.progress / 100).clamp(0.0, 100.0);
          onProgress('Initialisation...', progressPercent);
        }
        print("Database preparation progress: $progress%");
      }

      // Callback pour la console
      void consoleCallback(String message) {
        if (onProgress != null && message.contains("progress")) {
          onProgress(message, null); // Pas de pourcentage disponible ici
        }
        print("Document Reader: $message");
      }

      // Informer sur le début de l'initialisation
      if (onProgress != null) {
        onProgress('Chargement de la licence...', null);
      }

      // Charger la licence depuis les assets
      ByteData licenseData =
      await rootBundle.load("assets/licences/regula.license");

      // Informer sur la préparation de la base de données
      if (onProgress != null) {
        onProgress('Initialisation...', null);
      }

      // Configurer l'initialisation
      var initConfig = doc_reader.InitConfig(licenseData);

      // Préparer la base de données avec callback de progression
      var (successdb, errordb) =
      await documentReader.prepareDatabase("Full", databaseProgressCallback);

      if (!successdb) {
        print(
            "Erreur de préparation de la base de données: ${errordb?.message}");
        if (onProgress != null) {
          onProgress('Échec de la préparation de la base de données', null);
        }
        return false;
      }

      // Informer sur la configuration du lecteur
      if (onProgress != null) {
        onProgress('Configuration du lecteur de document...', null);
      }

      documentReader.processParams.multipageProcessing = true;
      documentReader.functionality.showSkipNextPageButton = false;
      documentReader.customization.multipageButtonBackgroundColor =
          AppColors.primary;

      // Activer le chargement différé des réseaux de neurones pour de meilleures performances
      initConfig.delayedNNLoad = true;

      // Informer sur l'initialisation du SDK
      if (onProgress != null) {
        onProgress('Initialisation...', null);
      }

      // Initialiser le SDK
      var (success, error) = await documentReader.initializeReader(initConfig);

      if (!success) {
        print("Erreur d'initialisation du Document Reader: ${error?.message}");
        if (onProgress != null) {
          onProgress('Échec de l\'initialisation du lecteur', null);
        }
        return false;
      }

      // Informer sur la finalisation
      if (onProgress != null) {
        onProgress('Initialisation terminée avec succès', 100);
      }

      _isDocReaderInitialized = true;
      return true;
    } catch (e) {
      print("Exception lors de l'initialisation du Document Reader: $e");
      if (onProgress != null) {
        onProgress('Erreur: $e', null);
      }
      return false;
    }
  }

  // Initialisation du Face SDK
  Future<bool> initializeFaceSdk() async {
    if (_isFaceSdkInitialized) return true;

    try {
      ByteData licenseData =
          await rootBundle.load("assets/licences/regula.license");
      var initConfig = face_api.InitConfig(licenseData);
      var (success, error) = await faceSdk.initialize(config: initConfig);
      if (!success) {
        print("Erreur d'initialisation du système: ${error?.code} ${error?.message}");
        return false;
      }
      _isFaceSdkInitialized = true;
      return true;
    } catch (e) {
      print("Exception lors de l'initialisation du système: $e");
      return false;
    }
  }

  // Scanner un document d'identité avec Regula Document Reader
  Future<Map<String, dynamic>> scanDocument() async {
    if (!_isDocReaderInitialized) {
      bool initialized = await initializeDocumentReader();
      if (!initialized) {
        return {
          "success": false,
          "message": "Échec de l'initialisation du Document Reader"
        };
      }
    }

    try {
      // Créer un contrôleur de complétude pour recevoir les résultats
      Completer<Map<String, dynamic>> completer = Completer();

      // Fonction de rappel pour les résultats du scan
      void handleCompletion(
        doc_reader.DocReaderAction action,
        doc_reader.Results? results,
        doc_reader.DocReaderException? error,
      ) {
        if (error != null) {
          completer.complete({
            "success": false,
            "message": error.message,
          });
          return;
        }

        if (action.finished() || action.interrupted() || action.stopped()) {
          if (results == null) {
            completer.complete({
              "success": false,
              "message": "Scan annulé ou aucun résultat obtenu",
            });
            return;
          }

          // Le scan est terminé avec succès, traiter les résultats
          _processDocumentResults(results).then((processedResults) {
            completer.complete({
              "success": true,
              "results": processedResults,
            });
          });
        }
      }

      // Configuration du scanner
      var config =
          doc_reader.ScannerConfig.withScenario(doc_reader.Scenario.FULL_AUTH);
      // Lancement du scan
      documentReader.scan(config, handleCompletion);

      // Attendre et retourner les résultats
      return await completer.future;
    } catch (e) {
      return {"success": false, "message": "Erreur lors du scan: $e"};
    }
  }

  // Improved version of _processDocumentResults in RegulaService.dart
  Future<Map<String, dynamic>> _processDocumentResults(
      doc_reader.Results results) async {
    Map<String, dynamic> processedResults = {};

    try {
      // Extract images
      var documentFrontImage =
      await results.graphicFieldImageByTypeSourcePageIndexLight(
          doc_reader.GraphicFieldType.DOCUMENT_IMAGE,
          doc_reader.ResultType.RAW_IMAGE,
          0,
          doc_reader.Lights.WHITE_FULL);
      var documentBackImage =
      await results.graphicFieldImageByTypeSourcePageIndexLight(
          doc_reader.GraphicFieldType.DOCUMENT_IMAGE,
          doc_reader.ResultType.RAW_IMAGE,
          1,
          doc_reader.Lights.WHITE_FULL);

      var portraitImage = await results.graphicFieldImageByType(
        doc_reader.GraphicFieldType.PORTRAIT,
      );

      // Access text fields via textResult.fields
      final fields = results.textResult!.fields;

      // Create map of extracted values
      Map<String, String> extractedFields = {};

      print("Document type ${results.documentType!.first.type.name}");

      // Process document type first
      if (results.documentType!.first.type == doc_reader.DocType.IdentityCard) {
        extractedFields["documentType"] = "CNI";
        extractedFields["Type de document"] = 'CNI';
        extractedFields["DOCUMENT_CLASS_NAME"] = 'CNI';
      } else if (results.documentType!.first.type == doc_reader.DocType.Passport) {
        extractedFields["documentType"] = 'PASSPORT';
        extractedFields["Type de document"] = 'PASSPORT';
        extractedFields["DOCUMENT_CLASS_NAME"] = 'PASSPORT';
      } else if (results.documentType!.first.type == doc_reader.DocType.ChauffeurLicense) {
        extractedFields["documentType"] = 'PERMIS';
        extractedFields["Type de document"] = 'PERMIS';
        extractedFields["DOCUMENT_CLASS_NAME"] = 'PERMIS';
      }

      else if (results.documentType!.first.type == doc_reader.DocType.TemporaryIdentityCard) {
        extractedFields["documentType"] = 'ATTESTATION';
        extractedFields["Type de document"] = 'ATTESTATION';
        extractedFields["DOCUMENT_CLASS_NAME"] = 'ATTESTATION';
      }

      else {
        // For any other document type
        extractedFields["documentType"] = results.documentType!.first.type.name;
        extractedFields["Type de document"] = results.documentType!.first.type.name;
        extractedFields["DOCUMENT_CLASS_NAME"] = results.documentType!.first.type.name;
      }

      // Process each field
      for (var field in fields) {
        final fieldValue = field.value ?? '';
        final fieldName = field.fieldName;
        final fieldType = field.fieldType;

        print(
            "Processing field: $fieldName (Type: $fieldType) - Value: $fieldValue");

        // Store field by name if available
        if (fieldName.isNotEmpty) {
          extractedFields[fieldName] = fieldValue;
        }

        // Document info
        if (fieldType == doc_reader.FieldType.DOCUMENT_NUMBER) {
          extractedFields["documentNumber"] = fieldValue;
          extractedFields["Numéro de document"] = fieldValue;
          extractedFields["DOCUMENT_NUMBER"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.SERIAL_NUMBER) {
          extractedFields["serialNumber"] = fieldValue;
          extractedFields["Numéro de série"] = fieldValue;
          extractedFields["SERIAL_NUMBER"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.ISSUING_STATE_CODE) {
          extractedFields["issuingState"] = fieldValue;
          extractedFields["Code de l'Etat de délivrance"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.ISSUING_STATE_NAME) {
          extractedFields["issuingStateText"] = fieldValue;
          extractedFields["Etat de délivrance"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.DOCUMENT_CLASS_CODE) {
          extractedFields["documentClassCode"] = fieldValue;
          extractedFields["Code classe document"] = fieldValue;
          extractedFields["DOCUMENT_CLASS_CODE"] = fieldValue;
        }

        // Personal info
        else if (fieldType == doc_reader.FieldType.LAST_NAME ||
            fieldType == doc_reader.FieldType.SURNAME) {
          extractedFields["lastName"] = fieldValue;
          extractedFields["Nom de famille"] = fieldValue;
          extractedFields["LAST_NAME"] = fieldValue;
          extractedFields["SURNAME"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.FIRST_NAME ||
            fieldType == doc_reader.FieldType.GIVEN_NAMES) {
          extractedFields["firstName"] = fieldValue;
          extractedFields["Prénom"] = fieldValue;
          extractedFields["FIRST_NAME"] = fieldValue;
          extractedFields["GIVEN_NAMES"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.SURNAME_AND_GIVEN_NAMES) {
          extractedFields["fullName"] = fieldValue;
          extractedFields["Nom et prénoms"] = fieldValue;
          extractedFields["SURNAME_AND_GIVEN_NAMES"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.DATE_OF_BIRTH) {
          extractedFields["dateOfBirth"] = fieldValue;
          extractedFields["Date de naissance"] = fieldValue;
          extractedFields["DATE_OF_BIRTH"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.PLACE_OF_BIRTH) {
          extractedFields["placeOfBirth"] = fieldValue;
          extractedFields["Lieu de naissance"] = fieldValue;
          extractedFields["PLACE_OF_BIRTH"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.NATIONALITY) {
          extractedFields["nationality"] = fieldValue;
          extractedFields["Nationalité"] = fieldValue;
          extractedFields["NATIONALITY"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.NATIONALITY_CODE) {
          extractedFields["nationalityCode"] = fieldValue;
          extractedFields["Code Nationalité"] = fieldValue;
          extractedFields["NATIONALITY_CODE"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.PERSONAL_NUMBER) {
          extractedFields["personalNumber"] = fieldValue;
          extractedFields["N° personnel"] = fieldValue;
          extractedFields["PERSONAL_NUMBER"] = fieldValue;
        }

        // Dates - ensure we capture all date formats
        else if (fieldType == doc_reader.FieldType.DATE_OF_ISSUE) {
          extractedFields["dateOfIssue"] = fieldValue;
          extractedFields["Date de délivrance"] = fieldValue;
          extractedFields["issueDate"] = fieldValue;
          extractedFields["DATE_OF_ISSUE"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.DATE_OF_EXPIRY) {
          extractedFields["dateOfExpiry"] = fieldValue;
          extractedFields["Date d'expiration"] = fieldValue;
          extractedFields["expireDate"] = fieldValue;
          extractedFields["DATE_OF_EXPIRY"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.PLACE_OF_ISSUE) {
          extractedFields["placeOfIssue"] = fieldValue;
          extractedFields["Lieu de délivrance"] = fieldValue;
          extractedFields["issuePlace"] = fieldValue;
          extractedFields["PLACE_OF_ISSUE"] = fieldValue;
        }

        // Gender/Sex
        else if (fieldType == doc_reader.FieldType.SEX) {
          extractedFields["sex"] = fieldValue;
          extractedFields["Sexe"] = fieldValue;
          extractedFields["gender"] = fieldValue;
          extractedFields["GENDER"] = fieldValue;
          extractedFields["SEX"] = fieldValue;
        }

        // Other info
        else if (fieldType == doc_reader.FieldType.ADDRESS) {
          extractedFields["address"] = fieldValue;
          extractedFields["Adresse"] = fieldValue;
          extractedFields["ADDRESS"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.HEIGHT) {
          extractedFields["height"] = fieldValue;
          extractedFields["Hauteur"] = fieldValue;
          extractedFields["HEIGHT"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.PROFESSION) {
          extractedFields["profession"] = fieldValue;
          extractedFields["Profession"] = fieldValue;
          extractedFields["PROFESSION"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.AGE) {
          extractedFields["age"] = fieldValue;
          extractedFields["Âge"] = fieldValue;
          extractedFields["AGE"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.CARD_ACCESS_NUMBER) {
          extractedFields["cardAccessNumber"] = fieldValue;
          extractedFields["Numéro de carte"] = fieldValue;
          extractedFields["CARD_ACCESS_NUMBER"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.REMAINDER_TERM) {
          extractedFields["remainderTerm"] = fieldValue;
          extractedFields["Mois avant expiration"] = fieldValue;
          extractedFields["REMAINDER_TERM"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.AGE_AT_ISSUE) {
          extractedFields["ageAtIssue"] = fieldValue;
          extractedFields["Âge lors de l'émission"] = fieldValue;
          extractedFields["AGE_AT_ISSUE"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.YEARS_SINCE_ISSUE) {
          extractedFields["yearsSinceIssue"] = fieldValue;
          extractedFields["Années depuis l'émission"] = fieldValue;
          extractedFields["YEARS_SINCE_ISSUE"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.MRZ_STRINGS) {
          extractedFields["mrzStrings"] = fieldValue;
          extractedFields["Champs MRZ"] = fieldValue;
          extractedFields["MRZ_STRINGS"] = fieldValue;
        } else if (fieldType == doc_reader.FieldType.MRZ_TYPE) {
          extractedFields["mrzType"] = fieldValue;
          extractedFields["Type de MRZ"] = fieldValue;
          extractedFields["MRZ_TYPE"] = fieldValue;
        }

        // Always add with the original field type name if available
        String fieldTypeName = fieldType.toString().split('.').last;
        if (fieldTypeName.isNotEmpty) {
          extractedFields[fieldTypeName] = fieldValue;
        }
      }

      // Make sure all dates are properly formatted for consistency
      // This helps when the date format varies between different document types

      print("Extracted fields: $extractedFields");

      // Build the result
      processedResults = {
        "documentFrontImage": documentFrontImage,
        "documentBackImage": documentBackImage,
        "portraitImage": portraitImage,
        "fields": extractedFields
      };
    } catch (e) {
      print("Error processing results: $e");
    }

    return processedResults;
  }

  // Effectuer une vérification de liveness (détection de vivacité)
  Future<Map<String, dynamic>> performLivenessCheck() async {
    if (!_isFaceSdkInitialized) {
      bool initialized = await initializeFaceSdk();
      if (!initialized) {
        return {
          "success": false,
          "message": "Échec de l'initialisation"
        };
      }
    }

    try {
      // Configuration du liveness
      var config = face_api.LivenessConfig(
        skipStep: [
          face_api.LivenessSkipStep.ONBOARDING_STEP
        ], // Ignorer l'étape d'introduction
      );

      // Lancer la vérification de liveness
      var result = await faceSdk.startLiveness(
        config: config,
        notificationCompletion: (notification) {
          print("Liveness notification: ${notification.status}");
        },
      );

      // Vérifier les résultats
      if (result.liveness == face_api.LivenessStatus.PASSED) {
        return {
          "success": true,
          "livenessPassed": true,
          "livenessScore": result.liveness.index,
          "image": result.image,
        };
      } else {
        return {
          "success": true,
          "livenessPassed": false,
          "livenessStatus": result.liveness.name,
          "image": result.image,
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "Erreur lors de la vérification de liveness: $e"
      };
    }
  }

  // Capturer une photo du visage sans vérification de liveness
  Future<Map<String, dynamic>> captureFace() async {
    if (!_isFaceSdkInitialized) {
      bool initialized = await initializeFaceSdk();
      if (!initialized) {
        return {
          "success": false,
          "message": "Échec de l'initialisation du système"
        };
      }
    }

    try {
      // Lancer la capture de visage
      var response = await faceSdk.startFaceCapture();

      if (response.image != null) {
        return {
          "success": true,
          "image": response.image!.image,
          "imageType": response.image!.imageType,
        };
      } else {
        return {"success": false, "message": "Aucune image capturée"};
      }
    } catch (e) {
      return {
        "success": false,
        "message": "Erreur lors de la capture du visage: $e"
      };
    }
  }

  // Comparer deux visages pour vérifier s'il s'agit de la même personne
  Future<Map<String, dynamic>> compareFaces(Uint8List image1, Uint8List image2,
      {double threshold = 0.75}) async {
    if (!_isFaceSdkInitialized) {
      bool initialized = await initializeFaceSdk();
      if (!initialized) {
        return {
          "success": false,
          "message": "Échec de l'initialisation du système"
        };
      }
    }

    try {
      // Créer des images pour la comparaison
      var mfImage1 = face_api.MatchFacesImage(
          image1, face_api.ImageType.LIVE); // Image de selfie en direct
      var mfImage2 = face_api.MatchFacesImage(
          image2, face_api.ImageType.PRINTED); // Image de la pièce d'identité

      // Créer une requête de comparaison
      var request = face_api.MatchFacesRequest([mfImage1, mfImage2]);

      // Effectuer la comparaison
      var response = await faceSdk.matchFaces(request);

      // Diviser les résultats selon le seuil de similarité
      var splitResults =
          await faceSdk.splitComparedFaces(response.results, threshold);

      // Vérifier si des correspondances ont été trouvées
      if (splitResults.matchedFaces.isNotEmpty) {
        // Obtenir le score de similarité (entre 0 et 1)
        double similarity = splitResults.matchedFaces[0].similarity;

        return {
          "success": true,
          "matched": true,
          "similarity": similarity,
          "similarityPercent": (similarity * 100).toStringAsFixed(2),
        };
      } else {
        return {
          "success": true,
          "matched": false,
          "similarity": 0.0,
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": "Erreur lors de la comparaison des visages: $e"
      };
    }
  }

  // Obtenir une liste des scénarios disponibles
  Future<List<doc_reader.DocReaderScenario>> getAvailableScenarios() async {
    if (!_isDocReaderInitialized) {
      bool initialized = await initializeDocumentReader();
      if (!initialized) {
        return [];
      }
    }

    return documentReader.availableScenarios;
  }

  // Vérifier si le lecteur RFID est disponible
  Future<bool> isRfidAvailable() async {
    if (!_isDocReaderInitialized) {
      bool initialized = await initializeDocumentReader();
      if (!initialized) {
        return false;
      }
    }

    return await documentReader.isRFIDAvailableForUse();
  }
}
