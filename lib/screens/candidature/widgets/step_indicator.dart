import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';

class StepIndicator extends StatelessWidget {
  final CandidatureStore store;

  const StepIndicator({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: AppColors.accent,
        child: Column(
          children: [
            // Progress bar
            Row(
              children: List.generate(8, (index) { // Updated to 8 steps
                bool isCompleted = store.currentStep > index;
                bool isCurrent = store.currentStep == index;

                return Expanded(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: isCompleted || isCurrent ? AppColors.primary : AppColors.grey2,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
            12.height,
            // Step info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Étape ${store.currentStep + 1} / 8',
                  style: AppTextStyles.body2.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _getStepTitle(store.currentStep),
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getStepTitle(int index) {
    const titles = [
      'Déclaration de candidature', // NEW: First step
      'Informations personnelles',
      'Statut de candidature',
      'Filiation',
      'Identité visuelle',
      'Documents requis',
      'Cautionnement',
      'Validation finale',
    ];
    return titles[index];
  }
}