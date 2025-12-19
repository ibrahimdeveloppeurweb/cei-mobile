import 'package:cei_mobile/common_widgets/floating_bottom_action_widget.dart';
import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/constants/app_constants.dart';
import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/screens/auth/country_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  bool isRemember = false;
  bool isFirstTime = true;

  // État : on stocke uniquement le code sélectionné
  String selectedCode = '+225';
  String selectedFlag = '🇨🇮';
  String selectedCountry = 'Côte d\'Ivoire';

  // Fonction pour afficher le modal de confirmation
  void _showExitConfirmationModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Souhaitez-vous vraiment revenir sur la page d\'accueil ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  // Bouton Oui
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pushNamed(AppRoutes.welcomeBankScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Oui',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Bouton Non
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Fermer le modal uniquement
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Non',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Nouvelle fonction pour afficher le modal Agences et GAB
  void _showAgenciesModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Barre de glissement
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Titre
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Afficher les Agences',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Option Agences
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    // Naviguer vers la page des agences
                    // context.pushNamed(AppRoutes.agencesScreen);
                    print('Navigation vers Agences');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.account_balance,
                            color: AppColors.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            'Agences',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade600,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  // Fonction pour ouvrir la page de sélection
  void _openCountrySelection() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountrySelectionScreen(selectedCode: selectedCode),
      ),
    );

    if (result != null) {
      setState(() {
        selectedCode = result['code']!;
        selectedFlag = result['flag']!;
        selectedCountry = result['name']!;
      });
    }
  }

  void _login() async {
    try {
      appStore.setLoading(true);
      final result = await apiClient.login(emailCont.text, passwordCont.text);
      print(result);
      print(result['numberEnrgister']);
      userStore.loadUserFromJson(result['data']);
      await setValue(AppConstants.authTokenKey, tokenManager.token);
      await setValue(AppConstants.refreshTokenKey, tokenManager.refreshToken);
      appStore.setLoggedIn(true);
      context.go(AppRoutes.homePath);
    } catch (e) {
      toast('$e');
    } finally {
      appStore.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Créer une instance d'OutlineInputBorder pour récupérer son BorderRadius
    const outlineInputBorder = OutlineInputBorder();
    final borderRadius = outlineInputBorder.borderRadius;

    return ScaffoldBgWidget(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton:const FloatButtomActionWidjet(
          openButtonBackgroundColor: Colors.red,
          closeButtonBackgroundColor: Colors.red,
        ),
        // Ajout de l'AppBar avec bouton retour
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 24,
            ),
            onPressed: _showExitConfirmationModal, // Appeler le modal
          ),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Réduit l'espace en haut puisqu'on a maintenant un AppBar
                        10.height,
                        Image.asset(
                          AssetConstants.logo,
                          height: 80,
                        ),
                        Text("Connexion",
                            style: boldTextStyle(size: 28, color: Colors.black)),
                        Text("Entrez vos identifiants pour vous connecter",
                            style: secondaryTextStyle()),
                        30.height,
                        const Text('N° de téléphone', style: AppTextStyles.body2),
                        Row(
                          children: [
                            // Conteneur pour la sélection du pays
                            GestureDetector(
                              onTap: _openCountrySelection,
                              child: Container(
                                width: 120,
                                height: 56, // Hauteur standard d'un TextField
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade400),
                                  borderRadius: borderRadius, // Utilise exactement le même BorderRadius que OutlineInputBorder
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(selectedFlag, style: const TextStyle(fontSize: 20)),
                                        const SizedBox(width: 4),
                                        Text(selectedCode, style: boldTextStyle(size: 14)),
                                      ],
                                    ),
                                    const Icon(Icons.keyboard_arrow_down, size: 20),
                                  ],
                                ),
                              ),
                            ),
                            12.width,
                            Expanded(
                              child: AppTextField(
                                controller: emailCont,
                                decoration: const InputDecoration(
                                  hintText: 'Ex: 0100045621',
                                  border: OutlineInputBorder(), // Garde le OutlineInputBorder par défaut
                                ),
                                textFieldType: TextFieldType.NUMBER,
                                errorThisFieldRequired: "Saisir votre numéro de téléphone",
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly, // N'autorise que les chiffres
                                ],
                                keyboardType: TextInputType.number, // Affiche le clavier numérique
                              ),
                            ),
                          ],
                        ),

                        16.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isRemember,
                                  onChanged: (val) {
                                    setState(() {
                                      isRemember = val!;
                                    });
                                  },
                                ),
                                const Text("Se souvenir de moi"),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Mot de passe oublié ?",
                                style: AppTextStyles.bodyBold.copyWith(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                        30.height,
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Observer(builder: (builder) {
                                return
                                  AppButton(
                                    width: context.width(),
                                    shapeBorder:
                                    RoundedRectangleBorder(borderRadius: radius()),
                                    onTap: () {
                                      // if (formKey.currentState!.validate()) {
                                      //   _login();
                                      // }
                                      context.pushNamed(AppRoutes.creditFefAssistantPinScreen);
                                    },
                                    elevation: 0.0,
                                    color: AppColors.primary,
                                    child: appStore.isLoading
                                        ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    )
                                        : const Text('Me connecter',
                                        style: TextStyle(color: Colors.white)),
                                  );
                              }),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: const Color(0xFF1B77B2),
                  padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.account_balance, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                          child: TextButton(
                            onPressed: _showAgenciesModal, // Appel du modal
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero, // Supprime le padding interne
                              alignment: Alignment.centerLeft, // Aligne le texte à gauche
                            ),
                            child: const Text(
                              "Agences et GAB\nDécouvrez les Agences et GAB près de vous",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          )

                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}