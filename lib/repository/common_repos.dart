import 'package:cei_mobile/core/constants/api_constants.dart';
import 'package:cei_mobile/main.dart';

Future<dynamic> getDistricts() async {
  return apiClient.get(ApiConstants.districts);
}

// Regions endpoint with optional district filter
Future<dynamic> getRegions({int? districtId}) async {
  String url = ApiConstants.regions;
  if (districtId != null) {
    url += "?district_id=$districtId";
  }
  return apiClient.get(url);
}

// Departments endpoint with optional filters
Future<dynamic> getDepartements({
  int? districtId,
  int? regionId,
}) async {
  String url = ApiConstants.departements;
  List<String> queryParams = [];

  if (districtId != null) {
    queryParams.add("district=$districtId");
  }
  if (regionId != null) {
    queryParams.add("region=$regionId");
  }

  if (queryParams.isNotEmpty) {
    url += "?" + queryParams.join("&");
  }

  return apiClient.get(url);
}

// Sous-Prefectures endpoint with optional filters
Future<dynamic> getSousPrefectures({
  int? districtId,
  int? regionId,
  int? departementId,
}) async {
  String url = ApiConstants.sousPrefectures;
  List<String> queryParams = [];

  if (districtId != null) {
    queryParams.add("district=$districtId");
  }
  if (regionId != null) {
    queryParams.add("region=$regionId");
  }
  if (departementId != null) {
    queryParams.add("departement=$departementId");
  }

  if (queryParams.isNotEmpty) {
    url += "?" + queryParams.join("&");
  }

  return apiClient.get(url);
}

// Communes endpoint with optional filters
Future<dynamic> getCommunes({
  int? districtId,
  int? regionId,
  int? departementId,
  int? sousPrefId,
}) async {
  String url = ApiConstants.communes;
  List<String> queryParams = [];

  if (districtId != null) {
    queryParams.add("district=$districtId");
  }
  if (regionId != null) {
    queryParams.add("region=$regionId");
  }
  if (departementId != null) {
    queryParams.add("departement=$departementId");
  }
  if (sousPrefId != null) {
    queryParams.add("sousPref=$sousPrefId");
  }

  if (queryParams.isNotEmpty) {
    url += "?" + queryParams.join("&");
  }

  return apiClient.get(url);
}

Future<dynamic> getAnnees() async {
  String url = ApiConstants.annnees;
  return apiClient.get(url);
}