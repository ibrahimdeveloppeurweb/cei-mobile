import 'package:cei_mobile/core/constants/app_constants.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:go_router/go_router.dart';

class EnrollmentStatusDynamicScreen extends StatefulWidget {
  final EnrollmentData enrollmentData;

  const EnrollmentStatusDynamicScreen({
    super.key,
    required this.enrollmentData,
  });

  @override
  State<EnrollmentStatusDynamicScreen> createState() => _EnrollmentStatusDynamicScreenState();
}

class _EnrollmentStatusDynamicScreenState extends State<EnrollmentStatusDynamicScreen> {
  List<Map<String, dynamic>> _statusHistory = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _buildStatusHistory();
  }

  void _buildStatusHistory() {
    final enrollmentData = widget.enrollmentData;
    final apiStatus = enrollmentData.status?.toLowerCase();

    // Build status history based on API status values
    _statusHistory = [
      {
        'status': 'Soumission',
        'description': 'Votre demande a été soumise avec succès',
        'date': enrollmentData.dateEnrolement,
        'completed': enrollmentData.dateEnrolement != null
      },
      {
        'status': 'Vérification',
        'description': 'Vérification des documents et informations en cours',
        'date': _getVerificationDate(),
        'completed': _isVerificationCompleted()
      },
      {
        'status': 'Validation',
        'description': _getValidationDescription(),
        'date': _getValidationDate(),
        'completed': _isValidationCompleted(),
        'isRejected': apiStatus == 'rejete'
      },
      {
        'status': 'Finalisation',
        'description': 'Préparation de votre carte d\'électeur',
        'date': _getFinalizationDate(),
        'completed': _isFinalizationCompleted()
      },
      {
        'status': 'Complet',
        'description': 'Carte d\'électeur disponible pour retrait',
        'date': enrollmentData.deleveryDateCarte,
        'completed': false
      },
    ];

    setState(() {
      _isLoading = false;
    });
  }

  // Helper methods based on API status values
  DateTime? _getVerificationDate() {
    if (widget.enrollmentData.dateEnrolement != null) {
      // Verification starts immediately after submission
      return widget.enrollmentData.dateEnrolement!.add(const Duration(hours: 1));
    }
    return null;
  }

  bool _isVerificationCompleted() {
    final apiStatus = widget.enrollmentData.status?.toLowerCase();
    // Verification is completed if status is not null (any status means it passed verification)
    return apiStatus != null && apiStatus.isNotEmpty;
  }

  String _getValidationDescription() {
    final apiStatus = widget.enrollmentData.status?.toLowerCase();
    switch (apiStatus) {
      case 'en_attente':
        return 'Votre demande est en attente de validation finale';
      case 'valide':
        return 'Votre demande a été validée avec succès';
      case 'rejete':
        return 'Votre demande a été rejetée';
      default:
        return 'Validation en cours';
    }
  }

  DateTime? _getValidationDate() {
    final apiStatus = widget.enrollmentData.status?.toLowerCase();
    if (apiStatus == 'valide' && widget.enrollmentData.dateValidation != null) {
      return widget.enrollmentData.dateValidation;
    } else if (apiStatus == 'rejete') {
      // Assume rejection happened around the same time as validation would have
      return widget.enrollmentData.dateValidation ??
          (widget.enrollmentData.dateEnrolement?.add(const Duration(days: 1)));
    } else if (apiStatus == 'en_attente') {
      // For pending status, show when it reached this stage
      return widget.enrollmentData.dateEnrolement?.add(const Duration(hours: 2));
    }
    return null;
  }

  bool _isValidationCompleted() {
    final apiStatus = widget.enrollmentData.status?.toLowerCase();
    // Validation is completed if status is valide or rejete
    return apiStatus == 'valide' || apiStatus == 'rejete';
  }

  DateTime? _getFinalizationDate() {
    final apiStatus = widget.enrollmentData.status?.toLowerCase();
    if (apiStatus == 'valide' && widget.enrollmentData.dateValidation != null) {
      return widget.enrollmentData.dateValidation!.add(const Duration(days: 1));
    }
    return null;
  }

  bool _isFinalizationCompleted() {
    final apiStatus = widget.enrollmentData.status?.toLowerCase();
    return apiStatus == 'valide' && widget.enrollmentData.deleveryDateCarte == null;
  }

  String _getCurrentStatus() {
    final apiStatus = widget.enrollmentData.status?.toLowerCase();
    switch (apiStatus) {
      case 'en_attente':
        return 'En attente de validation';
      case 'valide':
        return widget.enrollmentData.deleveryDateCarte != null ? 'Carte disponible' : 'Validé';
      case 'rejete':
        return 'Rejeté';
      default:
        return 'En cours de traitement';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} à ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final enrollmentData = widget.enrollmentData;

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
                final isRejected = status['isRejected'] ?? false;

                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1,
                  isFirst: index == 0,
                  isLast: index == _statusHistory.length - 1,
                  indicatorStyle: IndicatorStyle(
                    width: 20,
                    color: isRejected
                        ? Colors.red
                        : (status['completed'] ? AppColors.success : Colors.grey[300]!),
                    iconStyle: IconStyle(
                      color: Colors.white,
                      iconData: isRejected
                          ? Icons.close
                          : (status['completed'] ? Icons.check : Icons.circle),
                      fontSize: 12,
                    ),
                  ),
                  beforeLineStyle: LineStyle(
                    color: isRejected
                        ? Colors.red
                        : (status['completed'] ? AppColors.success : Colors.grey[300]!),
                  ),
                  afterLineStyle: LineStyle(
                    color: isRejected
                        ? Colors.grey[300]!
                        : (index < _statusHistory.length - 1 && _statusHistory[index + 1]['completed']
                        ? AppColors.success
                        : Colors.grey[300]!),
                  ),
                  endChild: Container(
                    margin: const EdgeInsets.only(left: 16, right: 10, top: 16, bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: isRejected
                          ? Border.all(color: Colors.red.withOpacity(0.3))
                          : null,
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
                                color: isRejected
                                    ? Colors.red
                                    : (status['completed'] ? AppColors.primary : AppColors.textPrimary),
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
                          style: AppTextStyles.body2.copyWith(
                            color: isRejected ? Colors.red[700] : null,
                          ),
                        ),
                        // Show rejection reason if applicable
                        if (isRejected &&
                            enrollmentData.motifRejet != null &&
                            enrollmentData.motifRejet!.isNotEmpty) ...[
                          8.height,
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.red.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline,
                                    color: Colors.red, size: 16),
                                8.width,
                                Expanded(
                                  child: Text(
                                    'Motif du rejet: ${enrollmentData.motifRejet}',
                                    style: AppTextStyles.body2.copyWith(
                                      color: Colors.red[700],
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                color: _getStatusColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _getStatusColor().withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Reference number
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
                  Text(
                    enrollmentData.numOrder ?? enrollmentData.numForm ?? enrollmentData.numEnregister ?? 'N/A',
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Status
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor().withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(),
                          size: 16,
                          color: _getStatusColor(),
                        ),
                        6.width,
                        Flexible(
                          child: Text(
                            'STATUT: ${_getCurrentStatus()}',
                            style: AppTextStyles.button.copyWith(
                              color: _getStatusColor(),
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

                  // Submission date
                  if (enrollmentData.dateEnrolement != null) ...[
                    8.height,
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16, color: AppColors.textSecondary),
                        8.width,
                        Text(
                          'Soumis le: ${_formatDate(enrollmentData.dateEnrolement!)}',
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Validation date if available
                  if (enrollmentData.dateValidation != null) ...[
                    4.height,
                    Row(
                      children: [
                        Icon(
                            enrollmentData.status?.toLowerCase() == 'rejete'
                                ? Icons.cancel
                                : Icons.check_circle,
                            size: 16,
                            color: enrollmentData.status?.toLowerCase() == 'rejete'
                                ? Colors.red
                                : AppColors.success
                        ),
                        8.width,
                        Text(
                          enrollmentData.status?.toLowerCase() == 'rejete'
                              ? 'Rejeté le: ${_formatDate(enrollmentData.dateValidation!)}'
                              : 'Validé le: ${_formatDate(enrollmentData.dateValidation!)}',
                          style: AppTextStyles.body2.copyWith(
                            color: enrollmentData.status?.toLowerCase() == 'rejete'
                                ? Colors.red
                                : AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],

                  // Card info if available
                  if (enrollmentData.numCarte != null) ...[
                    4.height,
                    Row(
                      children: [
                        const Icon(Icons.credit_card, size: 16, color: AppColors.textSecondary),
                        8.width,
                        Text(
                          'N° Carte: ${enrollmentData.numCarte}',
                          style: AppTextStyles.body2.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            24.height,

            // Personal information card
            _buildInformationCard(
              'Informations personnelles',
              Icons.person,
              [
                {'label': 'Nom', 'value': enrollmentData.lastName},
                {'label': 'Prénom', 'value': enrollmentData.firstName},
                {'label': 'Genre', 'value': enrollmentData.gender},
                {'label': 'Date de naissance', 'value': enrollmentData.birthdate != null
                    ? _formatDate(enrollmentData.birthdate!) : null},
                {'label': 'Lieu de naissance', 'value': enrollmentData.birthplace},
                {'label': 'Profession', 'value': enrollmentData.profession},
              ],
            ),

            16.height,

            // Address information card
            _buildInformationCard(
              'Adresse',
              Icons.location_on,
              [
                {'label': 'Adresse', 'value': enrollmentData.address},
                {'label': 'Quartier', 'value': enrollmentData.quartier},
              ],
            ),

            16.height,

            // Parent information if available
            if (enrollmentData.lastNameFather != null || enrollmentData.lastNameMother != null)
              _buildInformationCard(
                'Informations parentales',
                Icons.family_restroom,
                [
                  if (enrollmentData.lastNameFather != null)
                    {'label': 'Nom du père', 'value': enrollmentData.lastNameFather},
                  if (enrollmentData.firstNameFather != null)
                    {'label': 'Prénom du père', 'value': enrollmentData.firstNameFather},
                  if (enrollmentData.birthdateFather != null)
                    {'label': 'Date naissance père', 'value': _formatDate(enrollmentData.birthdateFather!)},
                  if (enrollmentData.birthplaceFather != null)
                    {'label': 'Lieu naissance père', 'value': enrollmentData.birthplaceFather},
                  if (enrollmentData.lastNameMother != null)
                    {'label': 'Nom de la mère', 'value': enrollmentData.lastNameMother},
                  if (enrollmentData.firstNameMother != null)
                    {'label': 'Prénom de la mère', 'value': enrollmentData.firstNameMother},
                  if (enrollmentData.birthdateMother != null)
                    {'label': 'Date naissance mère', 'value': _formatDate(enrollmentData.birthdateMother!)},
                  if (enrollmentData.birthplaceMother != null)
                    {'label': 'Lieu naissance mère', 'value': enrollmentData.birthplaceMother},
                ],
              ),

            16.height,

            // Enrollment center card if available
            if (enrollmentData.centre != null)
              _buildInformationCard(
                'Centre d\'enrôlement',
                Icons.location_city,
                [
                  {'label': 'Centre', 'value': enrollmentData.centre?.name},
                  if (enrollmentData.centre?.district != null)
                    {'label': 'District', 'value': enrollmentData.centre?.district?.name},
                  if (enrollmentData.centre?.region != null)
                    {'label': 'Région', 'value': enrollmentData.centre?.region?.name},
                  if (enrollmentData.centre?.departement != null)
                    {'label': 'Département', 'value': enrollmentData.centre?.departement?.name},
                ],
              ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor() {
    final apiStatus = widget.enrollmentData.status?.toLowerCase();
    switch (apiStatus) {
      case 'valide':
        return AppColors.success;
      case 'rejete':
        return Colors.red;
      case 'en_attente':
        return Colors.orange;
      default:
        return AppColors.primary;
    }
  }

  IconData _getStatusIcon() {
    final apiStatus = widget.enrollmentData.status?.toLowerCase();
    switch (apiStatus) {
      case 'valide':
        return Icons.check_circle;
      case 'rejete':
        return Icons.cancel;
      case 'en_attente':
        return Icons.hourglass_empty;
      default:
        return Icons.sync;
    }
  }

  Widget _buildInformationCard(String title, IconData icon, List<Map<String, String?>> items) {
    // Filter out items with null or empty values
    final validItems = items.where((item) =>
    item['value'] != null && item['value']!.isNotEmpty).toList();

    if (validItems.isEmpty) {
      return const SizedBox.shrink();
    }

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
          ...validItems.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    '${item['label']}:',
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item['value']!,
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