import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:file_icon/file_icon.dart'; // Add the file_icon package

class ReclamationDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> reclamation;

  const ReclamationDetailsScreen({
    super.key,
    required this.reclamation,
  });

  @override
  State<ReclamationDetailsScreen> createState() => _ReclamationDetailsScreenState();
}

class _ReclamationDetailsScreenState extends State<ReclamationDetailsScreen> {
  // Mock attached files data
  final List<Map<String, dynamic>> _attachments = [
    {
      'name': 'Carte d\'identité.pdf',
      'size': '1.2 MB',
      'type': 'pdf',
    },
    {
      'name': 'Justificatif de domicile.jpg',
      'size': '845 KB',
      'type': 'jpg',
    },
    {
      'name': 'Formulaire_CE103.docx',
      'size': '532 KB',
      'type': 'docx',
    },
  ];

  // Timeline steps based on status
  List<Map<String, dynamic>> _getTimelineSteps() {
    final status = widget.reclamation['status'];
    final List<Map<String, dynamic>> steps = [
      {
        'title': 'Soumise',
        'date': widget.reclamation['date'],
        'description': 'Réclamation enregistrée',
        'isCompleted': true,
      },
      {
        'title': 'En traitement',
        'date': _getProcessingDate(),
        'description': 'Analyse par la commission',
        'isCompleted': status != 'En cours',
      },
      {
        'title': 'Décision',
        'date': _getDecisionDate(),
        'description': status == 'Traitée'
            ? 'Réclamation approuvée'
            : status == 'Rejetée'
            ? 'Réclamation rejetée'
            : 'En attente',
        'isCompleted': status == 'Traitée' || status == 'Rejetée',
      },
    ];
    return steps;
  }

  // Helper methods to generate mock dates
  String _getProcessingDate() {
    if (widget.reclamation['status'] == 'En cours') {
      return 'En cours';
    }

    // Get the submission date and add 5 days
    final parts = widget.reclamation['date'].split('/');
    if (parts.length != 5) return '';

    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    final submissionDate = DateTime(year, month, day);
    final processingDate = submissionDate.add(const Duration(days: 5));

    return '${processingDate.day.toString().padLeft(2, '0')}/${processingDate.month.toString().padLeft(2, '0')}/${processingDate.year}';
  }

  String _getDecisionDate() {
    if (widget.reclamation['status'] == 'En cours') {
      return 'En attente';
    }

    // Get the submission date and add 14 days
    final parts = widget.reclamation['date'].split('/');
    if (parts.length != 5) return '';

    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    final submissionDate = DateTime(year, month, day);
    final decisionDate = submissionDate.add(const Duration(days: 14));

    return '${decisionDate.day.toString().padLeft(2, '0')}/${decisionDate.month.toString().padLeft(2, '0')}/${decisionDate.year}';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'En cours':
        return Colors.blue;
      case 'Traitée':
        return Colors.green;
      case 'Rejetée':
        return Colors.red;
      default:
        return AppColors.textSecondary;
    }
  }

  IconData _getTypeIcon() {
    switch (widget.reclamation['type']) {
      case 'Inscription':
        return Icons.person_add_outlined;
      case 'Radiation':
        return Icons.person_remove_outlined;
      case 'Correction':
        return Icons.edit_outlined;
      default:
        return Icons.description_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final timelineSteps = _getTimelineSteps();

    return ScaffoldBgWidget(
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          elevation: 0,
          title: Text(
            'Détails de la réclamation',
            style: AppTextStyles.h2.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Timeline du traitement
                const Text(
                  'Suivi de la réclamation',
                  style: AppTextStyles.h3,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      for (int i = 0; i < timelineSteps.length; i++)
                        _buildTimelineStep(
                          timelineSteps[i],
                          isLast: i == timelineSteps.length - 1,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Récépissé en haut
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Récépissé',
                            style: AppTextStyles.body1.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(widget.reclamation['status']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              widget.reclamation['status'],
                              style: AppTextStyles.caption.copyWith(
                                color: _getStatusColor(widget.reclamation['status']),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.reclamation['id'],
                        style: AppTextStyles.h3.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            _getTypeIcon(),
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Type: ',
                            style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
                          ),
                          Text(
                            widget.reclamation['type'],
                            style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            FluentIcons.calendar_20_filled,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Date de soumission: ',
                            style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
                          ),
                          Text(
                            widget.reclamation['date'],
                            style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            FluentIcons.location_20_filled,
                            color: AppColors.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Centre: ',
                            style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
                          ),
                          Expanded(
                            child: Text(
                              widget.reclamation['center'],
                              style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Détails de la réclamation
                Text(
                  'Détails',
                  style: AppTextStyles.h3,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personne concernée',
                        style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.reclamation['concernedPerson'],
                        style: AppTextStyles.body1.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Motif de la réclamation',
                        style: AppTextStyles.body2.copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.reclamation['justification'],
                        style: AppTextStyles.body1,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Pièces jointes section
                Text(
                  'Pièces jointes',
                  style: AppTextStyles.h3,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: _attachments.map((attachment) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: SizedBox(
                            width: 40,
                            height: 40,
                            child: FileIcon(
                              attachment['type'],
                              size: 40,
                            ),
                          ),
                          title: Text(
                            attachment['name'],
                            style: AppTextStyles.body2.copyWith(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            attachment['size'],
                            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.download_outlined, color: AppColors.primary),
                            onPressed: () {
                              toast('Téléchargement démarré');
                            },
                          ),
                          onTap: () {
                            toast('Aperçu du fichier');
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineStep(Map<String, dynamic> step, {required bool isLast}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: step['isCompleted'] ? AppColors.primary : Colors.grey[300],
              ),
              child: step['isCompleted']
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 50,
                color: step['isCompleted'] ? AppColors.primary : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    step['title'],
                    style: AppTextStyles.body1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: step['isCompleted'] ? AppColors.textPrimary : AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    step['date'],
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                step['description'],
                style: AppTextStyles.body2.copyWith(
                  color: step['isCompleted'] ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}