
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';


class CreditFefAssistantPinScreen extends StatefulWidget {
  const CreditFefAssistantPinScreen({super.key});

  @override
  State<CreditFefAssistantPinScreen> createState() => _CreditFefAssistantPinScreenState();
}

class _CreditFefAssistantPinScreenState extends State<CreditFefAssistantPinScreen> {
  String _pinCode = '';
  final int _maxPinLength = 4;

  void _onNumberPressed(String number) {
    if (_pinCode.length < _maxPinLength) {
      setState(() {
        _pinCode += number;
      });

      // Vérifier si le PIN est complet
      if (_pinCode.length == _maxPinLength) {
        _validatePin();
      }
    }
  }

  void _onDeletePressed() {
    if (_pinCode.isNotEmpty) {
      setState(() {
        _pinCode = _pinCode.substring(0, _pinCode.length - 1);
      });
    }
  }

  void _validatePin() {
    // Vérification du PIN - vous pouvez personnaliser cette logique
    if (_pinCode == "1234") { // PIN exemple
      print('PIN correct: $_pinCode');
      // Navigation vers l'écran suivant
      context.pushNamed(AppRoutes.accueilScreen);
      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Authentification réussie !'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      print('PIN incorrect: $_pinCode');
      // Réinitialiser le PIN après un délai
      Future.delayed(Duration(milliseconds: 500), () {
        setState(() {
          _pinCode = '';
        });
      });

      // Afficher un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Code incorrect. Veuillez réessayer.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _onForgotPressed() {
    // Action pour "Oublié?"
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('PIN oublié'),
          content: Text(
            'Contactez votre conseiller ou utilisez les options de récupération disponibles dans l\'application.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Fermer'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Ici vous pouvez naviguer vers un écran de récupération
                // context.pushNamed(AppRoutes.pinRecovery);
              },
              child: Text('Récupérer'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPinDot(int index) {
    bool isFilled = index < _pinCode.length;
    // Taille adaptative pour les points
    double dotSize = MediaQuery.of(context).size.width < 350 ? 14 : 16;

    return Container(
      width: dotSize,
      height: dotSize,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? Colors.white : Colors.white.withOpacity(0.3),
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 1,
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    // Taille adaptative pour les boutons
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonSize = screenWidth < 350 ? 65 : (screenWidth < 400 ? 70 : 80);
    double fontSize = screenWidth < 350 ? 28 : (screenWidth < 400 ? 30 : 32);

    return GestureDetector(
      onTap: () => _onNumberPressed(number),
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialButton({
    required Widget child,
    required VoidCallback onTap,
  }) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonSize = screenWidth < 350 ? 65 : (screenWidth < 400 ? 70 : 80);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Center(child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 700;

    // Espacements adaptatifs
    double topSpacing = isSmallScreen ? 40 : 80;
    double titleSpacing = isSmallScreen ? 12 : 16;
    double pinSpacing = isSmallScreen ? 24 : 32;
    double keyboardSpacing = isSmallScreen ? 40 : 60;

    // Tailles de police adaptatives
    double titleFontSize = screenWidth < 350 ? 20 : 24;
    double subtitleFontSize = screenWidth < 350 ? 16 : 18;
    double logoFontSize = screenWidth < 350 ? 16 : 18;

    return Scaffold(
      backgroundColor: Color(0xFF070b3b),
    //  floatingActionButtonLocation: ExpandableFab.location,
     // floatingActionButton: FloatButtomActionWidjet(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth < 350 ? 16 : 24,
                vertical: isSmallScreen ? 16 : 24,
              ),
              child: Column(
                children: [
                  // Logo AFG avec taille adaptative
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth < 350 ? 16 : 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: screenWidth < 350 ? 20 : 24,
                          height: screenWidth < 350 ? 20 : 24,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green, Colors.orange, Colors.red],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: screenWidth < 350 ? 6 : 8),
                        Text(
                          'CREDIT FEF',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: logoFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                      ],
                    ),
                  ),

                  SizedBox(height: topSpacing),

                  // Message de bienvenue
                  Text(
                    'Bienvenue IBRAHIM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: titleSpacing),

                  // Instruction pour le code secret
                  Text(
                    'Entrez votre code secret',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: subtitleFontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: pinSpacing),

                  // Indicateurs de PIN (points)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _maxPinLength,
                          (index) => _buildPinDot(index),
                    ),
                  ),

                  SizedBox(height: keyboardSpacing),

                  // Clavier numérique avec espacement adaptatif
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: screenHeight * 0.45, // Limite la hauteur du clavier
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Première ligne: 5, 6, 4
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildNumberButton('5'),
                              _buildNumberButton('6'),
                              _buildNumberButton('4'),
                            ],
                          ),
                        ),

                        // Deuxième ligne: 8, 9, 7
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildNumberButton('8'),
                              _buildNumberButton('9'),
                              _buildNumberButton('7'),
                            ],
                          ),
                        ),

                        // Troisième ligne: 1, 2, 3
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildNumberButton('1'),
                              _buildNumberButton('2'),
                              _buildNumberButton('3'),
                            ],
                          ),
                        ),

                        // Quatrième ligne: Oublié?, 0, Delete
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildSpecialButton(
                                onTap: _onForgotPressed,
                                child: Text(
                                  'Oublié?',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: screenWidth < 350 ? 14 : 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              _buildNumberButton('0'),
                              _buildSpecialButton(
                                onTap: _onDeletePressed,
                                child: Icon(
                                  Icons.backspace_outlined,
                                  color: _pinCode.isNotEmpty
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.3),
                                  size: screenWidth < 350 ? 24 : 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: isSmallScreen ? 10 : 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}