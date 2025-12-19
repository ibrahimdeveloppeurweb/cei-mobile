import 'package:cei_mobile/model/partie_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';

class ValidationUtils {
  /// Validates the current step based on store state
  static bool validateStep(CandidatureStore store, Partie? selectedPartie) {
    switch (store.currentStep) {
      case 0: // Declaration de candidature
        return _validateDeclaration(store);
      case 1: // Personal information
        return _validatePersonalInfo(store);
      case 2: // Candidature status
        return _validateCandidatureStatus(store, selectedPartie);
      case 3: // Filiation
        return _validateFiliation(store);
      case 4: // Visual identity
        return _validateVisualIdentity(store);
      case 5: // Documents
        return _validateDocuments(store);
      case 6: // Payment
        return _validatePayment(store);
      case 7: // Final validation
        return _validateFinalDeclarations(store);
      default:
        return true;
    }
  }

  static bool _validateDeclaration(CandidatureStore store) {
    if (store.declarationCandidature == null) {
      toast('Veuillez télécharger votre déclaration de candidature');
      return false;
    }
    return true;
  }

  static bool _validatePersonalInfo(CandidatureStore store) {
    if (store.nom.isEmpty ||
        store.prenoms.isEmpty ||
        store.dateNaissance == null ||
        store.lieuNaissance.isEmpty ||
        store.sexe == null ||
        store.profession.isEmpty ||
        store.domicile.isEmpty) {
      toast('Veuillez remplir tous les champs obligatoires');
      return false;
    }
    return true;
  }

  static bool _validateCandidatureStatus(CandidatureStore store, Partie? selectedPartie) {
    if (store.appartientPartiPolitique == null) {
      toast('Veuillez choisir votre statut de candidature');
      return false;
    }

    // If party member, validate party selection
    if (store.appartientPartiPolitique == true) {
      if (selectedPartie == null) {
        toast('Veuillez sélectionner un parti politique');
        return false;
      }
    }
    return true;
  }

  static bool _validateFiliation(CandidatureStore store) {
    if (store.filiationPere.isEmpty || store.filiationMere.isEmpty) {
      toast('Veuillez renseigner les informations des parents');
      return false;
    }
    return true;
  }

  static bool _validateVisualIdentity(CandidatureStore store) {
    if (store.couleurBulletin == null || store.sigleChoisi?.isEmpty == true) {
      toast('Veuillez choisir une couleur et un sigle');
      return false;
    }
    return true;
  }

  static bool _validateDocuments(CandidatureStore store) {
    final requiredDocs = store.documentsSelonElection.values
        .where((doc) => doc.obligatoire)
        .toList();
    final missingDocs = requiredDocs
        .where((doc) => doc.fichier == null)
        .toList();

    // Uncomment if you want to enforce document upload
    // if (missingDocs.isNotEmpty) {
    //   toast('Documents manquants: ${missingDocs.map((doc) => doc.nom).join(', ')}');
    //   return false;
    // }
    return true;
  }

  static bool _validatePayment(CandidatureStore store) {
    if (store.modePaiementCautionnement == null ||
        store.preuveCautionnement == null) {
      toast('Veuillez fournir la preuve de paiement du cautionnement');
      return false;
    }
    return true;
  }

  static bool _validateFinalDeclarations(CandidatureStore store) {
    if (!store.declarationHonneur ||
        !store.accepteConditions ||
        !store.accepteTraitementDonnees) {
      toast('Veuillez accepter toutes les déclarations légales');
      return false;
    }
    return true;
  }
}