import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class WelcomeMessageWidget extends StatefulWidget {
  final String userName;
  final VoidCallback onDismiss;

  const WelcomeMessageWidget({
    Key? key,
    required this.userName,
    required this.onDismiss,
  }) : super(key: key);

  @override
  State<WelcomeMessageWidget> createState() => _WelcomeMessageWidgetState();
}

class _WelcomeMessageWidgetState extends State<WelcomeMessageWidget>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _floatingController;
  late AnimationController _slideController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _floatingAnimation;

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.8, curve: Curves.elasticOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));

    _floatingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    _mainController.forward();
    _slideController.forward();
    _floatingController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _mainController.dispose();
    _floatingController.dispose();
    _slideController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              margin: const EdgeInsets.all(16),
              height: 400,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary, // AppColors.secondary
                    AppColors.secondary, // AppColors.primary
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF005828).withOpacity(0.3), // AppColors.secondary
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Floating circles animation
                  _buildFloatingElements(),

                  // Main content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Header with close button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SlideTransition(
                              position: _slideAnimation,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bienvenue ${widget.userName}! 👋',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    'Découvrez votre plateforme CEI',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: widget.onDismiss,
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // PageView with features
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            children: [
                              _buildFeaturePage(
                                icon: FluentIcons.person_add_20_filled,
                                title: 'Enrôlement Electoral',
                                description: 'Inscrivez-vous facilement sur les listes électorales et suivez votre demande.',
                                features: [
                                  'Enrôlement en ligne sécurisé',
                                  'Suivi de statut en temps réel',
                                  'Changement de centre',
                                  'Notifications automatiques',
                                ],
                              ),
                              _buildFeaturePage(
                                icon: FluentIcons.location_20_filled,
                                title: 'Centres & Vérification',
                                description: 'Trouvez vos centres d\'enrôlement et vérifiez votre inscription électorale.',
                                features: [
                                  'Localisation des centres GPS',
                                  'Vérification d\'inscription',
                                  'Informations détaillées centres',
                                  'Sauvegarde automatique',
                                ],
                              ),
                              _buildFeaturePage(
                                icon: FluentIcons.document_20_filled,
                                title: 'Services Électoraux',
                                description: 'Accédez à tous les services électoraux : listes, résultats, candidatures.',
                                features: [
                                  'Consultation liste électorale',
                                  'Résultats d\'élections',
                                  'Dépôt de candidatures',
                                  'Gestion des contentieux',
                                ],
                              ),
                              _buildFeaturePage(
                                icon: FluentIcons.people_20_filled,
                                title: 'Participation Citoyenne',
                                description: 'Participez activement à la vie démocratique de votre pays.',
                                features: [
                                  'CEI Locale - infos régionales',
                                  'Suivi des candidatures',
                                  'Réclamations en ligne',
                                  'Notifications importantes',
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Page indicators
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentPage == index ? 20 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? Colors.white
                                    : Colors.white54,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          }),
                        ),

                        const SizedBox(height: 16),

                        // CTA Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: widget.onDismiss,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF005828), // AppColors.secondary
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Commencer l\'exploration',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingElements() {
    return AnimatedBuilder(
      animation: _floatingAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: 30 + (10 * _floatingAnimation.value),
              right: 30,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 80 - (15 * _floatingAnimation.value),
              right: 80,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: 40 + (8 * _floatingAnimation.value),
              left: 40,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFeaturePage({
    required IconData icon,
    required String title,
    required String description,
    required List<String> features,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon with animation
        AnimatedBuilder(
          animation: _floatingAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 5 * _floatingAnimation.value),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        // Description
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            height: 1.4,
          ),
        ),

        const SizedBox(height: 20),

        // Features list
        ...features.map((feature) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  feature,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        )).toList(),
      ],
    );
  }
}

// Extension pour faciliter l'intégration dans votre HomeScreen
extension WelcomeMessageExtension on State {
  void showWelcomeMessage({
    required String userName,
    required VoidCallback onDismiss,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      barrierDismissible: false,
      builder: (context) => WelcomeMessageWidget(
        userName: userName,
        onDismiss: () {
          Navigator.of(context).pop();
          onDismiss();
        },
      ),
    );
  }
}