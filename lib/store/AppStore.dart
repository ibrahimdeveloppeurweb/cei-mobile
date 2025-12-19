
import 'package:cei_mobile/core/constants/app_constants.dart';
import 'package:cei_mobile/model/enrollment_data.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

part 'AppStore.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  String appVersion = '';

  @observable
  String password = '';

  @observable
  bool isDarkModeOn = false;

  @observable
  bool isVoterCenterSaved = false;

  @observable
  String? bureauDeVoteNumber;

  @observable
  int? voterCenterId;

  @observable
  bool isLoading = false;

  @observable
  bool isConnectedToInternet = false;


  @observable
  bool isLoggedIn = false;

  @observable
  bool isNotificationsOn = false;


  @observable
  String mStatus = "All";


  @observable
  String? currency;

  @observable
  String currencySymbol = '';

  @observable
  String currencyCode = '';


  @observable
  String? currencyPrefix;

  @observable
  String? currencyPostfix;

  @observable
  String? tempBaseUrl;


  @observable
  String? globalDateFormat;

  @observable
  String? globalUTC;


  @observable
  String apiNonce = '';

  @observable
  bool? isLocationEnabled;

  @observable
  String printerAddress = '';

  @observable
  String? numEnregister;

  @observable
  EnrollmentData? enrollmentData;


  @action
  void setInternetStatus(bool val) {
    isConnectedToInternet = val;
  }


  @action
  Future<void> setLoggedIn(bool value) async {
    setValue(AppConstants.isLoggedInKey, value);
    isLoggedIn = value;
  }

  @action
  Future<void> setLoading(bool value) async => isLoading = value;

  @action
  Future<void> setIsVoterCenterSaved(bool value) async {
    setValue(AppConstants.isVoterCenterSavedKey, value);
    isVoterCenterSaved = value;
  }

  @action
  Future<void> setVoterCenterId(int value) async {
    setValue(AppConstants.voterCenterIdKey, value);
    voterCenterId = value;
  }

  @action
  Future<void> setBureauDeVoteNumber(String value) async {
    setValue(AppConstants.bureauDeVoteNumberKey, value);
    bureauDeVoteNumber = value;
  }

  @action
  Future<void> setNumEnregister(String value) async {
    setValue(AppConstants.numEnregisterKey, value);
    numEnregister = value;
  }

  @action
  Future<void> setEnrollmentData(EnrollmentData? value) async {
    enrollmentData = value;
  }
}
