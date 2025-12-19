import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  // Titres
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Corps de texte
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
    height: 1.5,
    fontFamily: "Poppins"
  );

  // Options
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    letterSpacing: 1.0,
  );

  // Variantes
  static TextStyle bodyBold = body1.copyWith(fontWeight: FontWeight.bold);
  static TextStyle bodyItalic = body1.copyWith(fontStyle: FontStyle.italic);
  static TextStyle bodyLink = body1.copyWith(color: AppColors.primary, decoration: TextDecoration.underline);
}
