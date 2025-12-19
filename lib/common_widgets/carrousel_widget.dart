import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'indicator_dot.dart';

class CarrouselWidget extends StatefulWidget {
  List<String> carouselItems;
  double? carouselHeight; // Optional height
  CarrouselWidget({super.key, required this.carouselItems, this.carouselHeight});

  @override
  State<CarrouselWidget> createState() => _CarrouselWidgetState();
}

class _CarrouselWidgetState extends State<CarrouselWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.carouselHeight?? 200,
          child: PageView.builder(
              controller: _pageController,
              itemCount: widget.carouselItems.length,
              itemBuilder: (context, index) {
                return _buildCarouselItem(widget.carouselItems[index]);
              }),
        ),
        5.height,
        IndicatorDot(currentPage: _currentPage, totalItems: widget.carouselItems.length),
      ],
    );
  }

  Widget _buildCarouselItem(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          // Background Image
          SizedBox(
            height: widget.carouselHeight ?? 200,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                image,
              ),
            )


          ),
          Container(
            height: widget.carouselHeight ?? 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.secondaryDark.withOpacity(0.1),
                  AppColors.secondary.withOpacity(0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}