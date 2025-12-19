import 'package:flutter/material.dart';

class FeatureHighlightWidget extends StatefulWidget {
  final Widget child;
  final String title;
  final String description;
  final bool showHighlight;
  final VoidCallback? onTap;

  const FeatureHighlightWidget({
    Key? key,
    required this.child,
    required this.title,
    required this.description,
    this.showHighlight = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<FeatureHighlightWidget> createState() => _FeatureHighlightWidgetState();
}

class _FeatureHighlightWidgetState extends State<FeatureHighlightWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.showHighlight) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(FeatureHighlightWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showHighlight != oldWidget.showHighlight) {
      if (widget.showHighlight) {
        _animationController.repeat(reverse: true);
      } else {
        _animationController.stop();
        _animationController.reset();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showHighlight) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            // Pulsing effect
            Positioned.fill(
              child: Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6366F1).withOpacity(0.3),
                        blurRadius: 20 * _pulseAnimation.value,
                        spreadRadius: 5 * _pulseAnimation.value,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Main content with scale animation
            Transform.scale(
              scale: _scaleAnimation.value,
              child: widget.child,
            ),

            // Tooltip
            Positioned(
              top: -60,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Tap detector
            if (widget.onTap != null)
              Positioned.fill(
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}