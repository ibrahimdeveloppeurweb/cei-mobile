import 'package:cei_mobile/core/constants/api_constants.dart';
import 'package:cei_mobile/main.dart';

Future<dynamic> getEnrolmentCenter(int centerId) async {
  return apiClient.get("${ApiConstants.enrolmentcenter}/$centerId",);
}

Future<dynamic> filterCentres({
  int? districtId,
  int? regionId,
  int? departementId,
  int? sousPrefectureId,
  int? communeId,
  int? villageId,
  String? nom
}) async {
  String url = ApiConstants.centresToFilter;
  List<String> queryParams = [];

  // Add geographic filters if provided
  if (districtId != null) {
    queryParams.add("district=$districtId");
  }
  if (regionId != null) {
    queryParams.add("region=$regionId");
  }
  if (departementId != null) {
    queryParams.add("departement=$departementId");
  }
  if (sousPrefectureId != null) {
    queryParams.add("sousPrefecture=$sousPrefectureId");
  }
  if (communeId != null) {
    queryParams.add("commune=$communeId");
  }
  if (villageId != null) {
    queryParams.add("village=$villageId");
  }

  // Add name filter - use empty string if not provided to match all centers
  queryParams.add("nom=${nom ?? ""}");

  // Append query parameters to the URL if there are any
  if (queryParams.isNotEmpty) {
    url += "?" + queryParams.join("&");
  }

  // Make the API request with the constructed URL
  return apiClient.get(url);

}