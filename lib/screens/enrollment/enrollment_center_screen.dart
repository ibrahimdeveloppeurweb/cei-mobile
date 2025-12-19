import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/repository/voter_center_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

// Add these imports based on your project structure

class EnrollmentCenterScreen extends StatefulWidget {
  final int centerId;
  const EnrollmentCenterScreen({super.key, required this.centerId});

  @override
  State<EnrollmentCenterScreen> createState() => _EnrollmentCenterScreenState();
}

class _EnrollmentCenterScreenState extends State<EnrollmentCenterScreen> {
  GoogleMapController? _mapController;
  bool isFavorite = false;
  late Future<CentreModel> _centerFuture;

  @override
  void initState() {
    super.initState();
    _centerFuture = _fetchEnrollmentCenter(widget.centerId);
  }

  Future<CentreModel> _fetchEnrollmentCenter(int centerId) async {
    //try {
      final result = await getEnrolmentCenter(centerId);

      if (result != null && result != null) {
        return CentreModel.fromJson(result);
      } else {
        throw Exception('No data found for this center');
      }
    // } catch (e) {
    //   throw Exception('Failed to load enrollment center: ${e.toString()}');
    // }
  }

  // Get formatted address from center model
  String _getFullAddress(CentreModel center) {
    List<String?> addressParts = [];

    if (center.rue?.isNotEmpty == true) addressParts.add(center.rue);
    if (center.avenue?.isNotEmpty == true) addressParts.add(center.avenue);
    if (center.quartier?.isNotEmpty == true) addressParts.add(center.quartier);
    if (center.commune?.name?.isNotEmpty == true) addressParts.add(center.commune?.name);
    if (center.sousPrefecture?.name?.isNotEmpty == true) addressParts.add(center.sousPrefecture?.name);

    return addressParts.where((part) => part != null && part.isNotEmpty).join(", ");
  }

  // Get center location for the map
  LatLng _getCoordinates(CentreModel center) {
    // In a real app, you would get coordinates from the API
    // For now, use default coordinates for Gagnoa, Côte d'Ivoire if no coordinates in API
    return const LatLng(5.317592, -4.019501);
  }

  // Get district and region info
  String _getRegionInfo(CentreModel center) {
    List<String?> locationParts = [];

    if (center.district?.name?.isNotEmpty == true) locationParts.add(center.district?.name);
    if (center.region?.name?.isNotEmpty == true) locationParts.add(center.region?.name);
    if (center.departement?.name?.isNotEmpty == true) locationParts.add(center.departement?.name);

    return locationParts.where((part) => part != null && part.isNotEmpty).join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Mon centre d\'enrôlement', style: AppTextStyles.h3.copyWith(color: AppColors.accent)),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<CentreModel>(
        future: _centerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: AppColors.error),
                  const SizedBox(height: 16),
                  const Text(
                    'Impossible de charger les informations du centre',
                    style: AppTextStyles.body1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      setState(() {
                        _centerFuture = _fetchEnrollmentCenter(widget.centerId);
                      });
                    },
                    child: const Text('Réessayer', style: AppTextStyles.button),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final center = snapshot.data!;
            final coordinates = _getCoordinates(center);
            final address = _getFullAddress(center);

            // Create markers set for the map
            final Set<Marker> markers = {
              Marker(
                markerId: const MarkerId('enrollment_center'),
                position: coordinates,
                infoWindow: InfoWindow(
                  title: center.name ?? 'Centre d\'enrôlement',
                  snippet: address,
                ),
              ),
            };

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Map section with Google Maps
                  Container(
                    height: 300,
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey3.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: coordinates,
                        zoom: 15.0,
                      ),
                      markers: markers,
                      mapType: MapType.normal,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                    ),
                  ),

                  // Center details card
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey2.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
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
                            Expanded(
                              child: Text(
                                center.name ?? 'Centre d\'enrôlement',
                                style: AppTextStyles.h4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.success.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Ouvert', // This could be dynamic if API provides status
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // You could show distance if available from API
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.location_on_outlined, address),

                        // Show region info if available
                        if (_getRegionInfo(center).isNotEmpty) ...[
                          const SizedBox(height: 12),
                          _buildInfoRow(Icons.map_outlined, _getRegionInfo(center)),
                        ],

                        const SizedBox(height: 12),
                        if (center.id != null) Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.location_on,
                                  size: 18, color: AppColors.primary),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'Bureau de vote #${appStore.bureauDeVoteNumber.validate()}',
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Actions section
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Actions',
                          style: AppTextStyles.h4,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildActionButton(
                              Icons.directions,
                              'Itinéraire',
                                  () {
                                // Open directions in map app
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Ouverture des directions...',
                                      style: AppTextStyles.body2.copyWith(color: AppColors.accent),
                                    ),
                                    backgroundColor: AppColors.secondary,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                            _buildActionButton(
                              Icons.share_outlined,
                              'Partager',
                                  () {
                                // Share center information
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Partage du centre...',
                                      style: AppTextStyles.body2.copyWith(color: AppColors.accent),
                                    ),
                                    backgroundColor: AppColors.secondary,
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Services section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Services disponibles',
                          style: AppTextStyles.h4,
                        ),
                        const SizedBox(height: 12),
                        _buildServiceItem(Icons.credit_card_outlined, 'Carte d\'électeur'),
                        const SizedBox(height: 8),
                        _buildServiceItem(Icons.help_outline, "Demande d'assistance"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            // No data case
            return const Center(
              child: Text('Aucune information disponible pour ce centre'),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.grey4, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.body2,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.secondary, size: 20),
        const SizedBox(width: 12),
        Text(
          text,
          style: AppTextStyles.body2,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

// Model class for enrollment center data
class CentreModel {
  final int? id;
  final String? name;
  final String? rue;
  final String? localisation;
  final String? avenue;
  final String? quartier;
  final DistrictModel? district;
  final RegionModel? region;
  final DepartementModel? departement;
  final SousPrefectureModel? sousPrefecture;
  final CommuneModel? commune;
  final VillageModel? village;

  CentreModel({
    this.id,
    this.name,
    this.rue,
    this.localisation,
    this.avenue,
    this.quartier,
    this.district,
    this.region,
    this.departement,
    this.sousPrefecture,
    this.commune,
    this.village,
  });

  factory CentreModel.fromJson(Map<String, dynamic> json) {
    return CentreModel(
      id: json['id'],
      name: json['name'],
      rue: json['rue'],
      localisation: json['localisation'],
      avenue: json['avenue'],
      quartier: json['quartier'],
      district: json['district'] != null ? DistrictModel.fromJson(json['district']) : null,
      region: json['region'] != null ? RegionModel.fromJson(json['region']) : null,
      departement: json['departement'] != null ? DepartementModel.fromJson(json['departement']) : null,
      sousPrefecture: json['sousPrefecture'] != null ? SousPrefectureModel.fromJson(json['sousPrefecture']) : null,
      commune: json['commune'] != null ? CommuneModel.fromJson(json['commune']) : null,
      village: json['village'] != null ? VillageModel.fromJson(json['village']) : null,
    );
  }
}

// Nested model classes
class DistrictModel {
  final int? id;
  final String? name;

  DistrictModel({this.id, this.name});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class RegionModel {
  final int? id;
  final String? name;

  RegionModel({this.id, this.name});

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class DepartementModel {
  final int? id;
  final String? name;

  DepartementModel({this.id, this.name});

  factory DepartementModel.fromJson(Map<String, dynamic> json) {
    return DepartementModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class SousPrefectureModel {
  final int? id;
  final String? name;

  SousPrefectureModel({this.id, this.name});

  factory SousPrefectureModel.fromJson(Map<String, dynamic> json) {
    return SousPrefectureModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CommuneModel {
  final int? id;
  final String? name;

  CommuneModel({this.id, this.name});

  factory CommuneModel.fromJson(Map<String, dynamic> json) {
    return CommuneModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class VillageModel {
  final int? id;
  final String? name;

  VillageModel({this.id, this.name});

  factory VillageModel.fromJson(Map<String, dynamic> json) {
    return VillageModel(
      id: json['id'],
      name: json['name'],
    );
  }
}