import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:nb_utils/nb_utils.dart';

class WelcomeBankScreen extends StatefulWidget {
  const WelcomeBankScreen({super.key});

  @override
  State<WelcomeBankScreen> createState() => _WelcomeBankScreenState();
}

class _WelcomeBankScreenState extends State<WelcomeBankScreen> {
  PageController? _pageController;
  int _currentIndex = 0;

  // Données des slides
  final List<SlideData> _slides = [
    SlideData(
      icon: Icons.credit_card,
      title: 'Créez et gérez vos cartes\nvirtualles à volonté',
      backgroundColor: Colors.red,
    ),
    SlideData(
      icon: Icons.swap_horiz,
      title: 'Effectuez des transferts\nentre comptes',
      backgroundColor: Colors.green.shade400,
    ),
    SlideData(
      icon: Icons.payment,
      title: 'Effectuez des paiements\nmarchands et bien plus',
      backgroundColor: Colors.blue.shade400,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Auto-slide toutes les 4 secondes
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _nextSlide();
        _startAutoSlide();
      }
    });
  }

  void _nextSlide() {
    if (_pageController != null) {
      if (_currentIndex < _slides.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController!.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showAccountModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Titre de la modal
                const Text(
                  'Avez-vous un compte bancaire\nchez CREDIT FEF ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 32),

                // Bouton Oui
                AppButton(
                  width: double.infinity,
                  height: 56,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/login');
                  },
                  elevation: 0.0,
                  color: AppColors.primary,
                  child: const Text(
                    'Oui, accéder à mes comptes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Bouton Non
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.pop(context);
                        _showCountrySelectionModal(context);
                      },
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Non, ouvrir un compte',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCountrySelectionModal(BuildContext context) {
    int selectedCountryIndex = 1; // Côte d'Ivoire sélectionnée par défaut

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // En-tête
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Sélectionnez votre pays',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),

                  // Liste des pays
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            _buildCountryItem(
                              flag: '🇨🇲',
                              name: 'Cameroun',
                              isSelected: selectedCountryIndex == 0,
                              isAvailable: true,
                              onTap: () => setModalState(() => selectedCountryIndex = 0),
                            ),
                            _buildCountryItem(
                              flag: '🇨🇮',
                              name: 'Côte d\'Ivoire',
                              isSelected: selectedCountryIndex == 1,
                              isAvailable: true,
                              onTap: () => setModalState(() => selectedCountryIndex = 1),
                            ),
                            _buildCountryItem(
                              flag: '🇰🇲',
                              name: 'Comores',
                              isSelected: selectedCountryIndex == 2,
                              isAvailable: true,
                              onTap: () => setModalState(() => selectedCountryIndex = 2),
                            ),
                            _buildCountryItem(
                              flag: '🇬🇦',
                              name: 'Gabon',
                              isSelected: selectedCountryIndex == 3,
                              isAvailable: true,
                              onTap: () => setModalState(() => selectedCountryIndex = 3),
                            ),
                            _buildCountryItem(
                              flag: '🇲🇬',
                              name: 'Madagascar',
                              isSelected: selectedCountryIndex == 4,
                              isAvailable: false,
                              onTap: () {},
                            ),
                            _buildCountryItem(
                              flag: '🇲🇱',
                              name: 'Mali',
                              isSelected: selectedCountryIndex == 5,
                              isAvailable: false,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bouton Continuer
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: AppButton(
                      width: double.infinity,
                      height: 56,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onTap: () {
                        context.go('/termsConditionsPath');
                        // Action pour continuer avec le pays sélectionné
                      },
                      elevation: 0.0,
                      color: AppColors.primary,
                      child: const Text(
                        'Continuer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCountryItem({
    required String flag,
    required String name,
    required bool isSelected,
    required bool isAvailable,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.shade100 : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: isAvailable ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Drapeau
                Container(
                  width: 32,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      flag,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Nom du pays
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: isAvailable ? Colors.black : Colors.grey.shade400,
                    ),
                  ),
                ),

                // Indicateur de statut
                if (!isAvailable)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Bientôt disponible',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                if (isSelected && isAvailable)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              // Contenu principal des slides
              Column(
                children: [
                  // Contenu des slides - Utilisation d'Expanded pour donner une hauteur définie
                  Expanded(
                    child: Column(
                      children: [
                        // PageView avec hauteur définie
                        Expanded(
                          flex: 5, // Augmenté pour réduire l'espace blanc
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: _onPageChanged,
                            itemCount: _slides.length,
                            itemBuilder: (context, index) {
                              final slide = _slides[index];
                              return Column(
                                children: [
                                  // Icône de la slide avec arrière-plan coloré
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            slide.backgroundColor.withOpacity(0.8),
                                            slide.backgroundColor,
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            slide.icon,
                                            size: 100,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Contenu en bas avec texte
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            // Titre de la slide
                                            Text(
                                              slide.title,
                                              style: boldTextStyle(size: 28, color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        // Section fixe avec boutons
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                          child: Column(
                            children: [
                              // Bouton Commencer avec couleur dynamique
                              AppButton(
                                width: context.width(),
                                height: 56,
                                shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onTap: () {
                                  _showAccountModal(context);
                                },
                                elevation: 0.0,
                                color: AppColors.primary,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Commencer',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 16),

                              // Texte d'ouverture de compte
                              Center(
                                child: Column(
                                  children: [
                                    Text(
                                      'Ouverture de compte en cours ?',
                                      style: secondaryTextStyle(size: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    GestureDetector(
                                      onTap: () {
                                        // Action pour continuer/suivre la demande
                                      },
                                      child: Text(
                                        'Continuez / Suivre sa demande',
                                        style: AppTextStyles.bodyBold.copyWith(
                                          decoration: TextDecoration.underline,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Header flottant avec barre de progression et logo
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 116,
                  child: Stack(
                    children: [
                      // Barre de progression en haut
                      Positioned(
                        top: 16,
                        left: 16,
                        right: 16,
                        child: Row(
                          children: List.generate(_slides.length, (index) {
                            return Expanded(
                              child: Container(
                                height: 4,
                                margin: EdgeInsets.only(
                                  right: index < _slides.length - 1 ? 4 : 0,
                                ),
                                decoration: BoxDecoration(
                                  color: index <= _currentIndex
                                      ? AppColors.primary
                                      : Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      // Logo AFG Bank centré
                      Positioned(
                        top: 40,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(
                            AssetConstants.logo,
                            height: 60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Classe pour les données de slide
class SlideData {
  final IconData icon;
  final String title;
  final Color backgroundColor;

  SlideData({
    required this.icon,
    required this.title,
    required this.backgroundColor,
  });
}