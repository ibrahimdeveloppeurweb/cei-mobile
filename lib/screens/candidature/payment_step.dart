import 'package:cei_mobile/screens/candidature/utils/file_picker.dart';
import 'package:cei_mobile/screens/candidature/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';

class PaymentStep extends StatelessWidget {
  final CandidatureStore store;

  const PaymentStep({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Observer(
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.buildStepTitle('Cautionnement'),
            CommonWidgets.buildLegalReference('Article 55 - Montant: 20 000 000 FCFA'),
            16.height,
            _buildPaymentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      children: [
        _buildCautionnementCard(),
        24.height,
        CommonWidgets.buildSectionCard(
          title: 'Informations de paiement',
          icon: Icons.payment,
          children: [
            CommonWidgets.buildDropdown(
              label: 'Mode de paiement *',
              value: store.modePaiementCautionnement,
              items: ['virement', 'cheque', 'especes'],
              itemLabels: ['Virement bancaire', 'Chèque de banque', 'Espèces (Trésor public)'],
              onChanged: (value) => store.modePaiementCautionnement = value,
            ),
            16.height,
            CommonWidgets.buildFileUploadCard(
              'Preuve de versement *',
              'Reçu de versement du Trésor public (PDF ou image)',
              store.preuveCautionnement,
                  () => _pickPaymentProof(),
            ),
            16.height,
            _buildTreasuryInfoCard(),
          ],
        ),
      ],
    );
  }

  Widget _buildCautionnementCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.1), AppColors.secondary.withOpacity(0.1)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance_wallet, color: AppColors.primary, size: 32),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('20 000 000 FCFA', style: AppTextStyles.h3.copyWith(color: AppColors.primary)),
                  Text('Montant du cautionnement obligatoire', style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
                ],
              ),
            ],
          ),
          16.height,
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Conditions de restitution', style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w600)),
                8.height,
                const Text(
                  '• Restitué si vous obtenez au moins 10% des suffrages exprimés\n'
                      '• Acquis à l\'État si moins de 10% des suffrages\n'
                      '• Acquis à l\'État en cas de retrait après délivrance du récépissé définitif\n'
                      '• Restitué aux ayants-droit en cas de décès du candidat',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreasuryInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.info.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informations bancaires du Trésor Public',
            style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w600, color: AppColors.info),
          ),
          12.height,
          CommonWidgets.buildInfoRow('Bénéficiaire:', 'Trésor Public de Côte d\'Ivoire'),
          CommonWidgets.buildInfoRow('Banque:', 'Banque Centrale des États de l\'Afrique de l\'Ouest'),
          CommonWidgets.buildInfoRow('Motif:', 'Cautionnement candidature présidentielle 2025'),
          CommonWidgets.buildInfoRow('Référence:', 'Indiquer vos nom et prénoms'),
        ],
      ),
    );
  }

  Future<void> _pickPaymentProof() async {
    await FilePickerUtils.pickFile((file) => store.preuveCautionnement = file);
  }
}