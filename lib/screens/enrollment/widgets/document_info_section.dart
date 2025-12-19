// lib/features/enrollment/widgets/document_info_section.dart

import 'dart:io';
import 'package:cei_mobile/screens/enrollment/widgets/read_only_field.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';

import 'document_image_card.dart';
import 'face_photo_display.dart';

class DocumentInfoSection extends StatelessWidget {
  final File? idFrontPhoto;
  final File? idBackPhoto;
  final File? userFacePhoto;
  final bool hasProfilePhoto;
  final String? selectedIdType;
  final String idNumber;
  final String serialNumber;
  final String issueDate;
  final String expireDate;
  final String firstName;
  final String lastName;
  final String dob;
  final String nationality;
  final String address;
  final String age;
  final VoidCallback onRescanPressed;
  final bool isScanning;

  const DocumentInfoSection({
    Key? key,
    required this.idFrontPhoto,
    required this.idBackPhoto,
    required this.userFacePhoto,
    required this.hasProfilePhoto,
    required this.selectedIdType,
    required this.idNumber,
    required this.serialNumber,
    required this.issueDate,
    required this.expireDate,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.nationality,
    required this.address,
    required this.onRescanPressed,
    required this.isScanning,
    required this.age,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section des images du document (recto/verso)
        Row(
          children: [
            Expanded(
              child: DocumentImageCard(
                title: 'Recto',
                image: idFrontPhoto,
              ),
            ),
            16.width,
            Expanded(
              child: DocumentImageCard(
                title: 'Verso',
                image: idBackPhoto,
              ),
            ),
          ],
        ),
        30.height,

        // Bouton pour re-scanner si nécessaire
        Container(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: isScanning ? null : onRescanPressed,
            icon: const Icon(Icons.refresh, color: AppColors.primary),
            label: const Text(
              'Re-scanner le document',
              style: TextStyle(color: AppColors.primary),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: const BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        20.height,

        // Informations extraites du document
        Text(
          'Informations du document',
          style: boldTextStyle(size: 18),
        ),
        16.height,

        // Photo du visage
        FacePhotoDisplay(
          userFacePhoto: userFacePhoto,
          hasProfilePhoto: hasProfilePhoto,
        ),

        // Type de document
        ReadOnlyField(
          label: 'Type de pièce',
          value: selectedIdType ?? '',
          icon: Icons.badge,
        ),

        // Numéro de document
        ReadOnlyField(
          label: 'Numéro de la pièce',
          value: idNumber,
          icon: Icons.numbers,
        ),
        // Numéro NNI
        ReadOnlyField(
          label: 'Numéro NNI',
          value: serialNumber,
          icon: Icons.numbers,),

        ReadOnlyField(
          label: 'Date de délivrance',
          value: issueDate,
          icon: Icons.calendar_today,
        ),

        // Date d'expiration
        ReadOnlyField(
          label: 'Date d\'expiration',
          value: expireDate,
          icon: Icons.calendar_today,
        ),

        // Prénom
        ReadOnlyField(
          label: 'Prénom',
          value: firstName,
          icon: Icons.person,
        ),

        // Nom
        ReadOnlyField(
          label: 'Nom',
          value: lastName,
          icon: Icons.person_outline,
        ),

        // Date de naissance
        ReadOnlyField(
          label: 'Date de naissance',
          value: dob,
          icon: Icons.cake,
        ),

        // Nationalité
        ReadOnlyField(
          label: 'Nationalité',
          value: nationality,
          icon: Icons.flag,
        ),

        // Nationalité
        ReadOnlyField(
          label: 'Âge',
          value: age,
          icon: Icons.person,
        ),

        // Adresse
        // ReadOnlyField(
        //   label: 'Adresse',
        //   value: address,
        //   icon: Icons.home,
        // ),

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
                  'Ces informations ont été extraites automatiquement de votre document d\'identité. Si certaines informations sont incorrectes ou manquantes, vous pouvez re-scanner votre document.',
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