import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';

class NavigationButtons extends StatelessWidget {
  final CandidatureStore store;
  final PageController pageController;
  final bool Function() onValidateStep;

  const NavigationButtons({
    Key? key,
    required this.store,
    required this.pageController,
    required this.onValidateStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.accent,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            if (store.currentStep > 0) ...[
              Expanded(
                child: AppButton(
                  onTap: () {
                    store.previousStep();
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  elevation: 0.0,
                  color: Colors.grey[300],
                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_back, color: AppColors.textSecondary, size: 18),
                      8.width,
                      Text('Précédent', style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),
              16.width,
            ],
            if (store.currentStep < 7) ...[  // Updated to 7 (8 steps total, 0-7)
              Expanded(
                flex: store.currentStep > 0 ? 1 : 2,
                child: AppButton(
                  onTap: () {
                    // Validate current step before proceeding
                    if (onValidateStep()) {
                      store.nextStep();
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  elevation: 0.0,
                  color: AppColors.primary,
                  shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Suivant', style: AppTextStyles.button),
                      8.width,
                      const Icon(Icons.arrow_forward, color: AppColors.accent, size: 18),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}