// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  late final _$userAtom = Atom(name: 'UserStoreBase.user', context: context);

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$idAtom = Atom(name: 'UserStoreBase.id', context: context);

  @override
  int? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$usernameAtom =
      Atom(name: 'UserStoreBase.username', context: context);

  @override
  String? get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String? value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$emailAtom = Atom(name: 'UserStoreBase.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: 'UserStoreBase.phoneNumber', context: context);

  @override
  String? get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String? value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$rolesAtom = Atom(name: 'UserStoreBase.roles', context: context);

  @override
  List<String>? get roles {
    _$rolesAtom.reportRead();
    return super.roles;
  }

  @override
  set roles(List<String>? value) {
    _$rolesAtom.reportWrite(value, super.roles, () {
      super.roles = value;
    });
  }

  late final _$firstNameAtom =
      Atom(name: 'UserStoreBase.firstName', context: context);

  @override
  String? get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String? value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  late final _$lastNameAtom =
      Atom(name: 'UserStoreBase.lastName', context: context);

  @override
  String? get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String? value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  late final _$numEnregisterAtom =
      Atom(name: 'UserStoreBase.numEnregister', context: context);

  @override
  String? get numEnregister {
    _$numEnregisterAtom.reportRead();
    return super.numEnregister;
  }

  @override
  set numEnregister(String? value) {
    _$numEnregisterAtom.reportWrite(value, super.numEnregister, () {
      super.numEnregister = value;
    });
  }

  late final _$initUserFromPrefsAsyncAction =
      AsyncAction('UserStoreBase.initUserFromPrefs', context: context);

  @override
  Future<void> initUserFromPrefs() {
    return _$initUserFromPrefsAsyncAction.run(() => super.initUserFromPrefs());
  }

  late final _$UserStoreBaseActionController =
      ActionController(name: 'UserStoreBase', context: context);

  @override
  void setUser(UserModel newUser) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setUser');
    try {
      return super.setUser(newUser);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setId(int? value, {bool initialize = false}) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setId');
    try {
      return super.setId(value, initialize: initialize);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUsername(String? value, {bool initialize = false}) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setUsername');
    try {
      return super.setUsername(value, initialize: initialize);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String? value, {bool initialize = false}) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setEmail');
    try {
      return super.setEmail(value, initialize: initialize);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoneNumber(String? value, {bool initialize = false}) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setPhoneNumber');
    try {
      return super.setPhoneNumber(value, initialize: initialize);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRoles(List<String>? value, {bool initialize = false}) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setRoles');
    try {
      return super.setRoles(value, initialize: initialize);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFirstName(String? value, {bool initialize = false}) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setFirstName');
    try {
      return super.setFirstName(value, initialize: initialize);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLastName(String? value, {bool initialize = false}) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setLastName');
    try {
      return super.setLastName(value, initialize: initialize);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUniqueRegistrationNumber(String? value, {bool initialize = false}) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.setUniqueRegistrationNumber');
    try {
      return super.setUniqueRegistrationNumber(value, initialize: initialize);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadUserFromJson(Map<String, dynamic> json) {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.loadUserFromJson');
    try {
      return super.loadUserFromJson(json);
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearUser() {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.clearUser');
    try {
      return super.clearUser();
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
id: ${id},
username: ${username},
email: ${email},
phoneNumber: ${phoneNumber},
roles: ${roles},
firstName: ${firstName},
lastName: ${lastName},
numEnregister: ${numEnregister}
    ''';
  }
}
