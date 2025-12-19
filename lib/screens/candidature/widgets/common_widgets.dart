import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';

class CommonWidgets {
  /// Builds a step title
  static Widget buildStepTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.h2.copyWith(letterSpacing: 1.5),
    );
  }

  /// Builds a legal reference box
  static Widget buildLegalReference(String reference) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.gavel, color: AppColors.primary, size: 16),
          8.width,
          Expanded(
            child: Text(
              reference,
              style: AppTextStyles.caption.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a text field
  static Widget buildTextField({
    required String label,
    required String hint,
    required String initialValue,
    required Function(String) onChanged,
    int? maxLines = 1,
    int? maxLength,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.body2),
        8.height,
        AppTextField(
          initialValue: initialValue,
          onChanged: onChanged,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.accent,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          textFieldType: TextFieldType.OTHER,
        ),
      ],
    );
  }

  /// Builds a date field
  static Widget buildDateField({
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.body2),
        8.height,
        Builder(
          builder: (context) => InkWell(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(1940),
                lastDate: DateTime.now(),
              );
              if (date != null) onChanged(date);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.grey2, width: 1),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate != null
                          ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
                          : 'Sélectionner une date',
                      style: AppTextStyles.body2.copyWith(
                        color: selectedDate != null ? AppColors.textPrimary : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const Icon(Icons.calendar_today, color: AppColors.primary, size: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a dropdown field
  static Widget buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required List<String> itemLabels,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.body2),
        8.height,
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.accent,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.grey2, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
          items: List.generate(items.length, (index) {
            return DropdownMenuItem(
              value: items[index],
              child: Text(itemLabels[index], style: AppTextStyles.body2),
            );
          }),
        ),
      ],
    );
  }

  /// Builds a section card
  static Widget buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey2, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.grey1,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 20),
                12.width,
                Text(title, style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a warning card
  static Widget buildWarningCard(String title, String content, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              8.width,
              Text(
                title,
                style: AppTextStyles.body2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          8.height,
          Text(
            content,
            style: AppTextStyles.caption.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  /// Builds a file upload card
  static Widget buildFileUploadCard(String title, String description, dynamic file, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey1,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey2, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w600))),
              if (file != null) const Icon(Icons.check_circle, color: AppColors.success, size: 20),
            ],
          ),
          8.height,
          Text(description, style: AppTextStyles.caption),
          16.height,
          AppButton(
            onTap: onTap,
            color: AppColors.primary,
            shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.upload_file, color: AppColors.accent, size: 18),
                8.width,
                Text(
                  file != null ? 'Modifier le fichier' : 'Télécharger',
                  style: AppTextStyles.button.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
          if (file != null) ...[
            8.height,
            Text('✓ Fichier téléchargé', style: AppTextStyles.caption.copyWith(color: AppColors.success)),
          ],
        ],
      ),
    );
  }

  /// Builds info row for displaying key-value pairs
  static Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(value, style: AppTextStyles.caption)),
        ],
      ),
    );
  }
}