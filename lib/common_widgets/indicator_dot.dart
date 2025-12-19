import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IndicatorDot extends StatelessWidget {
  final int currentPage;
  final int totalItems;
  final double? selectedDotWidth;
  final double? unselectedDotWidth;

  const IndicatorDot({
    super.key,
    required this.currentPage,
    required this.totalItems,
    this.selectedDotWidth,
    this.unselectedDotWidth
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalItems, (index) {
          // Determine the color based on step state
          Color dotColor;
          if (index < currentPage) {
            // Step is completed (passed)
            dotColor = Colors.green;
          } else if (index == currentPage) {
            // Current step
            dotColor = AppColors.primary;
          } else {
            // Step not reached yet
            dotColor = AppColors.grey2;
          }

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: currentPage == index ? selectedDotWidth ?? 30 : unselectedDotWidth ?? 15,
            height: 5,
            decoration: BoxDecoration(
              color: dotColor,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        }),
      ),
    );
  }
}