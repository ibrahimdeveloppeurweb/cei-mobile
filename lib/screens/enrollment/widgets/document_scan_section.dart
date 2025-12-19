// lib/features/enrollment/widgets/document_scan_section.dart

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';

class DocumentScanSection extends StatelessWidget {
  final bool isScanning;
  final VoidCallback onScanPressed;

  const DocumentScanSection({
    Key? key,
    required this.isScanning,
    required this.onScanPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Scanner votre pièce d\'identité',
          style: boldTextStyle(size: 18),
        ),
        16.height,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.document_scanner_outlined,
                size: 80,
                color: AppColors.primary.withOpacity(0.6),
              ),
              20.height,
              Text(
                'Pour continuer, vous devez scanner votre pièce d\'identité',
                style: primaryTextStyle(size: 16),
                textAlign: TextAlign.center,
              ),
              16.height,
              ElevatedButton.icon(
                onPressed: isScanning ? null : onScanPressed,
                icon: isScanning
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                )
                    : const Icon(Icons.camera_alt, color: Colors.white),
                label: Text(
                  isScanning ? 'Scan en cours...' : 'Scanner maintenant',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
        16.height,
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: AppColors.primary),
              12.width,
              Expanded(
                child: Text(
                  'Placez votre pièce d\'identité sur une surface plane et bien éclairée. Assurez-vous que toutes les informations sont visibles et lisibles.',
                  style: secondaryTextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}