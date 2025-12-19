import 'package:cei_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

import 'candidature_face_screen.dart';
import 'candidature_verification_screen.dart';
// Import your other screens here
// import 'candidature_election_screen.dart';
// import 'candidature_step1_screen.dart';
// etc.

class CandidatureScreen extends StatefulWidget {
  const CandidatureScreen({Key? key}) : super(key: key);

  @override
  _CandidatureScreenState createState() => _CandidatureScreenState();
}

class _CandidatureScreenState extends State<CandidatureScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    candidatureStore.loadSavedCandidatureData().then((_) {
      _pageController.jumpToPage(candidatureStore.currentStep);
      setState(() {

      });
    });
  }

  

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            GoRouter.of(context).pop(true);
          },
        ),
        title:  Observer(builder: (obs)=> Text(_getAppBarTitle(candidatureStore.currentStep))),
      ),
      body: Observer(
        builder: (BuildContext context) {
          if (_pageController.hasClients &&
              _pageController.page?.round() != candidatureStore.currentStep) {
            _pageController.animateToPage(
              candidatureStore.currentStep,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }

          return PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Disable swiping
            onPageChanged: (index) {
              candidatureStore.goToStep(index);
            },
            children: const [
              CandidatureVerificationScreen(),
              CandidatureFaceScreen(),
            ],
          );
        },
      ),
    );
  }

  String _getAppBarTitle(int step) {
    // Return title based on current step
    switch (step) {
      case 0:
        return 'Vérification d\'enrôlement';
      case 1:
        return 'Vérification d\'identité';
      case 2:
        return 'Sélection d\'élection';
      case 3:
        return 'Informations personnelles';
      case 4:
        return 'Informations familiales';
      case 5:
        return 'Documents d\'identité';
      case 6:
        return 'Pièces administratives';
      case 7:
        return 'Détails de candidature';
      case 8:
        return 'Récapitulatif';
      default:
        return 'Candidature';
    }
  }

  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quitter la candidature?'),
          content: const Text(
            'Votre progression est automatiquement sauvegardée. Vous pourrez reprendre plus tard.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                GoRouter.of(context).pop(); // Close the candidature screen
              },
              child: const Text('Quitter'),
            ),
          ],
        );
      },
    );
  }
}