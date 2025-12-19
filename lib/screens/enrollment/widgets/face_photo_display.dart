// lib/features/enrollment/widgets/face_photo_display.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';

class FacePhotoDisplay extends StatelessWidget {
  final File? userFacePhoto;
  final bool hasProfilePhoto;

  const FacePhotoDisplay({
    Key? key,
    required this.userFacePhoto,
    required this.hasProfilePhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (userFacePhoto == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Photo extraite',
                style: secondaryTextStyle(color: Colors.grey[700]),
              ),
              // Afficher un badge "Vérification faciale" si une photo existe à l'étape 3
              if (hasProfilePhoto)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.face, size: 14, color: AppColors.primary),
                      4.width,
                      const Text(
                        'Vérification faciale',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          12.height,
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 1),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  userFacePhoto!,
                  height: 150,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}