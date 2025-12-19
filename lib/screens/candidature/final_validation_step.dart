import 'package:cei_mobile/model/partie_model.dart';
import 'package:cei_mobile/screens/candidature/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';

class FinalValidationStep extends StatelessWidget {
  final CandidatureStore store;
  final Partie? selectedPartie;

  const FinalValidationStep({
    super.key,
    required this.store,
    this.selectedPartie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: Observer(
        builder: (_) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Section
                    Text(
                      "Validation finale",
                      style: boldTextStyle(
                        size: 36,
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "de candidature",
                      style: boldTextStyle(
                        size: 36,
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                    50.height,

                    // Header message
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.primary,
                            size: 24,
                          ),
                          12.width,
                          Expanded(
                            child: Text(
                              'Veuillez vérifier toutes vos informations avant de soumettre votre candidature à la présidence.',
                              style: primaryTextStyle(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.height,

                    // Legal Reference
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.secondary.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.gavel,
                            color: AppColors.secondary,
                            size: 20,
                          ),
                          8.width,
                          Text(
                            'Article 52 - Délais et soumission',
                            style: boldTextStyle(
                              color: AppColors.secondary,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.height,

                    _buildFinalValidationSection(),
                  ],
                ),
              ),
            ),
            _buildSubmitSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFinalValidationSection() {
    return Column(
      children: [
        _buildDeclarationCandidatureCard(),
        16.height,
        _buildSummaryCard(),
        16.height,
        if (store.appartientPartiPolitique == true)
          _buildPartyInfoCard(),
        if (store.appartientPartiPolitique == true)
          16.height,
        _buildFiliationCard(),
        16.height,
        _buildVisualIdentityCard(),
        16.height,
        _buildDocumentsSummaryCard(),
        16.height,
        _buildDeclarationsCard(),
        30.height,
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Observer(
      builder: (_) => _buildSectionCard(
        title: 'Informations personnelles',
        icon: Icons.person,
        isValid: store.isStep1Valid,
        content: [
          _buildDetailRow('Candidat:', '${store.nom} ${store.prenoms}'),
          _buildDetailRow(
            'Date de naissance:',
            store.dateNaissance != null
                ? "${store.dateNaissance!.day}/${store.dateNaissance!.month}/${store.dateNaissance!.year}"
                : '',
          ),
          _buildDetailRow('Lieu de naissance:', store.lieuNaissance),
          _buildDetailRow('Nationalité:', store.nationalite),
          _buildDetailRow('Profession:', store.profession),
          _buildDetailRow('Domicile:', store.domicile),
          _buildDetailRow('Sexe:', store.sexe ?? ''),
          _buildDetailRow('Email:', store.emailContact),
          _buildDetailRow('Téléphone:', store.telephoneContact),
          _buildDetailRow(
            'Statut:',
            store.appartientPartiPolitique == true
                ? 'Membre de parti politique'
                : 'Candidat indépendant',
          ),
          // Eligibility check
          if (!store.isEligible) ...[
            16.height,
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.error),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: AppColors.error, size: 16),
                  8.width,
                  Expanded(
                    child: Text(
                      store.messageEligibilite ?? 'Conditions d\'éligibilité non remplies',
                      style: boldTextStyle(color: AppColors.error, size: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDeclarationCandidatureCard() {
    return Observer(
      builder: (_) => _buildSectionCard(
        title: 'Déclaration de candidature',
        icon: Icons.description,
        isValid: store.isStep0Valid,
        content: [
          if (store.declarationCandidature != null) ...[
            Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.success, size: 20),
                12.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Déclaration soumise',
                        style: boldTextStyle(color: AppColors.success, size: 14),
                      ),
                      if (store.dateDeclarationCandidature != null) ...[
                        4.height,
                        Text(
                          'Soumise le ${_formatDate(store.dateDeclarationCandidature!)}',
                          style: secondaryTextStyle(size: 12),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Icon(Icons.cancel, color: AppColors.error, size: 20),
                12.width,
                Expanded(
                  child: Text(
                    'Déclaration de candidature manquante - Obligatoire',
                    style: boldTextStyle(color: AppColors.error, size: 14),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPartyInfoCard() {
    return Observer(
      builder: (_) => _buildSectionCard(
        title: 'Informations du parti politique',
        icon: Icons.groups,
        isValid: store.isStep2Valid,
        content: [
          _buildDetailRow('Nom du parti:', store.partiPolitique ?? ''),
          _buildDetailRow('Sigle du parti:', store.sigleParti),
          _buildDetailRow('Numéro carte parti:', store.numeroCarteParti),
          _buildDetailRow('Couleur du parti:', store.couleurParti),
          if (store.logoParti != null) ...[
            8.height,
            Text('Logo du parti:', style: secondaryTextStyle()),
            8.height,
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                store.logoParti!,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFiliationCard() {
    return Observer(
      builder: (_) => _buildSectionCard(
        title: 'Informations de filiation',
        icon: Icons.family_restroom,
        isValid: store.isStep3Valid,
        content: [
          Text(
            'Informations du père:',
            style: boldTextStyle(size: 14),
          ),
          8.height,
          _buildDetailRow('Nom complet du père:', store.filiationPere),
          _buildDetailRow(
            'Date de naissance:',
            store.dateNaissancePere != null
                ? "${store.dateNaissancePere!.day}/${store.dateNaissancePere!.month}/${store.dateNaissancePere!.year}"
                : '',
          ),
          _buildDetailRow('Lieu de naissance:', store.lieuNaissancePere),
          _buildDetailRow('Nationalité:', store.nationalitePere),
          16.height,
          Text(
            'Informations de la mère:',
            style: boldTextStyle(size: 14),
          ),
          8.height,
          _buildDetailRow('Nom complet de la mère:', store.filiationMere),
          _buildDetailRow(
            'Date de naissance:',
            store.dateNaissanceMere != null
                ? "${store.dateNaissanceMere!.day}/${store.dateNaissanceMere!.month}/${store.dateNaissanceMere!.year}"
                : '',
          ),
          _buildDetailRow('Lieu de naissance:', store.lieuNaissanceMere),
          _buildDetailRow('Nationalité:', store.nationaliteMere),
        ],
      ),
    );
  }

  Widget _buildVisualIdentityCard() {
    return Observer(
      builder: (_) => _buildSectionCard(
        title: 'Identité visuelle de campagne',
        icon: Icons.palette,
        isValid: store.isStep4Valid,
        content: [
          _buildDetailRow('Couleur du bulletin:', store.couleurBulletin ?? 'Non définie'),
          _buildDetailRow('Sigle de campagne:', store.sigleChoisi ?? 'Non défini'),
          if (store.symboleChoisi != null) ...[
            16.height,
            Text('Symbole de campagne:', style: secondaryTextStyle()),
            8.height,
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.file(
                  store.symboleChoisi!,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ] else ...[
            _buildDetailRow('Symbole de campagne:', 'Non défini'),
          ],
          if (store.couleurBulletin != null) ...[
            16.height,
            Text('Aperçu couleur:', style: secondaryTextStyle()),
            8.height,
            Container(
              width: 40,
              height: 20,
              decoration: BoxDecoration(
                color: _getColorFromString(store.couleurBulletin!),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey[400]!),
              ),
            ),
          ],
          // Check for prohibited colors
          if (store.couleurBulletin != null && store.isUtilisationCouleursInterdites()) ...[
            16.height,
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.error),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: AppColors.error, size: 16),
                  8.width,
                  Expanded(
                    child: Text(
                      'Attention: L\'utilisation des couleurs nationales peut être interdite',
                      style: boldTextStyle(color: AppColors.error, size: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDocumentsSummaryCard() {
    return Observer(
      builder: (_) => _buildSectionCard(
        title: 'Documents et cautionnement',
        icon: Icons.folder_open,
        isValid: store.isStep5Valid && store.isStep6Valid,
        content: [
          Text(
            'État des documents requis:',
            style: boldTextStyle(size: 16),
          ),
          12.height,
          ...store.documentsRequis.entries.map((entry) {
            final doc = entry.value;
            final hasFile = doc.fichier != null;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: hasFile
                    ? AppColors.success.withOpacity(0.1)
                    : AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: hasFile ? AppColors.success : AppColors.error,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    hasFile ? Icons.check_circle : Icons.cancel,
                    color: hasFile ? AppColors.success : AppColors.error,
                    size: 20,
                  ),
                  12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc.nom,
                          style: boldTextStyle(
                            color: hasFile ? AppColors.success : AppColors.error,
                            size: 14,
                          ),
                        ),
                        if (hasFile && doc.dateUpload != null) ...[
                          4.height,
                          Text(
                            'Téléchargé le ${_formatDate(doc.dateUpload!)}',
                            style: secondaryTextStyle(size: 12),
                          ),
                        ],
                        if (!hasFile) ...[
                          4.height,
                          Text(
                            'Document manquant - obligatoire',
                            style: secondaryTextStyle(
                              size: 12,
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (hasFile)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Validé',
                        style: boldTextStyle(color: Colors.white, size: 12),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
          24.height,
          Divider(color: Colors.grey[300]),
          16.height,
          Text(
            'Informations de cautionnement:',
            style: boldTextStyle(size: 16),
          ),
          12.height,
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: store.isStep6Valid
                  ? AppColors.success.withOpacity(0.1)
                  : AppColors.error.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: store.isStep6Valid ? AppColors.success : AppColors.error,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      store.isStep6Valid ? Icons.check_circle : Icons.cancel,
                      color: store.isStep6Valid ? AppColors.success : AppColors.error,
                      size: 20,
                    ),
                    12.width,
                    Text(
                      store.isStep6Valid ? 'Cautionnement validé' : 'Cautionnement incomplet',
                      style: boldTextStyle(
                        color: store.isStep6Valid ? AppColors.success : AppColors.error,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                12.height,
                _buildDetailRow('Mode de paiement:', store.modePaiementCautionnement ?? 'Non défini'),
                _buildDetailRow(
                  'Montant:',
                  '${store.montantCautionnementRequis.toStringAsFixed(0)} FCFA',
                ),
                if (store.datePaiementCautionnement != null)
                  _buildDetailRow(
                    'Date de paiement:',
                    _formatDate(store.datePaiementCautionnement!),
                  ),
                if (store.preuveCautionnement != null) ...[
                  8.height,
                  Row(
                    children: [
                      Icon(Icons.receipt, color: AppColors.success, size: 16),
                      8.width,
                      Text(
                        'Preuve de paiement jointe',
                        style: boldTextStyle(color: AppColors.success, size: 14),
                      ),
                    ],
                  ),
                ] else if (store.modePaiementCautionnement != null) ...[
                  8.height,
                  Row(
                    children: [
                      Icon(Icons.warning, color: AppColors.error, size: 16),
                      8.width,
                      Text(
                        'Preuve de paiement manquante',
                        style: boldTextStyle(color: AppColors.error, size: 14),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeclarationsCard() {
    return Observer(
      builder: (_) => _buildSectionCard(
        title: 'Déclarations légales',
        icon: Icons.gavel,
        isValid: store.isStep7Valid,
        content: [
          Text(
            'Certifications obligatoires:',
            style: boldTextStyle(size: 16),
          ),
          16.height,
          _buildDeclarationItem(
            title: 'Déclaration sur l\'honneur',
            description: 'Je certifie sur l\'honneur que toutes les informations fournies sont exactes, que je remplis toutes les conditions d\'éligibilité prévues par la Constitution et le Code Électoral.',
            value: store.declarationHonneur,
            onChanged: (value) => store.declarationHonneur = value ?? false,
          ),
          16.height,
          _buildDeclarationItem(
            title: 'Conditions d\'utilisation',
            description: 'J\'accepte les conditions d\'utilisation de cette plateforme et autorise la Commission Électorale Indépendante à traiter mes données personnelles.',
            value: store.accepteConditions,
            onChanged: (value) => store.accepteConditions = value ?? false,
          ),
          16.height,
          _buildDeclarationItem(
            title: 'Traitement des données',
            description: 'J\'accepte le traitement de mes données personnelles conformément à la législation en vigueur sur la protection des données.',
            value: store.accepteTraitementDonnees,
            onChanged: (value) => store.accepteTraitementDonnees = value ?? false,
          ),
        ],
      ),
    );
  }

  Widget _buildDeclarationItem({
    required String title,
    required String description,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: value ? AppColors.success.withOpacity(0.1) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: value ? AppColors.success : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            activeColor: AppColors.primary,
            onChanged: onChanged,
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: boldTextStyle(size: 14),
                ),
                4.height,
                Text(
                  description,
                  style: secondaryTextStyle(size: 12),
                ),
              ],
            ),
          ),
          if (value)
            Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 20,
            ),
        ],
      ),
    );
  }

  Widget _buildSubmitSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Observer(
        builder: (_) => Column(
          children: [
            // Status indicator
            if (!store.isCandidatureComplete)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.warning.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: AppColors.warning,
                      size: 20,
                    ),
                    12.width,
                    Expanded(
                      child: Text(
                        'Veuillez compléter tous les champs requis avant de soumettre',
                        style: boldTextStyle(
                          color: AppColors.warning,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Submit button
            if (store.isCandidatureComplete) SizedBox(
              width: double.infinity,
              child: AppButton(
                onTap: store.isCandidatureComplete && !store.isSubmitting
                    ? () => store.submitCandidature()
                    : null,
                color: store.isCandidatureComplete
                    ? AppColors.secondary
                    : Colors.grey[400],
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0.0,
                child: store.isSubmitting
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    16.width,
                    Text(
                      'Soumission en cours...',
                      style: boldTextStyle(color: Colors.white),
                    ),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.how_to_vote,
                      color: Colors.white,
                      size: 24,
                    ),
                    12.width,
                    Text(
                      'Soumettre ma candidature',
                      style: boldTextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> content,
    VoidCallback? onEdit,
    bool? isValid,
  }) {
    // Determine validation status
    bool showValidation = isValid != null;
    bool validated = isValid ?? true;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        // Add border color based on validation status
        border: showValidation
            ? Border.all(
          color: validated ? AppColors.success.withOpacity(0.3) : AppColors.error.withOpacity(0.3),
          width: 1,
        )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: showValidation
                  ? (validated ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1))
                  : Colors.grey[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: AppColors.primary, size: 20),
                    8.width,
                    Text(
                      title,
                      style: boldTextStyle(size: 16),
                    ),
                    if (showValidation) ...[
                      8.width,
                      Icon(
                        validated ? Icons.check_circle : Icons.error,
                        color: validated ? AppColors.success : AppColors.error,
                        size: 18,
                      ),
                    ],
                  ],
                ),
                if (onEdit != null)
                  TextButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, size: 14),
                    label: const Text('Modifier'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.secondary,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: secondaryTextStyle(),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Non renseigné' : value,
              style: primaryTextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} à ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  Color _getColorFromString(String colorString) {
    // Simple color mapping - you can expand this based on your needs
    switch (colorString.toLowerCase()) {
      case 'rouge':
      case 'red':
        return Colors.red;
      case 'bleu':
      case 'blue':
        return Colors.blue;
      case 'vert':
      case 'green':
        return Colors.green;
      case 'jaune':
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'violet':
      case 'purple':
        return Colors.purple;
      case 'rose':
      case 'pink':
        return Colors.pink;
      case 'noir':
      case 'black':
        return Colors.black;
      case 'blanc':
      case 'white':
        return Colors.white;
      case 'gris':
      case 'grey':
        return Colors.grey;
      default:
      // Try to parse hex color if it starts with #
        if (colorString.startsWith('#') && colorString.length == 7) {
          try {
            return Color(int.parse(colorString.substring(1), radix: 16) + 0xFF000000);
          } catch (e) {
            return Colors.grey;
          }
        }
        return Colors.grey;
    }
  }
}