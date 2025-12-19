import 'package:cei_mobile/common_widgets/app_logo.dart';
import 'package:cei_mobile/common_widgets/indicator_dot.dart';
import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/model/user/user_model.dart';
import 'package:cei_mobile/repository/common_repos.dart';
import 'package:cei_mobile/repository/voter_center_repository.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';

class EnrollmentStep5Screen extends StatefulWidget {
  const EnrollmentStep5Screen({super.key});

  @override
  State<EnrollmentStep5Screen> createState() => _EnrollmentStep5ScreenState();
}

class _EnrollmentStep5ScreenState extends State<EnrollmentStep5Screen> {
  GlobalKey<FormState> formKey = GlobalKey();

  // Country selection and enrollment center
  String? selectedCountry;
  CentreModel? selectedEnrollmentCenter;

  // Lists for dynamic data
  List<DistrictModel> districts = [];
  List<RegionModel> regions = [];
  List<DepartementModel> departements = [];
  List<SousPrefectureModel> sousPrefectures = [];
  List<CommuneModel> communes = [];
  List<VillageModel> villages = [];
  List<CentreModel> centers = [];

  // Selected values for filters
  DistrictModel? selectedDistrict;
  RegionModel? selectedRegion;
  DepartementModel? selectedDepartement;
  SousPrefectureModel? selectedSousPrefecture;
  CommuneModel? selectedCommune;
  VillageModel? selectedVillage;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => isLoading = true);
    selectedDistrict = enrollmentStore.district;

    try {
      // Load districts (countries)
      final districtsResponse = await getDistricts();
      districts = (districtsResponse as List)
          .map((item) => DistrictModel.fromJson(item['list']))
          .toList();
      if (selectedDistrict != null) {
        await _loadRegions();
        await _loadDepartements();
        await _loadSousPrefectures();
        await _loadCommunes();
        await _loadCenters();
        if (enrollmentStore.enrollmentCenter != null) {
          selectedEnrollmentCenter = enrollmentStore.enrollmentCenter;
        }
      }
    } catch (e) {
      toast('Failed to load districts: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadRegions() async {
    if (selectedDistrict == null) return;

    setState(() {
      isLoading = true;
      regions = [];
      selectedRegion = null;
    });

    try {
      final response = await getRegions(districtId: selectedDistrict?.id);
      regions = (response as List)
          .map((item) => RegionModel.fromJson(item['list']))
          .toList();
    } catch (e) {
      toast('Failed to load regions: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadDepartements() async {
    if (selectedRegion == null) return;

    setState(() {
      isLoading = true;
      departements = [];
      selectedDepartement = null;
    });

    try {
      final response = await getDepartements(
        districtId: selectedDistrict?.id,
        regionId: selectedRegion?.id,
      );
      departements = (response as List)
          .map((item) => DepartementModel.fromJson(item['list']))
          .toList();
    } catch (e) {
      toast('Failed to load departments: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadSousPrefectures() async {
    if (selectedDepartement == null) return;

    setState(() {
      isLoading = true;
      sousPrefectures = [];
      selectedSousPrefecture = null;
    });

    try {
      final response = await getSousPrefectures(
        districtId: selectedDistrict?.id,
        regionId: selectedRegion?.id,
        departementId: selectedDepartement?.id,
      );
      sousPrefectures = (response as List)
          .map((item) => SousPrefectureModel.fromJson(item['list']))
          .toList();
    } catch (e) {
      toast('Failed to load sous-prefectures: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadCommunes() async {
    if (selectedSousPrefecture == null) return;

    setState(() {
      isLoading = true;
      communes = [];
      selectedCommune = null;
    });

    try {
      final response = await getCommunes(
        districtId: selectedDistrict?.id,
        regionId: selectedRegion?.id,
        departementId: selectedDepartement?.id,
        sousPrefId: selectedSousPrefecture?.id,
      );
      communes = (response as List)
          .map((item) => CommuneModel.fromJson(item['list']))
          .toList();
    } catch (e) {
      toast('Failed to load communes: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _loadCenters() async {
    setState(() {
      isLoading = true;
      centers = [];
      selectedEnrollmentCenter = null;
    });

    try {
      final response = await filterCentres(
        districtId: selectedDistrict?.id,
        regionId: selectedRegion?.id,
        departementId: selectedDepartement?.id,
        sousPrefectureId: selectedSousPrefecture?.id,
        communeId: selectedCommune?.id,
        villageId: selectedVillage?.id,
      );
      print(response);
      centers = (response['data'] as List)
          .map((item) => CentreModel.fromJson(item['list']))
          .toList();
    } catch (e) {
      toast('Failed to load centers: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IndicatorDot(
                      currentPage: 4,
                      totalItems: 7,
                      selectedDotWidth: 45,
                      unselectedDotWidth: 45,
                    ),
                    30.height,
                    Text("Centre d'enrôlement",
                        style: boldTextStyle(
                            size: 36, letterSpacing: 2, color: Colors.black)),
                    50.height,
                    const Text(
                      'District',
                      style: AppTextStyles.body2,
                    ),
                    DropdownSearch<DistrictModel>(
                      items: (f, cs) => districts.map((type) => type).toList(),
                      selectedItem: selectedDistrict,
                      compareFn: (item1, item2) => item1.id == item2.id,
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                        searchFieldProps: const TextFieldProps(
                          decoration: InputDecoration(
                            hintText: "Rechercher...",
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          ),
                        ),
                        searchDelay: const Duration(milliseconds: 0),
                        itemBuilder: (context, item, _, isSelected) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Text(
                              item.name ?? '',
                              style: TextStyle(
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                      onChanged: (value) async {
                        setState(() {
                          selectedDistrict = value;
                          // Reset all dependent fields
                          selectedRegion = null;
                          selectedDepartement = null;
                          selectedSousPrefecture = null;
                          selectedCommune = null;
                          selectedVillage = null;
                          selectedEnrollmentCenter = null;
                          regions = [];
                          departements = [];
                          sousPrefectures = [];
                          communes = [];
                          villages = [];
                          centers = [];
                        });
                        await _loadRegions();
                        await _loadCenters();
                      },
                      itemAsString: (item) => item.name ?? '',
                      validator: (value) => value == null ? 'District is required' : null,
                    ),
                    16.height,
                    const Text(
                      'Région',
                      style: AppTextStyles.body2,
                    ),
                    DropdownSearch<RegionModel>(
                      items: (f, cs) => regions.map((type) => type).toList(),
                      selectedItem: selectedRegion,
                      enabled: selectedDistrict != null,
                      compareFn: (item1, item2) => item1.id == item2.id,
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      onChanged: (value) async {
                        setState(() {
                          selectedRegion = value;
                          // Reset dependent fields
                          selectedDepartement = null;
                          selectedSousPrefecture = null;
                          selectedCommune = null;
                          selectedVillage = null;
                          selectedEnrollmentCenter = null;
                          departements = [];
                          sousPrefectures = [];
                          communes = [];
                          villages = [];
                          centers = [];
                        });
                        await _loadDepartements();
                        await _loadCenters();
                      },
                      itemAsString: (item) => item.name ?? '',
                    ),
                    16.height,
                    const Text(
                      'Département',
                      style: AppTextStyles.body2,
                    ),
                    DropdownSearch<DepartementModel>(
                      items: (f, cs) => departements.map((type) => type).toList(),
                      selectedItem: selectedDepartement,
                      enabled: selectedRegion != null,
                      compareFn: (item1, item2) => item1.id == item2.id,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      onChanged: (value) async {
                        setState(() {
                          selectedDepartement = value;
                          // Reset dependent fields
                          selectedSousPrefecture = null;
                          selectedCommune = null;
                          selectedVillage = null;
                          selectedEnrollmentCenter = null;
                          sousPrefectures = [];
                          communes = [];
                          villages = [];
                          centers = [];
                        });
                        await _loadSousPrefectures();
                        await _loadCenters();
                      },
                      itemAsString: (item) => item.name ?? '',
                    ),
                    16.height,
                    const Text(
                      'Sous-Préfecture',
                      style: AppTextStyles.body2,
                    ),
                    DropdownSearch<SousPrefectureModel>(
                      items: (f, cs) => sousPrefectures.map((type) => type).toList(),
                      selectedItem: selectedSousPrefecture,
                      enabled: selectedDepartement != null,
                      compareFn: (item1, item2) => item1.id == item2.id,
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      onChanged: (value) async {
                        setState(() {
                          selectedSousPrefecture = value;
                          // Reset dependent fields
                          selectedCommune = null;
                          selectedVillage = null;
                          selectedEnrollmentCenter = null;
                          communes = [];
                          villages = [];
                          centers = [];
                        });
                        await _loadCommunes();
                        await _loadCenters();
                      },
                      itemAsString: (item) => item.name ?? '',
                    ),
                    16.height,
                    const Text(
                      'Commune',
                      style: AppTextStyles.body2,
                    ),
                    DropdownSearch<CommuneModel>(
                      items: (f, cs) => communes.map((type) => type).toList(),
                      selectedItem: selectedCommune,
                      enabled: selectedSousPrefecture != null,
                      compareFn: (item1, item2) => item1.id == item2.id,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      onChanged: (value) async{
                        setState(() {
                          selectedCommune = value;
                          // Reset dependent fields
                          selectedVillage = null;
                          selectedEnrollmentCenter = null;
                          villages = [];
                          centers = [];
                        });
                        await _loadCenters();
                      },
                      itemAsString: (item) => item.name ?? '',
                    ),
                    16.height,
                    const Text(
                      'Centre d\'enrôlement',
                      style: AppTextStyles.body2,
                    ),
                    DropdownSearch<CentreModel>(
                      items: (f, cs) => centers.map((type) => type).toList(),
                      selectedItem: selectedEnrollmentCenter,
                      enabled: selectedDistrict != null,
                      compareFn: (item1, item2) => item1.id == item2.id,
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                        showSelectedItems: true,
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedEnrollmentCenter = value;
                        });
                      },
                      itemAsString: (item) => item.name ?? '',

                    ),
                    if (centers.isEmpty && selectedDistrict != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Aucun centre trouvé avec les filtres sélectionnés',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    if (isLoading) const CircularProgressIndicator().center(),
                    30.height,
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                      onTap: () {
                        enrollmentStore.previousStep();
                      },
                      elevation: 0.0,
                      color: Colors.grey[300],
                      child: Text('Précédent',
                          style: boldTextStyle(color: Colors.black)),
                    ),
                  ),
                  8.width,
                  Expanded(
                    child: AppButton(
                      shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                      onTap: () {
                        if (selectedDistrict == null) {
                          toast('Veuillez sélectionner un district');
                          return;
                        }
                        if (selectedEnrollmentCenter == null) {
                          toast('Veuillez sélectionner un centre d\'enrôlement');
                          return;
                        }

                        // Save selected center to enrollment store
                        enrollmentStore.setStep5Data(
                          district: selectedDistrict,
                          enrollmentCenter: selectedEnrollmentCenter,
                        );
                        enrollmentStore.nextStep();
                      },
                      elevation: 0.0,
                      color: AppColors.primary,
                      child: Text('Suivant',
                          style: boldTextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}