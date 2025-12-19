// lib/features/enrollment/widgets/read_only_field.dart

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';

class ReadOnlyField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const ReadOnlyField({
    Key? key,
    required this.label,
    required this.value,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: secondaryTextStyle(color: Colors.grey[700]),
          ),
          8.height,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppColors.primary),
                12.width,
                Expanded(
                  child: Text(
                    value.isEmpty ? 'Non disponible' : value,
                    style: primaryTextStyle(
                      color: value.isEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}