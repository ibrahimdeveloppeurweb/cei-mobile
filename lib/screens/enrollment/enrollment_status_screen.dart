import 'package:cei_mobile/core/constants/app_constants.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

class EnrollmentStatusScreen extends StatefulWidget {
  const EnrollmentStatusScreen({super.key});

  @override
  State<EnrollmentStatusScreen> createState() => _EnrollmentStatusScreenState();
}

class _EnrollmentStatusScreenState extends State<EnrollmentStatusScreen> {
  String? _referenceNumber;
  String _enrollmentStatus = 'En cours de traitement';
  List<Map<String, dynamic>> _statusHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEnrollmentData();
  }

  Future<void> _loadEnrollmentData() async {
    // Load the reference number from shared preferences
    _referenceNumber = getStringAsync(AppConstants.enrollmentReferenceNumberKey);

    // Simulate loading status data from server
    await Future.delayed(const Duration(seconds: 1));

    // Mock data for status history
    _statusHistory = [
      {
        'status': 'Soumission',
        'description': 'Votre demande a été soumise avec succès',
        'date': DateTime.now().subtract(const Duration(days: 2)),
        'completed': true
      },
      {
        'status': 'Vérification',
        'description': 'Vérification des documents et informations',
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'completed': true
      },
      {
        'status': 'Traitement',
        'description': 'Votre demande est en cours de traitement',
        'date': DateTime.now(),
        'completed': false
      },
      {
        'status': 'Validation',
        'description': 'Validation finale de votre inscription',
        'date': null,
        'completed': false
      },
      {
        'status': 'Complet',
        'description': 'Inscription validée et carte d\'électeur disponible',
        'date': null,
        'completed': false
      },
    ];

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} à ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statut de mon enrôlement'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Suivi de votre demande',
              style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold),
            ),
            16.height,

            // Status timeline
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _statusHistory.length,
              itemBuilder: (context, index) {
                final status = _statusHistory[index];
                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1,
                  isFirst: index == 0,
                  isLast: index == _statusHistory.length - 1,
                  indicatorStyle: IndicatorStyle(
                    width: 20,
                    color: status['completed'] ? AppColors.success : Colors.grey[300]!,
                    iconStyle: IconStyle(
                      color: Colors.white,
                      iconData: status['completed'] ? Icons.check : Icons.square,
                      fontSize: 12,
                    ),
                  ),
                  beforeLineStyle: LineStyle(
                    color: status['completed'] ? AppColors.success : Colors.grey[300]!,
                  ),
                  afterLineStyle: LineStyle(
                    color: index < _statusHistory.length - 1 && _statusHistory[index + 1]['completed']
                        ? AppColors.success
                        : Colors.grey[300]!,
                  ),
                  endChild: Container(
                    margin: const EdgeInsets.only(left: 16, right: 10, top: 16, bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              status['status'],
                              style: AppTextStyles.h4.copyWith(
                                fontWeight: FontWeight.bold,
                                color: status['completed'] ? AppColors.primary : AppColors.textPrimary,
                              ),
                            ),
                            if (status['date'] != null)
                              Flexible(
                                child: Text(
                                  _formatDate(status['date']),
                                  style: AppTextStyles.body2.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                        8.height,
                        Text(
                          status['description'],
                          style: AppTextStyles.body2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            24.height,
            // Reference number card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First row with reference number label and status
                  Row(
                    children: [
                      Text(
                        'Numéro de référence',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  // Second row with the actual reference number
                  Text(
                    _referenceNumber ?? 'N/A',
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Status row as its own dedicated row
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.sync,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        6.width,
                        Flexible(
                          child: Text(
                            'STATUT: $_enrollmentStatus',
                            style: AppTextStyles.button.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Submission date row
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 16, color: AppColors.textSecondary),
                      8.width,
                      Text(
                        'Soumis le: ${_statusHistory.isNotEmpty ? _formatDate(_statusHistory[0]['date']) : 'N/A'}',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            24.height,

            // Personal information card
            _buildInformationCard(
              'Informations personnelles',
              Icons.person,
              [
                {'label': 'Nom', 'value': enrollmentStore.lastName},
                {'label': 'Prénom', 'value': enrollmentStore.firstName},
                {'label': 'Genre', 'value': enrollmentStore.gender ?? 'N/A'},
                {'label': 'Téléphone', 'value': enrollmentStore.phoneNumber},
                {'label': 'Email', 'value': enrollmentStore.email},
              ],
            ),

            16.height,

            // Address information card
            _buildInformationCard(
              'Adresse',
              Icons.location_on,
              [
                {'label': 'Adresse', 'value': enrollmentStore.address},
                {'label': 'Ville', 'value': enrollmentStore.addressCity ?? 'N/A'},
                {'label': 'Commune', 'value': enrollmentStore.addressCommune ?? 'N/A'},
                {'label': 'Quartier', 'value': enrollmentStore.addressQuarter ?? 'N/A'},
              ],
            ),

            16.height,

            // Enrollment center card
            _buildInformationCard(
              'Centre d\'enrôlement',
              Icons.location_city,
              [
                {'label': 'Centre', 'value': enrollmentStore.enrollmentCenter?.name ?? 'N/A'},
                {'label': 'District', 'value': enrollmentStore.district?.name ?? 'N/A'},
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInformationCard(String title, IconData icon, List<Map<String, String>> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primary),
              8.width,
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyles.h4.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    '${item['label']}:',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item['value'] ?? 'N/A',
                    style: AppTextStyles.body1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }
}