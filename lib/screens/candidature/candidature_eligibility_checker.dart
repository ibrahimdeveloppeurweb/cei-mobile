import 'package:flutter/material.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:cei_mobile/model/user/user_model.dart';

class CandidatureEligibilityChecker {

  static EligibilityResult checkEligibility({
    required EnrollmentData? enrollmentData,
    required UserModel user,
    required String candidatureType, // 'president', 'depute', 'senateur', 'regional', 'municipal'
  }) {
    List<String> violations = [];
    List<String> articles = [];
    List<String> requirements = []; // What the user needs to meet
    Map<String, dynamic> userDetails = {}; // User's current status

    // 1. Vérifier si l'utilisateur est enrôlé - Message plus clair
    if (enrollmentData == null || enrollmentData.numEnregister == null) {
      violations.add("Vous n'êtes pas inscrit sur la liste électorale");
      requirements.add("Être inscrit sur la liste électorale de la République de Côte d'Ivoire");
      articles.add("Article 17 du Code électoral");
      userDetails['enrollmentStatus'] = 'Non inscrit';

      // Return early since no other checks are meaningful without enrollment
      return EligibilityResult(
        isEligible: false,
        violations: violations,
        articles: articles,
        requirements: requirements,
        userDetails: userDetails,
        requiresEnrollment: true,
      );
    }

    // Store user details for reference
    userDetails['enrollmentNumber'] = enrollmentData.numEnregister;
    userDetails['enrollmentStatus'] = 'Inscrit';
    if (enrollmentData.birthdate != null) {
      final age = DateTime.now().difference(enrollmentData.birthdate!).inDays ~/ 365;
      userDetails['age'] = age;
      userDetails['birthDate'] = enrollmentData.birthdate;
    }
    userDetails['gender'] = enrollmentData.gender ?? 'Non spécifié';
    userDetails['address'] = enrollmentData.address ?? 'Non spécifiée';

    // 2. Vérifier le statut de l'enrôlement (commented out for demo)
    // if (enrollmentData.status == null ||
    //     enrollmentData.status!.toLowerCase() == 'rejete' ||
    //     enrollmentData.status!.toLowerCase() == 'rejeté') {
    //   violations.add("Votre inscription électorale a été rejetée");
    //   requirements.add("Avoir une inscription électorale validée");
    //   articles.add("Article 17 du Code électoral");
    //   userDetails['enrollmentStatus'] = 'Rejetée';
    // }

    // 3. Vérifications spécifiques selon le type de candidature
    switch (candidatureType.toLowerCase()) {
      case 'president':
        _checkPresidentialEligibility(enrollmentData, violations, articles, requirements, userDetails);
        break;
      case 'depute':
        _checkDeputyEligibility(enrollmentData, violations, articles, requirements, userDetails);
        break;
      case 'senateur':
        _checkSenatorialEligibility(enrollmentData, violations, articles, requirements, userDetails);
        break;
      case 'regional':
        _checkRegionalEligibility(enrollmentData, violations, articles, requirements, userDetails);
        break;
      case 'municipal':
        _checkMunicipalEligibility(enrollmentData, violations, articles, requirements, userDetails);
        break;
    }

    // 4. Vérifications générales d'incapacité (Article 4)
    _checkGeneralIneligibility(user, violations, articles, requirements, userDetails);

    return EligibilityResult(
      isEligible: violations.isEmpty,
      violations: violations,
      articles: articles,
      requirements: requirements,
      userDetails: userDetails,
      requiresEnrollment: false,
    );
  }

  // Vérifications pour l'élection présidentielle
  static void _checkPresidentialEligibility(
      EnrollmentData user,
      List<String> violations,
      List<String> articles,
      List<String> requirements,
      Map<String, dynamic> userDetails,
      ) {
    // Age minimum 35 ans (Article 43)
    if (user.birthdate != null) {
      int age = DateTime.now().difference(user.birthdate!).inDays ~/ 365;
      if (age < 35) {
        violations.add("Vous avez $age ans, mais vous devez avoir au moins 35 ans");
        requirements.add("Avoir au moins 35 ans révolus");
        articles.add("Article 43 du Code électoral");
      }
    } else {
      violations.add("Votre date de naissance n'est pas renseignée dans votre dossier d'inscription");
      requirements.add("Avoir au moins 35 ans révolus (date de naissance requise)");
      articles.add("Article 43 du Code électoral");
    }

    // Nationalité - Conditions légales (non vérifiables automatiquement)
    requirements.add("Être exclusivement de nationalité ivoirienne");
    requirements.add("Être né de père ou de mère ivoirien d'origine");
  }

  // Vérifications pour l'élection de député
  static void _checkDeputyEligibility(
      EnrollmentData user,
      List<String> violations,
      List<String> articles,
      List<String> requirements,
      Map<String, dynamic> userDetails,
      ) {
    // Age minimum 25 ans (Article 71)
    if (user.birthdate != null) {
      int age = DateTime.now().difference(user.birthdate!).inDays ~/ 365;
      if (age < 25) {
        violations.add("Vous avez $age ans, mais vous devez avoir au moins 25 ans");
        requirements.add("Avoir au moins 25 ans révolus");
        articles.add("Article 71 du Code électoral");
      }
    } else {
      violations.add("Votre date de naissance n'est pas renseignée dans votre dossier d'inscription");
      requirements.add("Avoir au moins 25 ans révolus (date de naissance requise)");
      articles.add("Article 71 du Code électoral");
    }

    // Nationalité et résidence - Conditions légales (non vérifiables automatiquement)
    requirements.add("Être ivoirien de naissance");
    requirements.add("N'avoir jamais renoncé à la nationalité ivoirienne");
    requirements.add("Avoir résidé de façon continue en Côte d'Ivoire pendant les 5 années précédant les élections");
  }

  // Vérifications pour l'élection sénatoriale
  static void _checkSenatorialEligibility(
      EnrollmentData user,
      List<String> violations,
      List<String> articles,
      List<String> requirements,
      Map<String, dynamic> userDetails,
      ) {
    // Age minimum 35 ans (Article 112)
    if (user.birthdate != null) {
      int age = DateTime.now().difference(user.birthdate!).inDays ~/ 365;
      if (age < 35) {
        violations.add("Vous avez $age ans, mais vous devez avoir au moins 35 ans");
        requirements.add("Avoir au moins 35 ans révolus");
        articles.add("Article 112 du Code électoral");
      }
    } else {
      violations.add("Votre date de naissance n'est pas renseignée dans votre dossier d'inscription");
      requirements.add("Avoir au moins 35 ans révolus (date de naissance requise)");
      articles.add("Article 112 du Code électoral");
    }

    // Résidence dans la circonscription - Condition légale (non vérifiable automatiquement)
    requirements.add("Justifier d'une résidence effective dans la circonscription électorale choisie");
  }

  // Vérifications pour l'élection régionale
  static void _checkRegionalEligibility(
      EnrollmentData user,
      List<String> violations,
      List<String> articles,
      List<String> requirements,
      Map<String, dynamic> userDetails,
      ) {
    // Age minimum 25 ans (Article 150)
    if (user.birthdate != null) {
      int age = DateTime.now().difference(user.birthdate!).inDays ~/ 365;
      if (age < 25) {
        violations.add("Vous avez $age ans, mais vous devez avoir au moins 25 ans");
        requirements.add("Avoir au moins 25 ans révolus");
        articles.add("Article 150 du Code électoral");
      }
    } else {
      violations.add("Votre date de naissance n'est pas renseignée dans votre dossier d'inscription");
      requirements.add("Avoir au moins 25 ans révolus (date de naissance requise)");
      articles.add("Article 150 du Code électoral");
    }

    // Inscription et résidence - Conditions légales (non vérifiables automatiquement)
    requirements.add("Être inscrit sur la liste électorale de la circonscription choisie");
    requirements.add("Résider effectivement dans la région concernée");
  }

  // Vérifications pour l'élection municipale
  static void _checkMunicipalEligibility(
      EnrollmentData user,
      List<String> violations,
      List<String> articles,
      List<String> requirements,
      Map<String, dynamic> userDetails,
      ) {
    // Age minimum 25 ans (Article 178)
    if (user.birthdate != null) {
      int age = DateTime.now().difference(user.birthdate!).inDays ~/ 365;
      if (age < 25) {
        violations.add("Vous avez $age ans, mais vous devez avoir au moins 25 ans");
        requirements.add("Avoir au moins 25 ans révolus");
        articles.add("Article 178 du Code électoral");
      }
    } else {
      violations.add("Votre date de naissance n'est pas renseignée dans votre dossier d'inscription");
      requirements.add("Avoir au moins 25 ans révolus (date de naissance requise)");
      articles.add("Article 178 du Code électoral");
    }

    // Inscription et résidence - Conditions légales (non vérifiables automatiquement)
    requirements.add("Être inscrit sur la liste électorale de la circonscription choisie");
    requirements.add("Résider effectivement dans la commune concernée");
  }

  // Vérifications générales d'incapacité
  static void _checkGeneralIneligibility(
      UserModel user,
      List<String> violations,
      List<String> articles,
      List<String> requirements,
      Map<String, dynamic> userDetails,
      ) {
    // Ces vérifications nécessiteraient des données supplémentaires
    // On les ajoute seulement comme exigences légales, sans violations automatiques
    requirements.add("Jouir de ses droits civils et politiques");
    requirements.add("Ne pas se trouver dans un cas d'incapacité prévu par la loi");
  }

  // Méthode pour afficher le dialog d'inéligibilité
  static void showIneligibilityDialog(BuildContext context, EligibilityResult result, String candidatureType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                result.requiresEnrollment ? Icons.how_to_reg : Icons.warning,
                color: result.requiresEnrollment ? Colors.blue : Colors.orange,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  result.requiresEnrollment
                      ? 'Inscription requise'
                      : 'Conditions d\'éligibilité',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: result.requiresEnrollment
                        ? Colors.blue[800]
                        : Colors.orange[800],
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (result.requiresEnrollment) ...[
                  _buildEnrollmentRequiredSection(result),
                ] else ...[
                  _buildEligibilityAnalysisSection(result, candidatureType),
                ],
                const SizedBox(height: 16),
                _buildInfoSection(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Compris',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget _buildEnrollmentRequiredSection(EligibilityResult result) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
              const SizedBox(width: 8),
              Text(
                'Étape préalable requise',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Avant de pouvoir faire acte de candidature, vous devez obligatoirement :',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue[800],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[300]!),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Vous inscrire sur la liste électorale via l\'inscription électorale',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            result.violations.first,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildEligibilityAnalysisSection(EligibilityResult result, String candidatureType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Status Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Votre profil actuel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 8),
              ...result.userDetails.entries.map((entry) {
                String label = _getUserDetailLabel(entry.key);
                String value = _formatUserDetailValue(entry.key, entry.value);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Text(
                        '$label: ',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[700],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Eligibility Status
        Text(
          result.isEligible
              ? 'Félicitations ! Vous remplissez toutes les conditions vérifiables.'
              : 'Analyse d\'éligibilité pour ${_getCandidatureTypeText(candidatureType)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: result.isEligible ? Colors.green[700] : Colors.orange[800],
          ),
        ),
        const SizedBox(height: 16),

        if (!result.isEligible) ...[
          // Issues found
          Text(
            'Conditions à vérifier ou non remplies :',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.red[700],
            ),
          ),
          const SizedBox(height: 8),
          ...result.violations.asMap().entries.map((entry) {
            int index = entry.key;
            String violation = entry.value;
            String article = index < result.articles.length ? result.articles[index] : '';

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    width: 1,
                    color: Colors.red[300]!,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.warning_amber, color: Colors.red[600], size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            violation,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.red[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (article.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Référence légale : $article',
                        style: TextStyle(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          color: Colors.red[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 16),

          // Requirements
          Text(
            'Conditions requises pour être candidat ${_getCandidatureTypeText(candidatureType)} :',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: result.requirements.map((requirement) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.green[600], size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          requirement,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }

  static Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.help_outline, color: Colors.grey[600], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Pour plus d\'informations sur les conditions d\'éligibilité ou pour contester une décision, consultez le Code électoral de la République de Côte d\'Ivoire ou contactez la Commission Électorale Indépendante.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _getUserDetailLabel(String key) {
    switch (key) {
      case 'enrollmentNumber':
        return 'N° d\'inscription';
      case 'enrollmentStatus':
        return 'Statut inscription';
      case 'age':
        return 'Âge';
      case 'birthDate':
        return 'Date de naissance';
      case 'gender':
        return 'Sexe';
      case 'address':
        return 'Adresse';
      default:
        return key;
    }
  }

  static String _formatUserDetailValue(String key, dynamic value) {
    switch (key) {
      case 'birthDate':
        if (value is DateTime) {
          return "${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}";
        }
        return value.toString();
      case 'age':
        return "$value ans";
      default:
        return value.toString();
    }
  }

  static String _getCandidatureTypeText(String type) {
    switch (type.toLowerCase()) {
      case 'president':
        return 'à l\'élection présidentielle';
      case 'depute':
        return 'député';
      case 'senateur':
        return 'sénateur';
      case 'regional':
        return 'conseiller régional';
      case 'municipal':
        return 'conseiller municipal';
      default:
        return '';
    }
  }
}

class EligibilityResult {
  final bool isEligible;
  final List<String> violations;
  final List<String> articles;
  final List<String> requirements;
  final Map<String, dynamic> userDetails;
  final bool requiresEnrollment;

  EligibilityResult({
    required this.isEligible,
    required this.violations,
    required this.articles,
    required this.requirements,
    required this.userDetails,
    this.requiresEnrollment = false,
  });
}