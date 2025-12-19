import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/main.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

import 'candidature_eligibility_checker.dart';
import 'models/election_type.dart';

class CandidatureSelectionScreen extends StatefulWidget {
  const CandidatureSelectionScreen({super.key});

  @override
  State<CandidatureSelectionScreen> createState() => _CandidatureSelectionScreenState();
}

class _CandidatureSelectionScreenState extends State<CandidatureSelectionScreen> {
  List<ElectionType> availableElections = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAvailableElections();
  }

  Future<void> _loadAvailableElections() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      availableElections = [
        ElectionType(
          id: 'presidential_2025',
          type: 'president',
          title: 'Élection Présidentielle 2025',
          description: 'Candidature à la Présidence de la République de Côte d\'Ivoire',
          icon: Icons.account_balance,
          startDate: DateTime(2025, 1, 15),
          endDate: DateTime(2025, 3, 15),
          isOpen: true,
          color: Colors.blue,
        ),
        ElectionType(
          id: 'legislative_2025',
          type: 'depute',
          title: 'Élections Législatives 2025',
          description: 'Candidature à l\'Assemblée Nationale',
          icon: Icons.how_to_vote,
          startDate: DateTime(2025, 4, 1),
          endDate: DateTime(2025, 5, 30),
          isOpen: false,
          color: Colors.green,
        ),
        ElectionType(
          id: 'senatorial_2025',
          type: 'senateur',
          title: 'Élections Sénatoriales 2025',
          description: 'Candidature au Sénat de la République',
          icon: Icons.gavel,
          startDate: DateTime(2025, 6, 1),
          endDate: DateTime(2025, 7, 15),
          isOpen: false,
          color: Colors.purple,
        ),
        ElectionType(
          id: 'regional_2025',
          type: 'regional',
          title: 'Élections Régionales 2025',
          description: 'Candidature aux Conseils Régionaux',
          icon: Icons.location_city,
          startDate: DateTime(2025, 8, 1),
          endDate: DateTime(2025, 9, 15),
          isOpen: false,
          color: Colors.orange,
        ),
        ElectionType(
          id: 'municipal_2025',
          type: 'municipal',
          title: 'Élections Municipales 2025',
          description: 'Candidature aux Conseils Municipaux',
          icon: Icons.home_work,
          startDate: DateTime(2025, 10, 1),
          endDate: DateTime(2025, 11, 15),
          isOpen: false,
          color: Colors.teal,
        ),
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Elections disponibles',
          style: AppTextStyles.h3.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : availableElections.isEmpty
          ? _buildEmptyState()
          : _buildElectionsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.ballot_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          16.height,
          Text(
            'Aucune élection disponible',
            style: AppTextStyles.h3.copyWith(
              color: Colors.grey[600],
            ),
          ),
          8.height,
          Text(
            'Il n\'y a actuellement aucune élection ouverte aux candidatures',
            style: AppTextStyles.body2.copyWith(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildElectionsList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[700]),
                12.width,
                Expanded(
                  child: Text(
                    'Sélectionnez l\'élection pour laquelle vous souhaitez vous porter candidat',
                    style: AppTextStyles.body2.copyWith(
                      color: Colors.blue[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
          20.height,
          Text(
            'Elections ouvertes',
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          16.height,
          ...availableElections
              .where((election) => election.isOpen)
              .map((election) => _buildElectionCard(election))
              .toList(),

          if (availableElections.any((election) => !election.isOpen)) ...[
            20.height,
            Text(
              'Elections à venir',
              style: AppTextStyles.h3.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            16.height,
            ...availableElections
                .where((election) => !election.isOpen)
                .map((election) => _buildElectionCard(election))
                .toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildElectionCard(ElectionType election) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: election.isOpen
            ? Border.all(color: election.color.withOpacity(0.3))
            : Border.all(color: Colors.grey[300]!),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: election.isOpen ? () => _selectElection(election) : null,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: election.isOpen
                            ? election.color.withOpacity(0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        election.icon,
                        color: election.isOpen ? election.color : Colors.grey[500],
                        size: 28,
                      ),
                    ),
                    16.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            election.title,
                            style: AppTextStyles.h4.copyWith(
                              fontWeight: FontWeight.bold,
                              color: election.isOpen ? Colors.black : Colors.grey[600],
                            ),
                          ),
                          4.height,
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: election.isOpen
                                  ? Colors.green[100]
                                  : Colors.orange[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              election.isOpen ? 'Ouvert' : 'À venir',
                              style: TextStyle(
                                color: election.isOpen
                                    ? Colors.green[700]
                                    : Colors.orange[700],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (election.isOpen)
                      Icon(
                        Icons.arrow_forward_ios,
                        color: election.color,
                        size: 16,
                      ),
                  ],
                ),
                16.height,
                Text(
                  election.description,
                  style: AppTextStyles.body2.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                12.height,
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.grey[500],
                    ),
                    8.width,
                    Text(
                      'Candidatures: ${_formatDate(election.startDate)} - ${_formatDate(election.endDate)}',
                      style: AppTextStyles.body2.copyWith(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  void _selectElection(ElectionType election) {
    final enrollmentData = appStore.enrollmentData;

    if (enrollmentData == null) {
      _showEnrollmentRequiredDialog(election);
    } else {
      _checkElectionEligibility(election);
    }
  }

  void _showEnrollmentRequiredDialog(ElectionType election) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.gavel, color: Colors.orange),
              8.width,
              const Expanded(child: Text('Vérification légale requise')),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pour postuler à ${election.title}, vous devez d\'abord vérifier votre inscription sur la liste électorale.',
                style: AppTextStyles.body2,
              ),
              16.height,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.article, color: Colors.orange[700], size: 20),
                        8.width,
                        Text(
                          'Base légale',
                          style: AppTextStyles.body2.copyWith(
                            color: Colors.orange[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    8.height,
                    Text(
                      'Article 5 du Code Electoral:',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    4.height,
                    Text(
                      '"La qualité d\'électeur est constatée par l\'inscription sur une liste électorale. Cette inscription est de droit."',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.orange[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              12.height,
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                    8.width,
                    Expanded(
                      child: Text(
                        'Cette vérification confirme votre éligibilité selon les dispositions légales en vigueur.',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToEnrollmentVerification(election);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text(
                'Vérifier mon inscription',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToEnrollmentVerification(ElectionType election) {
    context.pushNamed(
      AppRoutes.candidatureEnrollmentVerificationScreen,
      extra: {
        'isAddLocation': false,
        'selectedElection': election,
        'returnToCandidature': true,
      },
    );
  }

  void _checkElectionEligibility(ElectionType election) {
    final enrollmentData = appStore.enrollmentData;
    final user = userStore.user;

    if (user == null) {
      _showErrorMessage('Données utilisateur non disponibles');
      return;
    }

    if (enrollmentData == null) {
      _showErrorMessage('Données d\'inscription non disponibles');
      return;
    }

    final result = CandidatureEligibilityChecker.checkEligibility(
      enrollmentData: enrollmentData,
      user: user,
      candidatureType: election.type,
    );

    if (result.isEligible) {
      _proceedToFaceVerification(election);
    } else {
      CandidatureEligibilityChecker.showIneligibilityDialog(
        context,
        result,
        election.type,
      );
    }
  }

  void _proceedToFaceVerification(ElectionType election) {
    context.pushNamed(
      AppRoutes.faceVerificationScreen,
      extra: {
        'election': election,
        'enrollmentData': appStore.enrollmentData,
      },
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            8.width,
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}