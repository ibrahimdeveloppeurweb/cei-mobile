import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class TypeSelectionWidget extends StatelessWidget {
  final Function(String) onTypeSelected;

  const TypeSelectionWidget({super.key, required this.onTypeSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Type de réclamation', style: AppTextStyles.h3),
        const SizedBox(height: 16),
        _buildTypeCard(
          'Inscription',
          'Demander l\'inscription d\'une personne omise sur la liste électorale',
          Icons.person_add_outlined,
        ),
        const SizedBox(height: 12),
        _buildTypeCard(
          'Radiation',
          'Demander la radiation d\'une personne (décédée, ayant perdu sa qualité d\'électeur ou indûment inscrite)',
          Icons.person_remove_outlined,
        ),
        const SizedBox(height: 12),
        _buildTypeCard(
          'Correction',
          'Signaler une erreur dans les informations personnelles (nom, prénom, sexe, profession, résidence)',
          Icons.edit_outlined,
        ),
      ],
    );
  }

  Widget _buildTypeCard(String title, String description, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey2),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: AppColors.textSecondary, size: 28),
        title: Text(title, style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold)),
        subtitle: Text(description, style: AppTextStyles.body2),
        onTap: () => onTypeSelected(title),
      ),
    );
  }
}