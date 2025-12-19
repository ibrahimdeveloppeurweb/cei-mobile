import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'election_result_screen.dart';
import 'election_selection_screen.dart';

class ElectionResultsScreen extends StatefulWidget {
  final ElectionItem election;

  const ElectionResultsScreen({required this.election, super.key});

  @override
  State<ElectionResultsScreen> createState() => _ElectionResultsScreenState();
}

class _ElectionResultsScreenState extends State<ElectionResultsScreen> {
  // State variables
  bool _isLoading = false;
  late DateFormat _dateFormat;

  // Main candidates data
  List<Map<String, dynamic>> _mainCandidates = [];

  // Other candidates data
  List<Map<String, dynamic>> _otherCandidates = [];

  // Election stats
  Map<String, dynamic> _stats = {};

  @override
  void initState() {
    super.initState();
    _initializeLocaleData();
  }

  Future<void> _initializeLocaleData() async {
    // Initialize date formatting for French locale
    await initializeDateFormatting('fr_FR', null);
    _dateFormat = DateFormat('dd MMMM yyyy', 'fr_FR');
    _loadElectionResults();
  }

  // Load election results data (would connect to API in a real app)
  Future<void> _loadElectionResults() async {
    setState(() => _isLoading = true);

    try {
      // In a real app, you would fetch data from an API here based on widget.election.id
      await Future.delayed(const Duration(seconds: 2));

      // Different mock data based on election type
      if (widget.election.type == 'Présidentielle') {
        _mainCandidates = [
          {
            'name': 'Alassane Ouattara',
            'votes': 8765400,
            'percentage': 86.5,
            'color': const Color(0xFF2E8B57), // SeaGreen
            'image': AssetConstants.ado, // Replace with actual candidate image
          },
          {
            'name': 'Henri Konan Bédié',
            'votes': 1765400,
            'percentage': 13.5,
            'color': const Color(0xFFCD853F), // Peru
            'image': AssetConstants.bedie, // Replace with actual candidate image
          },
        ];

        _otherCandidates = [
          {
            'name': 'Kouassi Kouassi Ghislain',
            'votes': 564678,
            'votingCenters': 78,
            'percentage': 69,
            'image': AssetConstants.homeslide1, // Replace with actual candidate image
          },
          {
            'name': 'Fatoumata Mangoua',
            'votes': 472100,
            'votingCenters': 70,
            'percentage': 70,
            'image': AssetConstants.homeslide1, // Replace with actual candidate image
          },
          {
            'name': 'Diarra Kalilou',
            'votes': 451098,
            'votingCenters': 73,
            'percentage': 7,
            'image': AssetConstants.homeslide1, // Replace with actual candidate image
          },
          {
            'name': 'Bamba Karim',
            'votes': 389012,
            'votingCenters': 67,
            'percentage': 11,
            'image': AssetConstants.homeslide1, // Replace with actual candidate image
          },
          {
            'name': 'Koulibaly Jean',
            'votes': 385600,
            'votingCenters': 69,
            'percentage': 65,
            'image': AssetConstants.homeslide1, // Replace with actual candidate image
          },
          {
            'name': 'Amara Diabaté',
            'votes': 349210,
            'votingCenters': 65,
            'percentage': 65,
            'image': AssetConstants.homeslide1, // Replace with actual candidate image
          },
        ];
      } else if (widget.election.type == 'Législative') {
        // Different data for legislative elections
        _mainCandidates = [
          {
            'name': 'RHDP',
            'votes': 3765400,
            'percentage': 54.2,
            'color': const Color(0xFF2E8B57), // SeaGreen
            'image': AssetConstants.homeslide1, // Replace with actual party logo
          },
          {
            'name': 'PDCI-RDA',
            'votes': 2865400,
            'percentage': 45.8,
            'color': const Color(0xFFCD853F), // Peru
            'image': AssetConstants.homeslide2, // Replace with actual party logo
          },
        ];

        _otherCandidates = [
          {
            'name': 'FPI',
            'votes': 864678,
            'votingCenters': 103,
            'percentage': 32,
            'image': AssetConstants.homeslide1, // Replace with actual party logo
          },
          {
            'name': 'PPA-CI',
            'votes': 672100,
            'votingCenters': 95,
            'percentage': 28,
            'image': AssetConstants.homeslide1, // Replace with actual party logo
          },
          {
            'name': 'UDPCI',
            'votes': 351098,
            'votingCenters': 65,
            'percentage': 17,
            'image': AssetConstants.homeslide1, // Replace with actual party logo
          },
          {
            'name': 'MFA',
            'votes': 289012,
            'votingCenters': 47,
            'percentage': 12,
            'image': AssetConstants.homeslide1, // Replace with actual party logo
          },
        ];
      } else {
        // Generic data for other election types
        _mainCandidates = [
          {
            'name': 'Candidat A',
            'votes': 2765400,
            'percentage': 65.3,
            'color': const Color(0xFF2E8B57), // SeaGreen
            'image': AssetConstants.homeslide1, // Replace with actual image
          },
          {
            'name': 'Candidat B',
            'votes': 1465400,
            'percentage': 34.7,
            'color': const Color(0xFFCD853F), // Peru
            'image': AssetConstants.homeslide2, // Replace with actual image
          },
        ];

        _otherCandidates = [
          {
            'name': 'Candidat C',
            'votes': 364678,
            'votingCenters': 58,
            'percentage': 25,
            'image': AssetConstants.homeslide1, // Replace with actual image
          },
          {
            'name': 'Candidat D',
            'votes': 272100,
            'votingCenters': 42,
            'percentage': 19,
            'image': AssetConstants.homeslide1, // Replace with actual image
          },
          {
            'name': 'Candidat E',
            'votes': 151098,
            'votingCenters': 35,
            'percentage': 10,
            'image': AssetConstants.homeslide1, // Replace with actual image
          },
        ];
      }

      // Use the participation rate from the selected election
      _stats = {
        'participationRate': widget.election.turnout,
        'totalVoters': 18998456, // This would come from the API
      };
    } catch (e) {
      toast('Erreur lors du chargement des résultats: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Format large numbers with spaces
  String _formatNumber(int num) {
    return num.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ');
  }

  // Build the main results section - FIXED OVERFLOW
  Widget _buildMainResults() {
    final firstCandidate = _mainCandidates[0];
    final secondCandidate = _mainCandidates[1];

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Candidates and participation info - FIXED LAYOUT
          Row(
            children: [
              // First candidate - FLEXIBLE
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: firstCandidate['color'],
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(firstCandidate['image']),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      firstCandidate['name'],
                      style: AppTextStyles.body2.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      child: Text(
                        _formatNumber(firstCandidate['votes']),
                        style: AppTextStyles.h4.copyWith(
                          color: firstCandidate['color'],
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Participation info - FLEXIBLE
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Text(
                      "Taux de participation",
                      style: AppTextStyles.body2.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    Text(
                      "${_stats['participationRate']}%",
                      style: AppTextStyles.h3.copyWith(
                        color: const Color(0xFFE67E22),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Nombre de votant",
                      style: AppTextStyles.body2.copyWith(
                        color: Colors.grey.shade600,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    FittedBox(
                      child: Text(
                        _formatNumber(_stats['totalVoters']),
                        style: AppTextStyles.body1.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Second candidate - FLEXIBLE
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: secondCandidate['color'],
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(secondCandidate['image']),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      secondCandidate['name'],
                      style: AppTextStyles.body2.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      child: Text(
                        _formatNumber(secondCandidate['votes']),
                        style: AppTextStyles.h4.copyWith(
                          color: secondCandidate['color'],
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Percentage bar
          const SizedBox(height: 16),
          Container(
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade200,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: (firstCandidate['percentage'] * 100).toInt(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: firstCandidate['color'],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: (secondCandidate['percentage'] * 100).toInt(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: secondCandidate['color'],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Vote counts and percentages - FIXED OVERFLOW
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${_formatNumber(firstCandidate['votes'])} votes (${firstCandidate['percentage']}%)",
                  style: AppTextStyles.body2.copyWith(fontSize: 10),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "${_formatNumber(secondCandidate['votes'])} votes (${secondCandidate['percentage']}%)",
                  style: AppTextStyles.body2.copyWith(fontSize: 10),
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build a card for each other candidate - FIXED OVERFLOW
  Widget _buildCandidateCard(Map<String, dynamic> candidate) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Candidate header with image and name - FIXED OVERFLOW
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(candidate['image']),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  candidate['name'],
                  style: AppTextStyles.body2.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Vote info - FIXED OVERFLOW
          FittedBox(
            child: Text(
              "Voix: ${_formatNumber(candidate['votes'])}",
              style: AppTextStyles.body2.copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            child: Text(
              "Votants: ${candidate['votingCenters']}",
              style: AppTextStyles.body2.copyWith(fontSize: 14),
            ),
          ),

          // Percentage indicator - FIXED OVERFLOW
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: candidate['percentage'] / 100,
                  backgroundColor: Colors.grey.shade200,
                  color: Colors.blue.shade400,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                "${candidate['percentage']}%",
                style: AppTextStyles.body2.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build the other candidates section
  Widget _buildOtherCandidates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Autres Candidats",
          style: AppTextStyles.h3.copyWith(
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        // FIXED GRID OVERFLOW
        LayoutBuilder(
          builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth > 600 ? 3 : 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.2,
              ),
              itemCount: _otherCandidates.length,
              itemBuilder: (context, index) {
                return _buildCandidateCard(_otherCandidates[index]);
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.election.type,
            style: const TextStyle(fontSize: 16),
          ),
          elevation: 0,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FIXED TITLE OVERFLOW
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFFE67E22),
                        width: 4,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 8),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PRÉSENTATION DES RÉSULTATS',
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          style: AppTextStyles.h3.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'ÉLECTIONS ${widget.election.type.toUpperCase()} ',
                            ),
                            TextSpan(
                              text: widget.election.date.year.toString(),
                              style: const TextStyle(
                                color: Color(0xFFE67E22),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Election description and date - FIXED OVERFLOW
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.election.description,
                        style: AppTextStyles.body1.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 14, color: Colors.grey),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              "Date: ${_dateFormat.format(widget.election.date)}",
                              style: AppTextStyles.body2.copyWith(fontSize: 11),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Main candidates results
                _buildMainResults(),

                // Other candidates
                _buildOtherCandidates(),

                // View more button

                const SizedBox(height: 20), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}