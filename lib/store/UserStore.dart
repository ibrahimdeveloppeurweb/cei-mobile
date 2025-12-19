import 'package:cei_mobile/model/user/user_model.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../core/constants/user_constants.dart';

part 'UserStore.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  // Observable for user model
  @observable
  UserModel? user;

  // Observable fields for individual properties
  @observable
  int? id;

  @observable
  String? username;

  @observable
  String? email;

  @observable
  String? phoneNumber;

  @observable
  List<String>? roles;

  @observable
  String? firstName;

  @observable
  String? lastName;

  @observable
  String? numEnregister;

  @action
  void setUser(UserModel newUser) {
    user = newUser;
    id = newUser.id;
    username = newUser.username;
    email = newUser.email;
    phoneNumber = newUser.phoneNumber;
    roles = newUser.roles;
    firstName = newUser.firstName;
    lastName = newUser.lastName;
    numEnregister = newUser.numEnregister;

    setValue(USER_ID, newUser.id);
    setValue(USER_USERNAME, newUser.username);
    setValue(USER_EMAIL, newUser.email);
    setValue(USER_PHONE_NUMBER, newUser.phoneNumber);
    setValue(USER_ROLES, newUser.roles);
    setValue(USER_FIRST_NAME, newUser.firstName);
    setValue(USER_LAST_NAME, newUser.lastName);
    setValue(USER_UNIQUE_REGISTRATION_NUMBER, newUser.numEnregister);
  }

  @action
  void setId(int? value, {bool initialize = false}) {
    if (initialize) setValue(USER_ID, value);
    id = value;
  }

  @action
  void setUsername(String? value, {bool initialize = false}) {
    if (initialize) setValue(USER_USERNAME, value);
    username = value;
  }

  @action
  void setEmail(String? value, {bool initialize = false}) {
    if (initialize) setValue(USER_EMAIL, value);
    email = value;
  }

  @action
  void setPhoneNumber(String? value, {bool initialize = false}) {
    if (initialize) setValue(USER_PHONE_NUMBER, value);
    phoneNumber = value;
  }

  @action
  void setRoles(List<String>? value, {bool initialize = false}) {
    if (initialize) setValue(USER_ROLES, value);
    roles = value;
  }

  @action
  void setFirstName(String? value, {bool initialize = false}) {
    if (initialize) setValue(USER_FIRST_NAME, value);
    firstName = value;
  }

  @action
  void setLastName(String? value, {bool initialize = false}) {
    if (initialize) setValue(USER_LAST_NAME, value);
    lastName = value;
  }

  @action
  void setUniqueRegistrationNumber(String? value, {bool initialize = false}) {
    if (initialize) setValue(USER_UNIQUE_REGISTRATION_NUMBER, value);
    numEnregister = value;
  }

  // Load user data from JSON
  @action
  void loadUserFromJson(Map<String, dynamic> json) {
    setUser(UserModel.fromJson(json));
  }

  // Convert the current state of the store back to JSON
  Map<String, dynamic> toJson() {
    return user?.toJson() ?? {};
  }

  // Initialize user from shared preferences
  @action
  Future<void> initUserFromPrefs() async {
    id = getIntAsync(USER_ID);
    username = getStringAsync(USER_USERNAME);
    email = getStringAsync(USER_EMAIL);
    phoneNumber = getStringAsync(USER_PHONE_NUMBER);
    roles = getStringListAsync(USER_ROLES);
    firstName = getStringAsync(USER_FIRST_NAME);
    lastName = getStringAsync(USER_LAST_NAME);
    numEnregister = getStringAsync(USER_UNIQUE_REGISTRATION_NUMBER);

    if (id != null) {
      user = UserModel(
        id: id,
        username: username,
        email: email,
        phoneNumber: phoneNumber,
        roles: roles,
        firstName: firstName,
        lastName: lastName,
        numEnregister: numEnregister,
      );
    }
  }

  // Clear user data on logout
  @action
  void clearUser() {
    user = null;
    id = null;
    username = null;
    email = null;
    phoneNumber = null;
    roles = null;
    firstName = null;
    lastName = null;
    numEnregister = null;

    // Clear shared preferences
    removeKey(USER_ID);
    removeKey(USER_USERNAME);
    removeKey(USER_EMAIL);
    removeKey(USER_PHONE_NUMBER);
    removeKey(USER_ROLES);
    removeKey(USER_FIRST_NAME);
    removeKey(USER_LAST_NAME);
    removeKey(USER_UNIQUE_REGISTRATION_NUMBER);
  }
}