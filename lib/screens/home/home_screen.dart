import 'package:cei_mobile/common_widgets/carrousel_widget.dart';
import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/common_widgets/welcome_message_widget.dart';
import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:cei_mobile/repository/verification_repository.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Add loading state
  bool _isLoading = true;
  bool _hasShownWelcome = false;

  @override
  void initState() {
    super.initState();
    // Simulate loading data
    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    await performVoterIdSearch();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        // Vérifier et afficher le message de bienvenue après le chargement
        _checkAndShowWelcome();
      }
    });
  }

  Future<void> performVoterIdSearch() async {
    try {

      final result = await verifyEnrolmentUniqId({
        'form': 'NUM_ELECTOR',
        'uniqueRegistrationNumber':  userStore.numEnregister,
      });
      setState(() {
        _isLoading = false;
      });
      final enrollmentData = EnrollmentData.fromJson(result['data']);
      if(enrollmentData.numEnregister != null){
       if(enrollmentData.centre != null){
         appStore.setVoterCenterId(enrollmentData.centre!.id.validate());
         appStore.setIsVoterCenterSaved(true);
         enrollmentStore.isEnrollmentComplete = true;
       }
        appStore.setEnrollmentData(enrollmentData);
      }
    } catch (e) {
      print(e);
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildContent() {
    if (appStore.isVoterCenterSaved && appStore.enrollmentData != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFDBF86),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.map, color: AppColors.primary),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Mon centre d\'enrolement",
                        style: AppTextStyles.body2,
                      ),
                      Text(
                        appStore.enrollmentData != null?appStore.enrollmentData!.centre!.name.validate():"",
                        style: AppTextStyles.h4.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 14
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.enrollmentCenter, extra: appStore.voterCenterId);
                },
                child: Text(
                  'Voir',
                  style: AppTextStyles.button.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // Display a card prompting the user to register a voting center
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      "Aucun centre d'enrôlement enregistré",
                      style: AppTextStyles.h4.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                "Vous n'avez pas encore enregistré votre centre d'enrolement",
                style: AppTextStyles.body2,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: AppButton(
                  shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                  elevation: 0.0,
                  color: AppColors.primary,
                  onTap: () {
                    context.pushNamed(AppRoutes.enrollmentVerification,
                        pathParameters: {'isAddLocation': 'true'});
                  },
                  child: Text('Enregistrer mon centre',
                      style: boldTextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildEnrollmentStatusCard() {
    return Observer(
      builder: (_) {
        // First check if user is properly logged in and has data
        if (userStore.numEnregister == null || userStore.numEnregister!.isEmpty) {
          return const SizedBox.shrink();
        }

        // Get enrollment data from appStore (API fetched data)
        final enrollmentData = appStore.enrollmentData;

        // Determine if we have any enrollment to show
        bool hasLocalEnrollment = enrollmentStore.hasActiveEnrollment || enrollmentStore.currentStep > 0;
        bool hasApiEnrollment = enrollmentData != null &&
            enrollmentData.numEnregister != null &&
            enrollmentData.numEnregister!.isNotEmpty;

        // If no enrollment data at all, don't show the card
        if (!hasLocalEnrollment && !hasApiEnrollment) {
          return const SizedBox.shrink();
        }

        // Additional check: ensure the enrollment data belongs to current user
        if (hasApiEnrollment) {
          // Verify that the API enrollment data belongs to the current user
          if (enrollmentData!.numEnregister != userStore.numEnregister) {
            // This enrollment data doesn't belong to current user, clear it
            WidgetsBinding.instance.addPostFrameCallback((_) {
              appStore.setEnrollmentData(null);
            });
            return const SizedBox.shrink();
          }
        }

        // Priority: If API data exists, it means enrollment was submitted - use only API data
        bool useApiData = hasApiEnrollment;

        // Determine enrollment status and properties
        String enrollmentStatus;
        String? referenceNumber;
        bool isIncomplete = false;
        bool isRejected = false;
        bool isValidated = false;
        bool isPending = false;
        DateTime? enrollmentDate;

        if (useApiData) {
          // Use API enrollment data only (enrollment was submitted)
          final apiStatus = enrollmentData!.status?.toLowerCase();

          switch (apiStatus) {
            case 'en_attente':
              enrollmentStatus = 'En attente de validation';
              isPending = true;
              break;
            case 'valide':
              enrollmentStatus = 'Validé';
              isValidated = true;
              break;
            case 'rejete':
              enrollmentStatus = 'Rejeté';
              isRejected = true;
              break;
            default:
              enrollmentStatus = 'Soumis';
              isPending = true;
          }

          referenceNumber = enrollmentData.numOrder ?? enrollmentData.numForm ?? enrollmentData.numEnregister;
          enrollmentDate = enrollmentData.dateEnrolement;

        } else {
          // Use local enrollment store data (enrollment not yet submitted)
          enrollmentStatus = enrollmentStore.enrollmentStatus ?? 'En cours';
          referenceNumber = enrollmentStore.enrollmentReferenceNumber;

          // Check if local enrollment is incomplete
          isIncomplete = !enrollmentStore.hasActiveEnrollment && enrollmentStore.currentStep > 0;
        }

        // Calculate remaining time for incomplete enrollment (24 hours from when they started)
        String timeRemaining = "23:45:30"; // This would be dynamically calculated in a real app

        // Determine card colors and icon based on status
        List<Color> gradientColors;
        Color iconColor;
        IconData statusIcon;

        if (isRejected) {
          gradientColors = [Colors.red[700]!, Colors.red[900]!];
          iconColor = Colors.red[700]!;
          statusIcon = Icons.cancel;
        } else if (isValidated) {
          gradientColors = [Colors.green[600]!, Colors.green[800]!];
          iconColor = Colors.green[700]!;
          statusIcon = Icons.check_circle;
        } else if (isPending) {
          gradientColors = [Colors.orange[600]!, Colors.orange[800]!];
          iconColor = Colors.orange[700]!;
          statusIcon = Icons.hourglass_empty;
        } else if (isIncomplete) {
          gradientColors = [Colors.red[600]!, Colors.red[800]!];
          iconColor = Colors.red[700]!;
          statusIcon = Icons.warning_amber_rounded;
        } else {
          gradientColors = [AppColors.primary.withOpacity(0.8), AppColors.primary];
          iconColor = AppColors.primary;
          statusIcon = Icons.how_to_reg;
        }

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          statusIcon,
                          color: iconColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Mon enrôlement',
                              style: AppTextStyles.h4.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Status: ${_getEnrollmentTitle(isIncomplete, isRejected, isValidated, isPending, enrollmentStatus)}",
                              style: AppTextStyles.body2.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            if (isIncomplete)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    color: Colors.white70,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "Expire dans: $timeRemaining",
                                      style: AppTextStyles.body2.copyWith(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: 12,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            else if (referenceNumber != null)
                              Text(
                                "Ref: $referenceNumber",
                                style: AppTextStyles.body2.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                            // Show enrollment date if available
                            if (enrollmentDate != null && !isIncomplete)
                              Text(
                                "Soumis le: ${_formatEnrollmentDate(enrollmentDate)}",
                                style: AppTextStyles.body2.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                            // Show rejection reason if applicable
                            if (isRejected && enrollmentData?.motifRejet != null && enrollmentData!.motifRejet!.isNotEmpty)
                              Text(
                                "Motif: ${enrollmentData.motifRejet}",
                                style: AppTextStyles.body2.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                            // Show validation date if available
                            if (isValidated && enrollmentData?.dateValidation != null)
                              Text(
                                "Validé le: ${_formatEnrollmentDate(enrollmentData!.dateValidation!)}",
                                style: AppTextStyles.body2.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (isIncomplete) {
                      // Resume enrollment at the last step
                      context.pushNamed(AppRoutes.enrollment);
                    } else if (useApiData) {
                      // Navigate to enrollment status screen with API data
                      context.pushNamed(AppRoutes.enrollmentStatusDynamic, extra: enrollmentData);
                    } else {
                      // Navigate to enrollment status screen (local data)
                      context.pushNamed(AppRoutes.enrollmentStatus);
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    isIncomplete ? 'Continuer' : 'Voir',
                    style: AppTextStyles.button.copyWith(
                      color: iconColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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

// Helper method to get enrollment card title
  String _getEnrollmentTitle(bool isIncomplete, bool isRejected, bool isValidated, bool isPending, String status) {
    if (isIncomplete) {
      return "Enrôlement incomplet";
    } else if (isRejected) {
      return "Enrôlement rejeté";
    } else if (isValidated) {
      return "Enrôlement validé";
    } else if (isPending) {
      return "En attente de validation";
    } else {
      return "Statut: $status";
    }
  }

  String _formatEnrollmentDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }


  // Updated enrollment button method
  Widget _buildEnrollmentButton() {
    return Observer(
        builder: (_) {
          // Check if enrollment is submitted
          bool isEnrollmentSubmitted = enrollmentStore.isEnrollmentComplete;

          String buttonText = isEnrollmentSubmitted ? "Changement de centre" : "M'enrôler";
          IconData buttonIcon = isEnrollmentSubmitted ? Icons.sync : Icons.person_add_outlined;

          return _buildMenuCard(
              buttonIcon,
              buttonText,
              true,
              onTap: () {
                if (isEnrollmentSubmitted) {
                  // context.pushNamed(AppRoutes.enrollmentVerification,
                  //     pathParameters: {'isAddLocation': 'true'});
                } else {
                  // Navigate to enrollment screen
                  context.pushNamed(AppRoutes.enrollment);
                }
              }
          );
        }
    );
  }


  Future<void> _checkAndShowWelcome() async {
    final prefs = await SharedPreferences.getInstance();
    final hasShownWelcome = prefs.getBool('has_shown_welcome_${userStore.numEnregister ?? "default"}') ?? false;

    if (!hasShownWelcome && !_isLoading) {
      // Attendre que l'interface soit prête
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_hasShownWelcome) {
          _hasShownWelcome = true;
          _showWelcomeMessage();
        }
      });
    }
  }

  // Méthode pour afficher le message de bienvenue
  void _showWelcomeMessage() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7),
      barrierDismissible: false,
      builder: (context) => WelcomeMessageWidget(
        userName: userStore.firstName ?? 'Utilisateur',
        onDismiss: () async {
          // Sauvegarder que l'utilisateur a vu le message
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('has_shown_welcome_${userStore.numEnregister ?? "default"}', true);

          Navigator.of(context).pop();
        },
      ),
    );
  }



  // Alternative: Vous pouvez aussi ajouter un bouton dans votre AppBar pour afficher manuellement le message
  Widget _buildWelcomeButton() {
    return IconButton(
      icon: const Icon(Icons.help_outline, color: Colors.white),
      onPressed: _showWelcomeMessage,
      tooltip: 'Guide d\'utilisation',
    );
  }

  // Modifiez votre AppBar pour inclure le bouton d'aide (optionnel)
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.secondary,
      elevation: 0,
      title: Text(
        'Akwaba ${userStore.firstName}',
        style: AppTextStyles.h2.copyWith(color: Colors.white),
      ),
      actions: [
        _buildWelcomeButton(), // Nouveau bouton d'aide
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaffoldBgWidget(
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar
                16.height,
                Skeletonizer(
                  enabled: _isLoading,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Rechercher un centre',
                      hintStyle: AppTextStyles.body2
                          .copyWith(color: AppColors.textSecondary),
                      prefixIcon: const Icon(Icons.search,
                          color: AppColors.textSecondary),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                16.height,
                Skeletonizer(
                  enabled: _isLoading,
                  child: CarrouselWidget(
                    carouselItems: const [AssetConstants.homeslide2, AssetConstants.homeslide1],
                  ),
                ),
                16.height,
                Skeletonizer(
                  enabled: _isLoading,
                  child: _buildEnrollmentStatusCard(),
                ),
                Observer(builder: (context) {
                  return Skeletonizer(
                    enabled: _isLoading,
                    child: _buildContent(),
                  );
                }),

                // Menu Grid
                Skeletonizer(
                  enabled: _isLoading,
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      _buildMenuCard(FluentIcons.location_20_regular,
                          "Centre d'enrôlement", true, onTap: () {
                            context.pushNamed(AppRoutes.enrollmentVerification,
                                pathParameters: {'isAddLocation': 'true'});
                          }),
                      _buildMenuCard(FluentIcons.checkmark_20_regular,
                          "Vérification", true, onTap: () {
                            context.pushNamed(AppRoutes.enrollmentVerification,
                                pathParameters: {'isAddLocation': 'false'});
                          }),
                      _buildMenuCard(
                          Icons.chat_bubble_outline, "Réclamations", true,
                          onTap: () {
                            context.pushNamed(AppRoutes.reclamationList);
                          }),
                      _buildMenuCard(
                       FluentIcons.poll_20_filled,
                        "Résultat\nd'élection",
                        true,
                          onTap: () {
                            context.pushNamed(AppRoutes.electionSelection);
                          }
                      ),
                      _buildMenuCard(
                        FluentIcons.building_home_20_regular,
                        "CEI Locale",
                        true,
                      ),
                      // Dynamic enrollment button
                      _buildEnrollmentButton(),
                      _buildMenuCard(
                          Icons.library_books_outlined, "Liste électorale", true,
                          onTap: () {
                            context.pushNamed(AppRoutes.electoralList);
                          }),
                      _buildMenuCard(
                          FluentIcons.document_briefcase_20_regular, "Candidature", true,
                          onTap: () {
                            context.pushNamed(AppRoutes.candidatureSelectionScreen);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(IconData icon, String label, bool isActive,
      {VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: isActive
                ? AppColors.primary.withOpacity(0.5)
                : AppColors.grey2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.grey2,
            size: 32,
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.body2.copyWith(
              color: isActive ? AppColors.primary : AppColors.grey2,
              height: 1.2,
            ),
          ),
        ],
      ),
    ).onTap(isActive ? onTap : null);
  }
}