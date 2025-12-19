import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:nb_utils/nb_utils.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  bool _isAccepted = false;
  final ScrollController _scrollController = ScrollController();
  bool _showScrollButton = false;
  bool _isAtTop = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    // Vérifier s'il y a du contenu à faire défiler après la construction
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScrollable();
    });
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;

    final currentPosition = _scrollController.position.pixels;
    final maxExtent = _scrollController.position.maxScrollExtent;

    // Détermine si on est en haut (dans les premiers 50px)
    final isAtTop = currentPosition <= 50;

    // Détermine si on est en bas (dans les derniers 100px)
    final isAtBottom = currentPosition >= maxExtent - 100;

    // Afficher le bouton seulement s'il y a du contenu scrollable et qu'on n'est pas en bas
    final shouldShowButton = maxExtent > 0 && !isAtBottom;

    if (_showScrollButton != shouldShowButton || _isAtTop != isAtTop) {
      setState(() {
        _showScrollButton = shouldShowButton;
        _isAtTop = isAtTop;
      });
    }
  }

  void _checkScrollable() {
    // Vérifier si le contenu est plus long que la zone visible
    if (_scrollController.hasClients) {
      final isScrollable = _scrollController.position.maxScrollExtent > 0;
      setState(() {
        _showScrollButton = isScrollable;
        _isAtTop = _scrollController.position.pixels <= 50;
      });
    }
  }

  void _scrollAction() {
    if (_isAtTop) {
      // Si on est en haut, aller en bas
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    } else {
      // Si on est au milieu ou ailleurs, aller en haut
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              context.pushNamed(AppRoutes.welcomeBankScreen);
            },
          ),
          title: Text(
            'TERMES ET CONDITIONS GÉNÉRALES\nD\'UTILISATION',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Contenu scrollable - utilise Flexible au lieu d'Expanded pour éviter les overflows
              Flexible(
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0), // Padding bottom pour éviter le chevauchement avec les boutons
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section XVI
                          Text(
                            "à opposition dans les conditions prévues par la loi en vigueur. Le Client peut obtenir une copie des données le concernant et, le cas échéant, les faire rectifier par courrier adressé au siège social de la Banque.",
                            style: AppTextStyles.body1.copyWith(
                              fontSize: 14,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Titre XVII
                          Text(
                            "XVII. BLANCHIMENT DES CAPITAUX",
                            style: AppTextStyles.bodyBold.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Contenu XVII
                          Text(
                            "Des dispositions pénales sanctionnent le blanchiment des capitaux provenant d'un trafic de stupéfiants ou de blanchiment du produit de tout crime ou délit. Dans le cadre de la lutte contre le blanchiment des capitaux, la loi fait obligation à la Banque de s'informer auprès de son Client sur toutes opérations qui lui apparaîtront comme inhabituelles en raison notamment de leurs modalités, de leur montant ou de leur caractère exceptionnel au regard de celles traitées jusqu'alors par ce dernier. Le Client s'engage à donner à la Banque toute information sur le contexte de ces opérations",
                            style: AppTextStyles.body1.copyWith(
                              fontSize: 14,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Titre XVIII
                          Text(
                            "XVIII. Loi applicable-compétence juridictionnelle",
                            style: AppTextStyles.bodyBold.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Contenu XVIII
                          Text(
                            "Le présent Contrat est régi pour sa validité, son interprétation et son exécution par le droit en vigueur en Côte d'Ivoire. Les Tribunaux de Côte d'Ivoire sont les seuls compétents pour connaître des litiges auxquels le présent Contrat pourrait",
                            style: AppTextStyles.body1.copyWith(
                              fontSize: 14,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Checkbox d'acceptation
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isAccepted = !_isAccepted;
                              });
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: _isAccepted ? AppColors.primary : Colors.transparent,
                                      border: Border.all(
                                        color: _isAccepted ? AppColors.primary : Colors.grey.shade400,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: _isAccepted
                                        ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    )
                                        : null,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      "J'atteste avoir lu et compris les termes et conditions.",
                                      style: AppTextStyles.body1.copyWith(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),
                        ],
                      ),
                    ),

                    // Bouton dynamique pour naviguer
                    if (_showScrollButton)
                      Positioned(
                        right: 16,
                        bottom: 16,
                        child: AnimatedOpacity(
                          opacity: _showScrollButton ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(28),
                                onTap: _scrollAction,
                                child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 200),
                                    child: Icon(
                                      _isAtTop ? Icons.expand_more_rounded : Icons.expand_less_rounded,
                                      key: ValueKey(_isAtTop),
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Boutons en bas - utilisent une taille fixe
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 56,
                    maxHeight: 80, // Limite la hauteur maximale
                  ),
                  child: Row(
                    children: [
                      // Bouton Refuser
                      Expanded(
                        child: Container(
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
                                Navigator.of(context).pop();
                              },
                              child: const Center(
                                child: Text(
                                  'REFUSER',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Bouton Accepter
                      Expanded(
                        child: AppButton(
                          height: 56,
                          shapeBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          onTap: _isAccepted ? () {
                            // Action pour accepter les termes
                            context.pushNamed(AppRoutes.identityVerificationScreen);
                            // Naviguer vers la suite du processus
                          } : null,
                          elevation: 0.0,
                          color: _isAccepted ? AppColors.primary : Colors.grey.shade300,
                          child: Text(
                            'ACCEPTER',
                            style: TextStyle(
                              color: _isAccepted ? Colors.white : Colors.grey.shade500,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
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