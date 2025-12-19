import 'package:cei_mobile/common_widgets/floating_bottom_action_widget.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/screens/auth/country_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:async';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  @override
  State<IdentityVerificationScreen> createState() => _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState extends State<IdentityVerificationScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Key pour ExpandableFab
  final GlobalKey<ExpandableFabState> _key = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Step 1: Phone Verification
  List<String> _verificationCode = ['', '', '', '', '', ''];
  Timer? _timer;
  int _countdownSeconds = 294; // 4:54
  String _generatedCode = ''; // Code généré automatiquement
  bool _codeGenerated = false; // Indicateur si un code a été généré
  bool _codeExpired = false; // NOUVEAU: Indicateur si le code a expiré

  // Step 2: Identity Form
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();

  // Step 3: Contact Information
  final TextEditingController _phoneController = TextEditingController();
  // État : on stocke uniquement le code sélectionné
  String selectedCode = '+225';
  String selectedFlag = '🇨🇮';
  String selectedCountry = 'Côte d\'Ivoire';

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel(); // Annuler le timer précédent s'il existe
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdownSeconds > 0) {
        setState(() {
          _countdownSeconds--;
        });
      } else {
        // MODIFICATION: Marquer le code comme expiré quand le countdown atteint 0
        setState(() {
          _codeExpired = true;
        });
        timer.cancel();

        // Optionnel: Afficher un message d'expiration
        if (_codeGenerated && !_codeExpired) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Le code de vérification a expiré. Veuillez demander un nouveau code.'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    });
  }

  String get _formattedCountdown {
    int minutes = _countdownSeconds ~/ 60;
    int seconds = _countdownSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  bool _isStep1Valid() {
    // MODIFICATION: Vérifier aussi si le code n'a pas expiré
    if (!_codeGenerated || _codeExpired) return false;
    String enteredCode = _verificationCode.join('');
    return enteredCode.length == 6 && enteredCode == _generatedCode;
  }

  bool _isStep2Valid() {
    return _lastNameController.text.trim().isNotEmpty &&
        _firstNameController.text.trim().isNotEmpty;
  }

  bool _isStep3Valid() {
    return _phoneController.text.trim().isNotEmpty;
  }

  // Nouvelle méthode pour obtenir le numéro complet avec le code pays
  String get fullPhoneNumber {
    return selectedCode + _phoneController.text.trim();
  }

  void _nextStep() {
    // Vérifier si l'étape actuelle est valide avant de passer à la suivante
    if (!_isCurrentStepValid()) {
      return; // Ne pas permettre la navigation si les conditions ne sont pas remplies
    }

    // Si on est à l'étape de contact et qu'on veut passer à la vérification
    if (_currentStep == 0) {
      _generateVerificationCode(); // Générer le code avant de passer à l'étape suivante
    }

    if (_currentStep < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Générer un code de vérification aléatoire
  void _generateVerificationCode() {
    final random = DateTime.now().millisecondsSinceEpoch;
    _generatedCode = (random % 900000 + 100000).toString(); // Code à 6 chiffres
    _codeGenerated = true;
    _codeExpired = false; // NOUVEAU: Réinitialiser l'état d'expiration
    print('Code généré: $_generatedCode'); // Pour debug

    // Réinitialiser le timer et les champs de saisie
    _countdownSeconds = 294;
    _verificationCode = ['', '', '', '', '', ''];
    _startCountdown();

    setState(() {});

    // Afficher un message de confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Code envoyé au $fullPhoneNumber'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: _currentStep > 0 ? _previousStep : () => ContextExtensions(context).pop(),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Progress Bar
            Container(
              height: 4,
              child: LinearProgressIndicator(
                value: (_currentStep + 1) / 4,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            // Page Content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                children: [
                  _buildContactInfoStep(),
                  _buildPhoneVerificationStep(),
                  _buildIdentityFormStep(),
                  _buildVerificationInfoStep(),
                ],
              ),
            ),
            // Bottom Button
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
                child: AppButton(
                  height: 56,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onTap: _getButtonAction(),
                  elevation: 0.0,
                  color: _isCurrentStepValid() ? AppColors.primary : Colors.grey.shade300,
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 32),
                          child: Text(
                            _getButtonText(),
                            style: TextStyle(
                              color: _isCurrentStepValid() ? Colors.white : Colors.grey.shade500,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneVerificationStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 200,
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                32.height,
                Text(
                  'Vérifier votre numéro',
                  style: AppTextStyles.bodyBold.copyWith(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                16.height,
                Text(
                  'Veuillez saisir le code que vous avez reçu par mail et au $fullPhoneNumber',
                  style: AppTextStyles.body1.copyWith(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                // MODIFICATION: Afficher différents messages selon l'état du code
                if (_codeGenerated && !_codeExpired) ...[
                  16.height,
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: AppColors.primary, size: 16),
                        8.width,
                        Text(
                          'Code de test: $_generatedCode',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] ,
                48.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return Container(
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _codeExpired ? Colors.red.shade50 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _codeExpired
                              ? Colors.red.shade300
                              : (_verificationCode[index].isNotEmpty
                              ? AppColors.primary
                              : Colors.grey.shade300),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: _verificationCode[index].isNotEmpty
                            ? Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: _codeExpired ? Colors.red.shade400 : Colors.black87,
                            shape: BoxShape.circle,
                          ),
                        )
                            : Container(),
                      ),
                    );
                  }),
                ),
                24.height,
                Center(
                  child: Column(
                    children: [
                      if (_countdownSeconds > 0) ...[
                        Text(
                          'Demander un nouveau code dans $_formattedCountdown',
                          style: AppTextStyles.body1.copyWith(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ] else ...[
                        // MODIFICATION: Afficher le bouton de renvoi quand le countdown est à 0
                        Text(
                          'Le code a expiré',
                          style: AppTextStyles.body1.copyWith(
                            fontSize: 14,
                            color: Colors.red.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        8.height,
                        TextButton(
                          onPressed: _generateVerificationCode,
                          child: Text(
                            'Renvoyer le code',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    height: 20,
                  ),
                ),
                // MODIFICATION: Désactiver le clavier si le code a expiré
                _buildCustomKeyboard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  Widget _buildCustomKeyboard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: _codeExpired ? Colors.grey.shade200 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildKeyboardButton('1'),
              _buildKeyboardButton('2'),
              _buildKeyboardButton('3'),
            ],
          ),
          Row(
            children: [
              _buildKeyboardButton('4'),
              _buildKeyboardButton('5'),
              _buildKeyboardButton('6'),
            ],
          ),
          Row(
            children: [
              _buildKeyboardButton('7'),
              _buildKeyboardButton('8'),
              _buildKeyboardButton('9'),
            ],
          ),
          Row(
            children: [
              Expanded(child: Container()),
              _buildKeyboardButton('0'),
              _buildKeyboardButton('×', isAction: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboardButton(String text, {bool isAction = false, Color? color}) {
    // MODIFICATION: Désactiver les boutons si le code a expiré
    bool isDisabled = _codeExpired;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        height: 48,
        child: Material(
          color: isDisabled
              ? Colors.grey.shade300
              : (isAction ? Colors.grey.shade300 : Colors.white),
          borderRadius: BorderRadius.circular(8),
          elevation: isAction ? 0 : 1,
          shadowColor: Colors.grey.withOpacity(0.2),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: isDisabled ? null : () => _handleKeyboardTap(text),
            child: Center(
              child: text == '×'
                  ? Icon(
                  Icons.backspace_outlined,
                  size: 20,
                  color: isDisabled ? Colors.grey.shade500 : Colors.black54
              )
                  : Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: isDisabled
                      ? Colors.grey.shade500
                      : (color ?? Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleKeyboardTap(String value) {
    // MODIFICATION: Ne pas permettre la saisie si le code a expiré
    if (_codeExpired) return;

    HapticFeedback.lightImpact();

    if (value == '×') {
      for (int i = 5; i >= 0; i--) {
        if (_verificationCode[i].isNotEmpty) {
          setState(() {
            _verificationCode[i] = '';
          });
          break;
        }
      }
    } else {
      for (int i = 0; i < 6; i++) {
        if (_verificationCode[i].isEmpty) {
          setState(() {
            _verificationCode[i] = value;
          });
          break;
        }
      }
    }
  }

  Widget _buildIdentityFormStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          32.height,
          Text(
            'Identité',
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          16.height,
          Text(
            'Veuillez entrer les informations de votre pièce pour procéder à une vérification',
            style: AppTextStyles.body1.copyWith(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          48.height,
          Text(
            'Nom',
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          8.height,
          TextField(
            controller: _lastNameController,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Entrez votre nom',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          24.height,
          Text(
            'Prénom',
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          8.height,
          TextField(
            controller: _firstNameController,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: 'Entrez votre prénom',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildContactInfoStep() {
    const outlineInputBorder = OutlineInputBorder();
    final borderRadius = outlineInputBorder.borderRadius;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          32.height,
          Text(
            'Démarrage',
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          16.height,
          Text(
            'Veuillez choisir votre pays et entrer votre numéro de téléphone pour démarrer',
            style: AppTextStyles.body1.copyWith(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          48.height,
          Text(
            'N° de téléphone',
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          8.height,
          Row(
            children: [
              GestureDetector(
                onTap: _openCountrySelection,
                child: Container(
                  width: 120,
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: borderRadius,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(selectedFlag, style: const TextStyle(fontSize: 20)),
                          4.width,
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
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    hintText: 'Ex: 0100045621',
                    border: OutlineInputBorder(),
                  ),
                  textFieldType: TextFieldType.NUMBER,
                  errorThisFieldRequired: "Saisir votre numéro de téléphone",
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          if (_phoneController.text.trim().isNotEmpty) ...[
            16.height,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.phone, size: 16, color: Colors.grey),
                  8.width,
                  Text(
                    'Numéro complet: $fullPhoneNumber',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVerificationInfoStep() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          32.height,
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.assignment_ind,
              size: 60,
              color: AppColors.primary,
            ),
          ),
          32.height,
          Text(
            'Vérification d\'identité',
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: 24,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          16.height,
          Text(
            'Nous allons procéder à une vérification automatique de votre identité.',
            style: AppTextStyles.body1.copyWith(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          32.height,
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.red.shade600, size: 20),
                    8.width,
                    Text(
                      'Vous pouvez utiliser:',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                12.height,
                _buildInfoItem('Pour les nationaux résidents :', 'CNI ; ou Permis de conduire Ivoirien.'),
                8.height,
                _buildInfoItem('Pour les nationaux non-résidents :', 'CNI ; ou Permis de conduire Ivoirien ; ou Passeport avec cachet d\'entrée de moins de 3 mois.'),
                8.height,
                _buildInfoItem('Pour les ressortissants CEDEAO :', 'Carte nationale d\'identité du pays d\'origine.'),
                8.height,
                _buildInfoItem('Pour les ressortissants Hors CEDEAO :', 'Passeport avec cachet d\'entrée de moins de 3 mois ; ou Carte de résident biométrique.'),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.red.shade700,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        4.height,
        Text(
          content,
          style: TextStyle(
            color: Colors.red.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  bool _isCurrentStepValid() {
    switch (_currentStep) {
      case 0:
        return _isStep3Valid(); // Contact info step
      case 1:
        return _isStep1Valid(); // Phone verification step
      case 2:
        return _isStep2Valid(); // Identity form step
      case 3:
        return true; // Info step, always valid
      default:
        return false;
    }
  }

  VoidCallback? _getButtonAction() {
    if (!_isCurrentStepValid()) return null;

    if (_currentStep == 3) {
      return () {
        print('Numéro de téléphone complet: $fullPhoneNumber');
        context.pushNamed(AppRoutes.identityVerificationInfoScreen);
      };
    } else {
      return _nextStep;
    }
  }

  String _getButtonText() {
    if (_currentStep == 0) {
      return 'Envoyer le code';
    } else {
      return 'Continuer';
    }
  }
}