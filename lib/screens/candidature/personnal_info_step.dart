import 'package:cei_mobile/screens/candidature/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';
import 'package:cei_mobile/main.dart';

class PersonalInfoStep extends StatelessWidget {
  final CandidatureStore store;

  const PersonalInfoStep({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidgets.buildStepTitle('Informations personnelles du candidat'),
          CommonWidgets.buildLegalReference('Article 53 - Déclaration de candidature'),
          24.height,
          _buildPersonalInfoForm(),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoForm() {
    return Observer(
      builder: (_) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CommonWidgets.buildTextField(
                  label: 'Nom de famille *',
                  hint: 'Nom de famille complet',
                  initialValue: store.nom,
                  onChanged: (value) => store.nom = value,
                ),
              ),
              16.width,
              Expanded(
                child: CommonWidgets.buildTextField(
                  label: 'Prénoms *',
                  hint: 'Tous vos prénoms',
                  initialValue: store.prenoms,
                  onChanged: (value) => store.prenoms = value,
                ),
              ),
            ],
          ),
          16.height,
          Row(
            children: [
              Expanded(
                child: CommonWidgets.buildDateField(
                  label: 'Date de naissance *',
                  selectedDate: store.dateNaissance,
                  onChanged: (date) => store.dateNaissance = date,
                ),
              ),
              16.width,
              Expanded(
                child: CommonWidgets.buildTextField(
                  label: 'Lieu de naissance *',
                  hint: 'Ville, pays de naissance',
                  initialValue: store.lieuNaissance,
                  onChanged: (value) => store.lieuNaissance = value,
                ),
              ),
            ],
          ),
          16.height,
          Row(
            children: [
              Expanded(
                child: CommonWidgets.buildDropdown(
                  label: 'Sexe *',
                  value: store.sexe,
                  items: ['M', 'F'],
                  itemLabels: ['Masculin', 'Féminin'],
                  onChanged: (value) => store.sexe = value,
                ),
              ),
              16.width,
              Expanded(
                child: CommonWidgets.buildTextField(
                  label: 'Profession *',
                  hint: 'Votre profession',
                  initialValue: store.profession,
                  onChanged: (value) => store.profession = value,
                ),
              ),
            ],
          ),
          16.height,
          CommonWidgets.buildTextField(
            label: 'Domicile *',
            hint: 'Adresse complète de domicile',
            initialValue: store.domicile,
            onChanged: (value) => store.domicile = value,
            maxLines: 3,
          ),
          16.height,
          Row(
            children: [
              Expanded(
                child: CommonWidgets.buildTextField(
                  label: 'Téléphone',
                  hint: '+225 XX XX XX XX XX',
                  initialValue: store.telephoneContact,
                  onChanged: (value) => store.telephoneContact = value,
                  keyboardType: TextInputType.phone,
                ),
              ),
              16.width,
              Expanded(
                child: CommonWidgets.buildTextField(
                  label: 'Email',
                  hint: 'votre@email.com',
                  initialValue: store.emailContact,
                  onChanged: (value) => store.emailContact = value,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ],
          ),
          24.height,
          _buildEligibilityCard(),
          if (appStore.enrollmentData != null) ...[
            16.height,
            _buildEnrollmentDataCard(),
          ],
        ],
      ),
    );
  }

  Widget _buildEligibilityCard() {
    return Observer(
      builder: (_) {
        final isEligible = store.isEligible;
        final message = store.messageEligibilite;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isEligible ? AppColors.success.withOpacity(0.1) : AppColors.warning.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isEligible ? AppColors.success : AppColors.warning,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isEligible ? Icons.check_circle : Icons.warning,
                color: isEligible ? AppColors.success : AppColors.warning,
                size: 24,
              ),
              12.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isEligible ? 'Éligibilité confirmée' : 'Vérification d\'éligibilité',
                      style: AppTextStyles.body2.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isEligible ? AppColors.success : AppColors.warning,
                      ),
                    ),
                    if (message != null) ...[
                      4.height,
                      Text(
                        message,
                        style: AppTextStyles.caption.copyWith(
                          color: isEligible ? AppColors.success : AppColors.warning,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEnrollmentDataCard() {
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
          Row(
            children: [
              const Icon(Icons.info, color: AppColors.info, size: 20),
              8.width,
              Text(
                'Données d\'inscription pré-remplies',
                style: AppTextStyles.body2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.info,
                ),
              ),
            ],
          ),
          8.height,
          Text(
            'Les informations ci-dessus ont été automatiquement remplies à partir de votre dossier d\'inscription. Vous pouvez les modifier si nécessaire.',
            style: AppTextStyles.caption.copyWith(color: AppColors.info),
          ),
        ],
      ),
    );
  }
}