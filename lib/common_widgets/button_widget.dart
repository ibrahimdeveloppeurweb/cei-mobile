import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, outlined, text }

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;
  final bool expanded;
  final double? width;
  final double height;
  final double borderRadius;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.expanded = false,
    this.width,
    this.height = 50,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? double.infinity : width,
      height: height,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (type) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            elevation: 2,
          ),
          child: _buildButtonContent(Colors.white),
        );
      case ButtonType.secondary:
        return ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            elevation: 2,
          ),
          child: _buildButtonContent(Colors.white),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: _buildButtonContent(AppColors.primary),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          child: _buildButtonContent(AppColors.primary),
        );
    }
  }

  Widget _buildButtonContent(Color color) {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: color,
            strokeWidth: 2.5,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTextStyles.button.copyWith(color: color),
          ),
        ],
      );
    }

    return Text(
      text,
      style: AppTextStyles.button.copyWith(color: color),
    );
  }
}