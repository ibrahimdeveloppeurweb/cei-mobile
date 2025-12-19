import 'package:cei_mobile/model/partie_model.dart';
import 'package:cei_mobile/screens/candidature/widgets/common_widgets.dart';
import 'package:cei_mobile/screens/candidature/utils/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';

class CandidatureStatusStep extends StatelessWidget {
  final CandidatureStore store;
  final List<Partie> parties;
  final bool isLoadingParties;
  final String? partiesError;
  final Partie? selectedPartie;
  final Function(Partie?) onPartieSelected;
  final VoidCallback onReloadParties;

  const CandidatureStatusStep({
    Key? key,
    required this.store,
    required this.parties,
    required this.isLoadingParties,
    required this.partiesError,
    required this.selectedPartie,
    required this.onPartieSelected,
    required this.onReloadParties,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidgets.buildStepTitle('Statut de candidature'),
          CommonWidgets.buildLegalReference('Article 25 - Affiliation politique'),
          24.height,
          _buildCandidatureStatusSection(),
        ],
      ),
    );
  }

  Widget _buildCandidatureStatusSection() {
    return Observer(
      builder: (_) => Column(
        children: [
          CommonWidgets.buildSectionCard(
            title: 'Type de candidature',
            icon: Icons.how_to_vote,
            children: [
              Text(
                'Choisissez votre statut pour l\'élection présidentielle',
                style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
              ),
              24.height,

              // Independent candidate option
              _buildCandidatureTypeCard(
                isSelected: store.appartientPartiPolitique == false,
                title: 'Candidat indépendant',
                description: 'Je ne suis affilié à aucun parti politique et me présente en mon nom propre',
                icon: Icons.person,
                color: AppColors.success,
                onTap: () {
                  store.appartientPartiPolitique = false;
                  onPartieSelected(null);
                  _clearPartyData();
                },
              ),

              16.height,

              // Party member option
              _buildCandidatureTypeCard(
                isSelected: store.appartientPartiPolitique == true,
                title: 'Membre d\'un parti politique',
                description: 'Je représente un parti politique légalement constitué et dispose de sa lettre d\'investiture',
                icon: Icons.account_balance,
                color: AppColors.primary,
                onTap: () {
                  store.appartientPartiPolitique = true;
                },
              ),
            ],
          ),

          // Show party selection if party member is selected
          if (store.appartientPartiPolitique == true) ...[
            24.height,
            _buildPartySelectionSection(),
          ],

          // Show independent confirmation if independent is selected
          if (store.appartientPartiPolitique == false) ...[
            16.height,
            _buildIndependentConfirmation(),
          ],
        ],
      ),
    );
  }

  Widget _buildCandidatureTypeCard({
    required bool isSelected,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : AppColors.accent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppColors.grey2,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? color.withOpacity(0.2) : AppColors.grey1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isSelected ? color : AppColors.textSecondary,
                size: 24,
              ),
            ),
            16.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? color : AppColors.textPrimary,
                    ),
                  ),
                  4.height,
                  Text(
                    description,
                    style: AppTextStyles.caption.copyWith(
                      color: isSelected ? color : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) ...[
              8.width,
              Icon(
                Icons.check_circle,
                color: color,
                size: 24,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPartySelectionSection() {
    return CommonWidgets.buildSectionCard(
      title: 'Sélection du parti politique',
      icon: Icons.account_balance,
      children: [
        if (isLoadingParties) ...[
          const Center(
            child: CircularProgressIndicator(),
          ),
          16.height,
          const Text(
            'Chargement des partis politiques...',
            style: AppTextStyles.caption,
            textAlign: TextAlign.center,
          ),
        ] else if (partiesError != null) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.error.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.error, color: AppColors.error),
                    8.width,
                    Expanded(
                      child: Text(
                        partiesError!,
                        style: AppTextStyles.caption.copyWith(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
                12.height,
                AppButton(
                  onTap: onReloadParties,
                  color: AppColors.error,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text('Réessayer', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ] else if (parties.isEmpty) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.warning.withOpacity(0.3)),
            ),
            child: const Text(
              'Aucun parti politique disponible pour le moment.',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
          ),
        ] else ...[
          _buildPartyDropdown(),
          if (selectedPartie != null) ...[
            16.height,
            _buildSelectedPartyInfo(),
            16.height,
            _buildInvestitureSection(),
          ],
        ],
      ],
    );
  }

  Widget _buildPartyDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Parti politique *', style: AppTextStyles.body2),
        8.height,
        DropdownButtonFormField<Partie>(
          value: selectedPartie,
          onChanged: (Partie? partie) {
            onPartieSelected(partie);
            if (partie != null) {
              store.partiPolitique = partie.name;
              store.sigleParti = partie.sigle ?? '';
            }
          },
          selectedItemBuilder: (BuildContext context) {
            return parties.map((Partie partie) {
              return Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${partie.name ?? 'Nom non disponible'}${partie.sigle?.isNotEmpty == true ? ' (${partie.sigle})' : ''}',
                  style: AppTextStyles.body2,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              );
            }).toList();
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.accent,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          items: parties.map((Partie partie) {
            return DropdownMenuItem<Partie>(
              value: partie,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        partie.name ?? 'Nom non disponible',
                        style: AppTextStyles.body2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    if (partie.sigle?.isNotEmpty == true) ...[
                      8.width,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.3),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          partie.sigle!,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
          hint: const Text('Sélectionnez votre parti politique'),
        ),
      ],
    );
  }

  Widget _buildSelectedPartyInfo() {
    if (selectedPartie == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info, color: AppColors.primary, size: 20),
              8.width,
              Text(
                'Parti sélectionné',
                style: AppTextStyles.body2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          12.height,
          CommonWidgets.buildInfoRow('Nom:', selectedPartie!.name ?? 'N/A'),
          CommonWidgets.buildInfoRow('Sigle:', selectedPartie!.sigle ?? 'N/A'),
          if (selectedPartie!.siege?.isNotEmpty == true)
            CommonWidgets.buildInfoRow('Siège:', selectedPartie!.siege!),
          if (selectedPartie!.dateC != null)
            CommonWidgets.buildInfoRow('Date de création:',
                '${selectedPartie!.dateC!.day}/${selectedPartie!.dateC!.month}/${selectedPartie!.dateC!.year}'),
        ],
      ),
    );
  }

  Widget _buildInvestitureSection() {
    // Get the investiture document from documentsRequis
    final investitureDoc = store.documentsRequis['lettreInvestiture'];
    final hasInvestiture = investitureDoc?.fichier != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Legal requirement notice
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.gavel, color: AppColors.secondary, size: 20),
              8.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Article 54 - Document obligatoire',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    4.height,
                    Text(
                      'La lettre d\'investiture de votre parti est requise pour valider votre candidature présidentielle.',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        16.height,

        // File upload section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: hasInvestiture ? AppColors.success.withOpacity(0.1) : AppColors.grey1,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hasInvestiture ? AppColors.success : AppColors.grey2,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    hasInvestiture ? Icons.check_circle : Icons.description,
                    color: hasInvestiture ? AppColors.success : AppColors.primary,
                    size: 24,
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasInvestiture ? 'Lettre d\'investiture téléchargée' : 'Lettre d\'investiture',
                          style: AppTextStyles.body2.copyWith(
                            fontWeight: FontWeight.w600,
                            color: hasInvestiture ? AppColors.success : AppColors.textPrimary,
                          ),
                        ),
                        4.height,
                        Text(
                          'Document officiel d\'investiture de votre parti politique',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        if (hasInvestiture && investitureDoc?.dateUpload != null) ...[
                          4.height,
                          Text(
                            'Téléchargé le ${_formatDate(investitureDoc!.dateUpload!)}',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.success,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              16.height,
              Text(
                'Format accepté: PDF, JPEG, PNG (max 5MB)',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              12.height,
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  onTap: () => _pickInvestitureFile(),
                  color: hasInvestiture ? AppColors.success : AppColors.primary,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        hasInvestiture ? Icons.edit_document : Icons.upload_file,
                        color: Colors.white,
                        size: 18,
                      ),
                      8.width,
                      Text(
                        hasInvestiture ? 'Modifier le document' : 'Télécharger la lettre d\'investiture',
                        style: AppTextStyles.button,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Requirements info
        16.height,
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.warning.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.warning, size: 16),
                  8.width,
                  Text(
                    'Exigences pour la lettre d\'investiture',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              8.height,
              Text(
                '• Document officiel signé par les dirigeants du parti\n'
                    '• Mention explicite de votre investiture comme candidat présidentiel\n'
                    '• Cachets et signatures officiels du parti\n'
                    '• Document original ou copie certifiée conforme',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.warning,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIndependentConfirmation() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.success.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.verified_user, color: AppColors.success, size: 32),
              16.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Candidature indépendante confirmée',
                      style: AppTextStyles.body1.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.success,
                      ),
                    ),
                    4.height,
                    Text(
                      'Vous vous présentez en tant que candidat indépendant',
                      style: AppTextStyles.caption.copyWith(color: AppColors.success),
                    ),
                  ],
                ),
              ),
            ],
          ),
          16.height,
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.success.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Avantages de la candidature indépendante :',
                  style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w600),
                ),
                8.height,
                const Text(
                  '• Liberté totale dans votre programme politique\n'
                      '• Aucune contrainte d\'affiliation partisane\n'
                      '• Représentation directe des citoyens\n'
                      '• Flexibilité dans les alliances politiques',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _clearPartyData() {
    store.partiPolitique = null;
    store.sigleParti = '';
    store.couleurParti = '';
    store.logoParti = null;

    // Remove investiture document if exists
    if (store.documentsRequis.containsKey('lettreInvestiture')) {
      store.documentsRequis.remove('lettreInvestiture');
    }
  }

  Future<void> _pickInvestitureFile() async {
    try {
      await FilePickerUtils.pickFile((file) {
        store.uploadDocument('lettreInvestiture', file);
        // Auto-save progress after document upload
        store.saveCandidatureData();
      });
    } catch (e) {
      toast('Erreur lors du téléchargement du document');
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} à ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}