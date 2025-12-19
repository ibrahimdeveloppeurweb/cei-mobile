// Updated ComparisonResultDialog Widget with no "Continue anyway" option
// lib/screens/enrollment/widgets/comparison_result_dialog.dart

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';

class ComparisonResultDialog extends StatelessWidget {
  final bool matchResult;
  final double matchScore;
  final VoidCallback onContinue;
  final VoidCallback? onCancel;
  final VoidCallback? onRetakeSelfie;

  const ComparisonResultDialog({
    Key? key,
    required this.matchResult,
    required this.matchScore,
    required this.onContinue,
    this.onCancel,
    this.onRetakeSelfie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              matchResult ? Icons.check_circle : Icons.error,
              size: 60,
              color: matchResult ? Colors.green : Colors.red,
            ),
            16.height,
            Text(
              matchResult ? 'Correspondance faciale confirmée' : 'Correspondance faciale échouée',
              style: boldTextStyle(size: 18),
              textAlign: TextAlign.center,
            ),
            12.height,
            Text(
              matchResult
                  ? 'Les visages correspondent avec un taux de similarité de ${(matchScore * 100).toStringAsFixed(1)}%.'
                  : 'Les visages ne correspondent pas. Taux de similarité: ${(matchScore * 100).toStringAsFixed(1)}%.',
              style: secondaryTextStyle(size: 14),
              textAlign: TextAlign.center,
            ),

            // Show different message based on match result
            if (!matchResult) ...[
              12.height,
              Text(
                'La vérification faciale est obligatoire pour continuer.',
                style: secondaryTextStyle(size: 14, color: Colors.red[700]),
                textAlign: TextAlign.center,
              ),
              8.height,
              Text(
                'Veuillez refaire votre photo ou revenir à l\'étape précédente.',
                style: secondaryTextStyle(size: 14),
                textAlign: TextAlign.center,
              ),
            ],

            20.height,

            if (!matchResult) ...[
              // For match failures, show only back and retake options
              Row(
                children: [
                  if (onCancel != null)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onCancel,
                        icon: const Icon(Icons.arrow_back, color: Colors.grey),
                        label: const Text('Retour'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  if (onCancel != null && onRetakeSelfie != null)
                    const SizedBox(width: 12),
                  // Retake selfie button
                  if (onRetakeSelfie != null)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onRetakeSelfie,
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        label: const Text('Refaire la photo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ] else ...[
              // For successful matches, show continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Continuer',
                    style: TextStyle(color: Colors.white),
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