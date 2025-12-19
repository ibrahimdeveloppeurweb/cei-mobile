import 'package:flutter/material.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:nb_utils/nb_utils.dart';

class CandidatureEligibilityModal extends StatefulWidget {
  final String candidatureType;
  final bool isEligible;
  final List<String> reasons;

  const CandidatureEligibilityModal({
    Key? key,
    required this.candidatureType,
    required this.isEligible,
    required this.reasons,
  }) : super(key: key);

  @override
  State<CandidatureEligibilityModal> createState() =>
      _CandidatureEligibilityModalState();
}

class _CandidatureEligibilityModalState
    extends State<CandidatureEligibilityModal> {
  // Articles pertinents du Code Électoral selon le type de candidature
  Map<String, List<Map<String, String>>> getRelevantArticles() {
    switch (widget.candidatureType.toLowerCase()) {
      case 'president':
        return {
          'eligibility': [
            {
              'numero': '43',
              'titre': 'ARTICLE 43',
              'contenu':
                  'Le Président de la République est élu pour cinq ans au suffrage universel direct. Il n\'est rééligible qu\'une fois.',
              'motCle': 'Mandat présidentiel'
            },
            {
              'numero': '48',
              'titre': 'ARTICLE 48',
              'contenu':
                  'Tout Ivoirien qui a la qualité d\'électeur peut être élu Président de la République dans les conditions prévues par la Constitution et sous les réserves énoncées ci-après.',
              'motCle': 'Qualité d\'électeur requise'
            },
            {
              'numero': '17',
              'titre': 'ARTICLE 17',
              'contenu':
                  'Tout électeur peut faire acte de candidature aux élections organisées par le présent Code électoral, sous réserve des conditions particulières fixées pour chacune d\'elles.',
              'motCle': 'Inscription obligatoire'
            }
          ],
          'requirements': [
            {
              'numero': '51',
              'titre': 'ARTICLE 51',
              'contenu':
                  'Chaque candidat à l\'élection du Président de la République est tenu de produire une déclaration de candidature revêtue de sa signature dûment légalisée. En outre, il doit être parrainé par une liste d\'électeurs représentant un pour cent (1%) de l\'électorat local, dans au moins cinquante pour cent (50%) des districts autonomes et régions.',
              'motCle': 'Parrainage et signature'
            }
          ]
        };
      case 'depute':
        return {
          'eligibility': [
            {
              'numero': '70',
              'titre': 'ARTICLE 70',
              'contenu':
                  'Tout ivoirien qui a la qualité d\'électeur peut se présenter dans toute circonscription électorale de son choix pour être élu à l\'Assemblée nationale sous les réserves énoncées aux articles suivants.',
              'motCle': 'Qualité d\'électeur requise'
            },
            {
              'numero': '71',
              'titre': 'ARTICLE 71',
              'contenu':
                  'Le candidat à l\'élection de député à l\'Assemblée nationale doit : - être âgé de 25 ans au moins ; - être ivoirien de naissance ; - n\'avoir jamais renoncé à la nationalité ivoirienne.',
              'motCle': 'Conditions d\'âge et nationalité'
            },
            {
              'numero': '17',
              'titre': 'ARTICLE 17',
              'contenu':
                  'Tout électeur peut faire acte de candidature aux élections organisées par le présent Code électoral, sous réserve des conditions particulières fixées pour chacune d\'elles.',
              'motCle': 'Inscription obligatoire'
            }
          ]
        };
      case 'senateur':
        return {
          'eligibility': [
            {
              'numero': '112',
              'titre': 'ARTICLE 112',
              'contenu':
                  'Est éligible dans la circonscription électorale de son choix, tout ivoirien âgé de 35 ans au moins, qui a la qualité d\'électeur et qui jouit de ses droits civils et politiques et justifie d\'une résidence effective dans la circonscription électorale choisie.',
              'motCle': 'Qualité d\'électeur et résidence'
            },
            {
              'numero': '17',
              'titre': 'ARTICLE 17',
              'contenu':
                  'Tout électeur peut faire acte de candidature aux élections organisées par le présent Code électoral, sous réserve des conditions particulières fixées pour chacune d\'elles.',
              'motCle': 'Inscription obligatoire'
            }
          ]
        };
      case 'conseiller_regional':
        return {
          'eligibility': [
            {
              'numero': '150',
              'titre': 'ARTICLE 150',
              'contenu':
                  'Tout Ivoirien âgé de 25 ans révolus, qui a la qualité d\'électeur, peut se présenter aux élections régionales dans toute circonscription électorale de son choix pour être élu conseiller régional sous les réserves énoncées aux articles suivants.',
              'motCle': 'Qualité d\'électeur requise'
            },
            {
              'numero': '151',
              'titre': 'ARTICLE 151',
              'contenu':
                  'Pour faire acte de candidature aux élections régionales, l\'électeur doit être inscrit sur la liste électorale de la circonscription choisie et résider effectivement dans la région concernée.',
              'motCle': 'Inscription et résidence'
            }
          ]
        };
      case 'conseiller_municipal':
        return {
          'eligibility': [
            {
              'numero': '178',
              'titre': 'ARTICLE 178',
              'contenu':
                  'Tout Ivoirien âgé de vingt-cinq ans révolus, qui a la qualité d\'électeur, peut se présenter aux élections municipales dans toute circonscription électorale de son choix pour être élu conseiller municipal sous les réserves énoncées aux articles suivants.',
              'motCle': 'Qualité d\'électeur requise'
            },
            {
              'numero': '179',
              'titre': 'ARTICLE 179',
              'contenu':
                  'Pour faire acte de candidature aux élections municipales, l\'électeur doit être inscrit sur la liste électorale de la circonscription choisie et résider effectivement dans la commune concernée.',
              'motCle': 'Inscription et résidence'
            }
          ]
        };
      default:
        return {
          'eligibility': [
            {
              'numero': '17',
              'titre': 'ARTICLE 17',
              'contenu':
                  'Tout électeur peut faire acte de candidature aux élections organisées par le présent Code électoral, sous réserve des conditions particulières fixées pour chacune d\'elles.',
              'motCle': 'Inscription obligatoire'
            }
          ]
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final articles = getRelevantArticles();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
          maxHeight: 800,
        ),
        child: Column(
          children: [
            // En-tête
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.isEligible
                    ? Colors.green.shade600
                    : Colors.red.shade600,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    widget.isEligible ? Icons.check_circle : Icons.cancel,
                    color: Colors.white,
                    size: 48,
                  ),
                  12.height,
                  Text(
                    widget.isEligible ? 'ÉLIGIBLE' : 'NON ÉLIGIBLE',
                    style: boldTextStyle(color: Colors.white, size: 24),
                  ),
                  8.height,
                  Text(
                    'Candidature : ${_getCandidatureDisplayName()}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Contenu scrollable
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section motifs si non éligible
                    if (!widget.isEligible) ...[
                      _buildSectionTitle('Motifs d\'inéligibilité',
                          Icons.error_outline, Colors.red.shade600),
                      12.height,
                      ...widget.reasons
                          .map((reason) => _buildReasonItem(reason)),
                      20.height,
                    ],

                    // Section articles du code électoral
                    _buildSectionTitle('Code Électoral - Articles applicables',
                        Icons.gavel, AppColors.primary),
                    16.height,

                    // Articles d'éligibilité
                    if (articles['eligibility'] != null) ...[
                      Text(
                        'CONDITIONS D\'ÉLIGIBILITÉ',
                        style: boldTextStyle(
                            size: 16, color: Colors.grey.shade700),
                      ),
                      12.height,
                      ...articles['eligibility']!
                          .map((article) => _buildCodeArticle(article)),
                      16.height,
                    ],

                    // Articles de conditions spécifiques
                    if (articles['requirements'] != null) ...[
                      Text(
                        'CONDITIONS SPÉCIFIQUES',
                        style: boldTextStyle(
                            size: 16, color: Colors.grey.shade700),
                      ),
                      12.height,
                      ...articles['requirements']!
                          .map((article) => _buildCodeArticle(article)),
                      16.height,
                    ],

                    // Article fondamental sur l'inscription
                    _buildHighlightedArticle(),

                    20.height,

                    // Note importante
                    _buildImportantNote(),
                  ],
                ),
              ),
            ),

            // Actions
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  if (widget.isEligible)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        icon: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                        label: const Text('Continuer la candidature'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        icon:
                            const Icon(Icons.info_outline, color: Colors.white),
                        label: const Text('Comprendre les exigences'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  12.width,
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Fermer'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        12.width,
        Text(
          title,
          style: boldTextStyle(size: 18, color: color),
        ),
      ],
    );
  }

  Widget _buildReasonItem(String reason) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.close, color: Colors.red.shade600, size: 20),
          12.width,
          Expanded(
            child: Text(
              reason,
              style: primaryTextStyle(size: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeArticle(Map<String, String> article) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Art. ${article['numero']}',
                  style: boldTextStyle(color: Colors.white, size: 12),
                ),
              ),
              12.width,
              Expanded(
                child: Text(
                  article['motCle'] ?? '',
                  style: boldTextStyle(color: AppColors.primary, size: 14),
                ),
              ),
            ],
          ),
          12.height,
          Text(
            article['contenu'] ?? '',
            style: primaryTextStyle(size: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedArticle() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.orange.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade300, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.orange.shade700, size: 24),
              12.width,
              Text(
                'PRINCIPE FONDAMENTAL',
                style: boldTextStyle(color: Colors.orange.shade700, size: 16),
              ),
            ],
          ),
          12.height,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.shade700,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'ARTICLE 17',
              style: boldTextStyle(color: Colors.white, size: 12),
            ),
          ),
          12.height,
          Text(
            'Tout électeur peut faire acte de candidature aux élections organisées par le présent Code électoral, sous réserve des conditions particulières fixées pour chacune d\'elles.',
            style: boldTextStyle(size: 15, height: 1.5),
          ),
          12.height,
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.orange.shade800, size: 20),
                12.width,
                Expanded(
                  child: Text(
                    'L\'inscription sur la liste électorale est une condition préalable et obligatoire pour toute candidature.',
                    style:
                        boldTextStyle(color: Colors.orange.shade800, size: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportantNote() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline,
                  color: Colors.amber.shade700, size: 20),
              8.width,
              Text(
                'À retenir',
                style: boldTextStyle(color: Colors.amber.shade700, size: 16),
              ),
            ],
          ),
          12.height,
          Text(
            'Le Code Électoral ivoirien établit clairement que la qualité d\'électeur (inscription sur la liste électorale) est une condition sine qua non pour se porter candidat à toute élection, quelle que soit sa nature.',
            style: primaryTextStyle(size: 14, height: 1.4),
          ),
        ],
      ),
    );
  }

  String _getCandidatureDisplayName() {
    switch (widget.candidatureType.toLowerCase()) {
      case 'president':
        return 'Président de la République';
      case 'depute':
        return 'Député';
      case 'senateur':
        return 'Sénateur';
      case 'conseiller_regional':
        return 'Conseiller Régional';
      case 'conseiller_municipal':
        return 'Conseiller Municipal';
      default:
        return widget.candidatureType;
    }
  }

  // Méthode statique pour afficher le modal
  static Future<bool?> show(
    BuildContext context, {
    required String candidatureType,
    required bool isEligible,
    required List<String> reasons,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => CandidatureEligibilityModal(
        candidatureType: candidatureType,
        isEligible: isEligible,
        reasons: reasons,
      ),
    );
  }
}
