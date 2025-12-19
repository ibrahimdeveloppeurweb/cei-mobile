// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  int? get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String? get phoneNumber => throw _privateConstructorUsedError;
  List<String>? get roles => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get uniqueRegistrationNumber => throw _privateConstructorUsedError;
  String? get formNumber => throw _privateConstructorUsedError;
  String? get numEnregister => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String? get placeOfBirth => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  String? get profession => throw _privateConstructorUsedError;
  String? get residence => throw _privateConstructorUsedError;
  String? get fatherName => throw _privateConstructorUsedError;
  DateTime? get fatherDateOfBirth => throw _privateConstructorUsedError;
  String? get fatherPlaceOfBirth => throw _privateConstructorUsedError;
  String? get motherName => throw _privateConstructorUsedError;
  DateTime? get motherDateOfBirth => throw _privateConstructorUsedError;
  String? get motherPlaceOfBirth => throw _privateConstructorUsedError;
  String? get voterStatus => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get orderNumber => throw _privateConstructorUsedError;
  BureauModel? get pollingStation => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {int? id,
      String? username,
      String? email,
      @JsonKey(name: 'phone_number') String? phoneNumber,
      List<String>? roles,
      String? firstName,
      String? lastName,
      String? uniqueRegistrationNumber,
      String? formNumber,
      String? numEnregister,
      DateTime? dateOfBirth,
      String? placeOfBirth,
      String? gender,
      String? profession,
      String? residence,
      String? fatherName,
      DateTime? fatherDateOfBirth,
      String? fatherPlaceOfBirth,
      String? motherName,
      DateTime? motherDateOfBirth,
      String? motherPlaceOfBirth,
      String? voterStatus,
      String? imageUrl,
      String? orderNumber,
      BureauModel? pollingStation});

  $BureauModelCopyWith<$Res>? get pollingStation;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? roles = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? uniqueRegistrationNumber = freezed,
    Object? formNumber = freezed,
    Object? numEnregister = freezed,
    Object? dateOfBirth = freezed,
    Object? placeOfBirth = freezed,
    Object? gender = freezed,
    Object? profession = freezed,
    Object? residence = freezed,
    Object? fatherName = freezed,
    Object? fatherDateOfBirth = freezed,
    Object? fatherPlaceOfBirth = freezed,
    Object? motherName = freezed,
    Object? motherDateOfBirth = freezed,
    Object? motherPlaceOfBirth = freezed,
    Object? voterStatus = freezed,
    Object? imageUrl = freezed,
    Object? orderNumber = freezed,
    Object? pollingStation = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      roles: freezed == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      uniqueRegistrationNumber: freezed == uniqueRegistrationNumber
          ? _value.uniqueRegistrationNumber
          : uniqueRegistrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      formNumber: freezed == formNumber
          ? _value.formNumber
          : formNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      numEnregister: freezed == numEnregister
          ? _value.numEnregister
          : numEnregister // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placeOfBirth: freezed == placeOfBirth
          ? _value.placeOfBirth
          : placeOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      profession: freezed == profession
          ? _value.profession
          : profession // ignore: cast_nullable_to_non_nullable
              as String?,
      residence: freezed == residence
          ? _value.residence
          : residence // ignore: cast_nullable_to_non_nullable
              as String?,
      fatherName: freezed == fatherName
          ? _value.fatherName
          : fatherName // ignore: cast_nullable_to_non_nullable
              as String?,
      fatherDateOfBirth: freezed == fatherDateOfBirth
          ? _value.fatherDateOfBirth
          : fatherDateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fatherPlaceOfBirth: freezed == fatherPlaceOfBirth
          ? _value.fatherPlaceOfBirth
          : fatherPlaceOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      motherName: freezed == motherName
          ? _value.motherName
          : motherName // ignore: cast_nullable_to_non_nullable
              as String?,
      motherDateOfBirth: freezed == motherDateOfBirth
          ? _value.motherDateOfBirth
          : motherDateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      motherPlaceOfBirth: freezed == motherPlaceOfBirth
          ? _value.motherPlaceOfBirth
          : motherPlaceOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      voterStatus: freezed == voterStatus
          ? _value.voterStatus
          : voterStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNumber: freezed == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      pollingStation: freezed == pollingStation
          ? _value.pollingStation
          : pollingStation // ignore: cast_nullable_to_non_nullable
              as BureauModel?,
    ) as $Val);
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BureauModelCopyWith<$Res>? get pollingStation {
    if (_value.pollingStation == null) {
      return null;
    }

    return $BureauModelCopyWith<$Res>(_value.pollingStation!, (value) {
      return _then(_value.copyWith(pollingStation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? username,
      String? email,
      @JsonKey(name: 'phone_number') String? phoneNumber,
      List<String>? roles,
      String? firstName,
      String? lastName,
      String? uniqueRegistrationNumber,
      String? formNumber,
      String? numEnregister,
      DateTime? dateOfBirth,
      String? placeOfBirth,
      String? gender,
      String? profession,
      String? residence,
      String? fatherName,
      DateTime? fatherDateOfBirth,
      String? fatherPlaceOfBirth,
      String? motherName,
      DateTime? motherDateOfBirth,
      String? motherPlaceOfBirth,
      String? voterStatus,
      String? imageUrl,
      String? orderNumber,
      BureauModel? pollingStation});

  @override
  $BureauModelCopyWith<$Res>? get pollingStation;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? email = freezed,
    Object? phoneNumber = freezed,
    Object? roles = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? uniqueRegistrationNumber = freezed,
    Object? formNumber = freezed,
    Object? numEnregister = freezed,
    Object? dateOfBirth = freezed,
    Object? placeOfBirth = freezed,
    Object? gender = freezed,
    Object? profession = freezed,
    Object? residence = freezed,
    Object? fatherName = freezed,
    Object? fatherDateOfBirth = freezed,
    Object? fatherPlaceOfBirth = freezed,
    Object? motherName = freezed,
    Object? motherDateOfBirth = freezed,
    Object? motherPlaceOfBirth = freezed,
    Object? voterStatus = freezed,
    Object? imageUrl = freezed,
    Object? orderNumber = freezed,
    Object? pollingStation = freezed,
  }) {
    return _then(_$UserModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      roles: freezed == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      uniqueRegistrationNumber: freezed == uniqueRegistrationNumber
          ? _value.uniqueRegistrationNumber
          : uniqueRegistrationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      formNumber: freezed == formNumber
          ? _value.formNumber
          : formNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      numEnregister: freezed == numEnregister
          ? _value.numEnregister
          : numEnregister // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placeOfBirth: freezed == placeOfBirth
          ? _value.placeOfBirth
          : placeOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      profession: freezed == profession
          ? _value.profession
          : profession // ignore: cast_nullable_to_non_nullable
              as String?,
      residence: freezed == residence
          ? _value.residence
          : residence // ignore: cast_nullable_to_non_nullable
              as String?,
      fatherName: freezed == fatherName
          ? _value.fatherName
          : fatherName // ignore: cast_nullable_to_non_nullable
              as String?,
      fatherDateOfBirth: freezed == fatherDateOfBirth
          ? _value.fatherDateOfBirth
          : fatherDateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fatherPlaceOfBirth: freezed == fatherPlaceOfBirth
          ? _value.fatherPlaceOfBirth
          : fatherPlaceOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      motherName: freezed == motherName
          ? _value.motherName
          : motherName // ignore: cast_nullable_to_non_nullable
              as String?,
      motherDateOfBirth: freezed == motherDateOfBirth
          ? _value.motherDateOfBirth
          : motherDateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      motherPlaceOfBirth: freezed == motherPlaceOfBirth
          ? _value.motherPlaceOfBirth
          : motherPlaceOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      voterStatus: freezed == voterStatus
          ? _value.voterStatus
          : voterStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      orderNumber: freezed == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      pollingStation: freezed == pollingStation
          ? _value.pollingStation
          : pollingStation // ignore: cast_nullable_to_non_nullable
              as BureauModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {this.id,
      this.username,
      this.email,
      @JsonKey(name: 'phone_number') this.phoneNumber,
      final List<String>? roles,
      this.firstName,
      this.lastName,
      this.uniqueRegistrationNumber,
      this.formNumber,
      this.numEnregister,
      this.dateOfBirth,
      this.placeOfBirth,
      this.gender,
      this.profession,
      this.residence,
      this.fatherName,
      this.fatherDateOfBirth,
      this.fatherPlaceOfBirth,
      this.motherName,
      this.motherDateOfBirth,
      this.motherPlaceOfBirth,
      this.voterStatus,
      this.imageUrl,
      this.orderNumber,
      this.pollingStation})
      : _roles = roles;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? username;
  @override
  final String? email;
  @override
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final List<String>? _roles;
  @override
  List<String>? get roles {
    final value = _roles;
    if (value == null) return null;
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? uniqueRegistrationNumber;
  @override
  final String? formNumber;
  @override
  final String? numEnregister;
  @override
  final DateTime? dateOfBirth;
  @override
  final String? placeOfBirth;
  @override
  final String? gender;
  @override
  final String? profession;
  @override
  final String? residence;
  @override
  final String? fatherName;
  @override
  final DateTime? fatherDateOfBirth;
  @override
  final String? fatherPlaceOfBirth;
  @override
  final String? motherName;
  @override
  final DateTime? motherDateOfBirth;
  @override
  final String? motherPlaceOfBirth;
  @override
  final String? voterStatus;
  @override
  final String? imageUrl;
  @override
  final String? orderNumber;
  @override
  final BureauModel? pollingStation;

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, phoneNumber: $phoneNumber, roles: $roles, firstName: $firstName, lastName: $lastName, uniqueRegistrationNumber: $uniqueRegistrationNumber, formNumber: $formNumber, numEnregister: $numEnregister, dateOfBirth: $dateOfBirth, placeOfBirth: $placeOfBirth, gender: $gender, profession: $profession, residence: $residence, fatherName: $fatherName, fatherDateOfBirth: $fatherDateOfBirth, fatherPlaceOfBirth: $fatherPlaceOfBirth, motherName: $motherName, motherDateOfBirth: $motherDateOfBirth, motherPlaceOfBirth: $motherPlaceOfBirth, voterStatus: $voterStatus, imageUrl: $imageUrl, orderNumber: $orderNumber, pollingStation: $pollingStation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(
                    other.uniqueRegistrationNumber, uniqueRegistrationNumber) ||
                other.uniqueRegistrationNumber == uniqueRegistrationNumber) &&
            (identical(other.formNumber, formNumber) ||
                other.formNumber == formNumber) &&
            (identical(other.numEnregister, numEnregister) ||
                other.numEnregister == numEnregister) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.placeOfBirth, placeOfBirth) ||
                other.placeOfBirth == placeOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.profession, profession) ||
                other.profession == profession) &&
            (identical(other.residence, residence) ||
                other.residence == residence) &&
            (identical(other.fatherName, fatherName) ||
                other.fatherName == fatherName) &&
            (identical(other.fatherDateOfBirth, fatherDateOfBirth) ||
                other.fatherDateOfBirth == fatherDateOfBirth) &&
            (identical(other.fatherPlaceOfBirth, fatherPlaceOfBirth) ||
                other.fatherPlaceOfBirth == fatherPlaceOfBirth) &&
            (identical(other.motherName, motherName) ||
                other.motherName == motherName) &&
            (identical(other.motherDateOfBirth, motherDateOfBirth) ||
                other.motherDateOfBirth == motherDateOfBirth) &&
            (identical(other.motherPlaceOfBirth, motherPlaceOfBirth) ||
                other.motherPlaceOfBirth == motherPlaceOfBirth) &&
            (identical(other.voterStatus, voterStatus) ||
                other.voterStatus == voterStatus) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.pollingStation, pollingStation) ||
                other.pollingStation == pollingStation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        username,
        email,
        phoneNumber,
        const DeepCollectionEquality().hash(_roles),
        firstName,
        lastName,
        uniqueRegistrationNumber,
        formNumber,
        numEnregister,
        dateOfBirth,
        placeOfBirth,
        gender,
        profession,
        residence,
        fatherName,
        fatherDateOfBirth,
        fatherPlaceOfBirth,
        motherName,
        motherDateOfBirth,
        motherPlaceOfBirth,
        voterStatus,
        imageUrl,
        orderNumber,
        pollingStation
      ]);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {final int? id,
      final String? username,
      final String? email,
      @JsonKey(name: 'phone_number') final String? phoneNumber,
      final List<String>? roles,
      final String? firstName,
      final String? lastName,
      final String? uniqueRegistrationNumber,
      final String? formNumber,
      final String? numEnregister,
      final DateTime? dateOfBirth,
      final String? placeOfBirth,
      final String? gender,
      final String? profession,
      final String? residence,
      final String? fatherName,
      final DateTime? fatherDateOfBirth,
      final String? fatherPlaceOfBirth,
      final String? motherName,
      final DateTime? motherDateOfBirth,
      final String? motherPlaceOfBirth,
      final String? voterStatus,
      final String? imageUrl,
      final String? orderNumber,
      final BureauModel? pollingStation}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get username;
  @override
  String? get email;
  @override
  @JsonKey(name: 'phone_number')
  String? get phoneNumber;
  @override
  List<String>? get roles;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get uniqueRegistrationNumber;
  @override
  String? get formNumber;
  @override
  String? get numEnregister;
  @override
  DateTime? get dateOfBirth;
  @override
  String? get placeOfBirth;
  @override
  String? get gender;
  @override
  String? get profession;
  @override
  String? get residence;
  @override
  String? get fatherName;
  @override
  DateTime? get fatherDateOfBirth;
  @override
  String? get fatherPlaceOfBirth;
  @override
  String? get motherName;
  @override
  DateTime? get motherDateOfBirth;
  @override
  String? get motherPlaceOfBirth;
  @override
  String? get voterStatus;
  @override
  String? get imageUrl;
  @override
  String? get orderNumber;
  @override
  BureauModel? get pollingStation;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BureauModel _$BureauModelFromJson(Map<String, dynamic> json) {
  return _BureauModel.fromJson(json);
}

/// @nodoc
mixin _$BureauModel {
  int? get id => throw _privateConstructorUsedError;
  String? get numero => throw _privateConstructorUsedError;
  CentreModel? get centre => throw _privateConstructorUsedError;

  /// Serializes this BureauModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BureauModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BureauModelCopyWith<BureauModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BureauModelCopyWith<$Res> {
  factory $BureauModelCopyWith(
          BureauModel value, $Res Function(BureauModel) then) =
      _$BureauModelCopyWithImpl<$Res, BureauModel>;
  @useResult
  $Res call({int? id, String? numero, CentreModel? centre});

  $CentreModelCopyWith<$Res>? get centre;
}

/// @nodoc
class _$BureauModelCopyWithImpl<$Res, $Val extends BureauModel>
    implements $BureauModelCopyWith<$Res> {
  _$BureauModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BureauModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? numero = freezed,
    Object? centre = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      numero: freezed == numero
          ? _value.numero
          : numero // ignore: cast_nullable_to_non_nullable
              as String?,
      centre: freezed == centre
          ? _value.centre
          : centre // ignore: cast_nullable_to_non_nullable
              as CentreModel?,
    ) as $Val);
  }

  /// Create a copy of BureauModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CentreModelCopyWith<$Res>? get centre {
    if (_value.centre == null) {
      return null;
    }

    return $CentreModelCopyWith<$Res>(_value.centre!, (value) {
      return _then(_value.copyWith(centre: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BureauModelImplCopyWith<$Res>
    implements $BureauModelCopyWith<$Res> {
  factory _$$BureauModelImplCopyWith(
          _$BureauModelImpl value, $Res Function(_$BureauModelImpl) then) =
      __$$BureauModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? numero, CentreModel? centre});

  @override
  $CentreModelCopyWith<$Res>? get centre;
}

/// @nodoc
class __$$BureauModelImplCopyWithImpl<$Res>
    extends _$BureauModelCopyWithImpl<$Res, _$BureauModelImpl>
    implements _$$BureauModelImplCopyWith<$Res> {
  __$$BureauModelImplCopyWithImpl(
      _$BureauModelImpl _value, $Res Function(_$BureauModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BureauModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? numero = freezed,
    Object? centre = freezed,
  }) {
    return _then(_$BureauModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      numero: freezed == numero
          ? _value.numero
          : numero // ignore: cast_nullable_to_non_nullable
              as String?,
      centre: freezed == centre
          ? _value.centre
          : centre // ignore: cast_nullable_to_non_nullable
              as CentreModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BureauModelImpl implements _BureauModel {
  const _$BureauModelImpl({this.id, this.numero, this.centre});

  factory _$BureauModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BureauModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? numero;
  @override
  final CentreModel? centre;

  @override
  String toString() {
    return 'BureauModel(id: $id, numero: $numero, centre: $centre)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BureauModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.numero, numero) || other.numero == numero) &&
            (identical(other.centre, centre) || other.centre == centre));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, numero, centre);

  /// Create a copy of BureauModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BureauModelImplCopyWith<_$BureauModelImpl> get copyWith =>
      __$$BureauModelImplCopyWithImpl<_$BureauModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BureauModelImplToJson(
      this,
    );
  }
}

abstract class _BureauModel implements BureauModel {
  const factory _BureauModel(
      {final int? id,
      final String? numero,
      final CentreModel? centre}) = _$BureauModelImpl;

  factory _BureauModel.fromJson(Map<String, dynamic> json) =
      _$BureauModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get numero;
  @override
  CentreModel? get centre;

  /// Create a copy of BureauModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BureauModelImplCopyWith<_$BureauModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CentreModel _$CentreModelFromJson(Map<String, dynamic> json) {
  return _CentreModel.fromJson(json);
}

/// @nodoc
mixin _$CentreModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get rue => throw _privateConstructorUsedError;
  String? get localisation => throw _privateConstructorUsedError;
  String? get avenue => throw _privateConstructorUsedError;
  String? get quartier => throw _privateConstructorUsedError;
  DistrictModel? get district => throw _privateConstructorUsedError;
  RegionModel? get region => throw _privateConstructorUsedError;
  DepartementModel? get departement => throw _privateConstructorUsedError;
  SousPrefectureModel? get sousPrefecture => throw _privateConstructorUsedError;
  CommuneModel? get commune => throw _privateConstructorUsedError;
  VillageModel? get village => throw _privateConstructorUsedError;

  /// Serializes this CentreModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CentreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CentreModelCopyWith<CentreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CentreModelCopyWith<$Res> {
  factory $CentreModelCopyWith(
          CentreModel value, $Res Function(CentreModel) then) =
      _$CentreModelCopyWithImpl<$Res, CentreModel>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? rue,
      String? localisation,
      String? avenue,
      String? quartier,
      DistrictModel? district,
      RegionModel? region,
      DepartementModel? departement,
      SousPrefectureModel? sousPrefecture,
      CommuneModel? commune,
      VillageModel? village});

  $DistrictModelCopyWith<$Res>? get district;
  $RegionModelCopyWith<$Res>? get region;
  $DepartementModelCopyWith<$Res>? get departement;
  $SousPrefectureModelCopyWith<$Res>? get sousPrefecture;
  $CommuneModelCopyWith<$Res>? get commune;
  $VillageModelCopyWith<$Res>? get village;
}

/// @nodoc
class _$CentreModelCopyWithImpl<$Res, $Val extends CentreModel>
    implements $CentreModelCopyWith<$Res> {
  _$CentreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CentreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? rue = freezed,
    Object? localisation = freezed,
    Object? avenue = freezed,
    Object? quartier = freezed,
    Object? district = freezed,
    Object? region = freezed,
    Object? departement = freezed,
    Object? sousPrefecture = freezed,
    Object? commune = freezed,
    Object? village = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      rue: freezed == rue
          ? _value.rue
          : rue // ignore: cast_nullable_to_non_nullable
              as String?,
      localisation: freezed == localisation
          ? _value.localisation
          : localisation // ignore: cast_nullable_to_non_nullable
              as String?,
      avenue: freezed == avenue
          ? _value.avenue
          : avenue // ignore: cast_nullable_to_non_nullable
              as String?,
      quartier: freezed == quartier
          ? _value.quartier
          : quartier // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as DistrictModel?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as RegionModel?,
      departement: freezed == departement
          ? _value.departement
          : departement // ignore: cast_nullable_to_non_nullable
              as DepartementModel?,
      sousPrefecture: freezed == sousPrefecture
          ? _value.sousPrefecture
          : sousPrefecture // ignore: cast_nullable_to_non_nullable
              as SousPrefectureModel?,
      commune: freezed == commune
          ? _value.commune
          : commune // ignore: cast_nullable_to_non_nullable
              as CommuneModel?,
      village: freezed == village
          ? _value.village
          : village // ignore: cast_nullable_to_non_nullable
              as VillageModel?,
    ) as $Val);
  }

  /// Create a copy of CentreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DistrictModelCopyWith<$Res>? get district {
    if (_value.district == null) {
      return null;
    }

    return $DistrictModelCopyWith<$Res>(_value.district!, (value) {
      return _then(_value.copyWith(district: value) as $Val);
    });
  }

  /// Create a copy of CentreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RegionModelCopyWith<$Res>? get region {
    if (_value.region == null) {
      return null;
    }

    return $RegionModelCopyWith<$Res>(_value.region!, (value) {
      return _then(_value.copyWith(region: value) as $Val);
    });
  }

  /// Create a copy of CentreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DepartementModelCopyWith<$Res>? get departement {
    if (_value.departement == null) {
      return null;
    }

    return $DepartementModelCopyWith<$Res>(_value.departement!, (value) {
      return _then(_value.copyWith(departement: value) as $Val);
    });
  }

  /// Create a copy of CentreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SousPrefectureModelCopyWith<$Res>? get sousPrefecture {
    if (_value.sousPrefecture == null) {
      return null;
    }

    return $SousPrefectureModelCopyWith<$Res>(_value.sousPrefecture!, (value) {
      return _then(_value.copyWith(sousPrefecture: value) as $Val);
    });
  }

  /// Create a copy of CentreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommuneModelCopyWith<$Res>? get commune {
    if (_value.commune == null) {
      return null;
    }

    return $CommuneModelCopyWith<$Res>(_value.commune!, (value) {
      return _then(_value.copyWith(commune: value) as $Val);
    });
  }

  /// Create a copy of CentreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VillageModelCopyWith<$Res>? get village {
    if (_value.village == null) {
      return null;
    }

    return $VillageModelCopyWith<$Res>(_value.village!, (value) {
      return _then(_value.copyWith(village: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CentreModelImplCopyWith<$Res>
    implements $CentreModelCopyWith<$Res> {
  factory _$$CentreModelImplCopyWith(
          _$CentreModelImpl value, $Res Function(_$CentreModelImpl) then) =
      __$$CentreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? rue,
      String? localisation,
      String? avenue,
      String? quartier,
      DistrictModel? district,
      RegionModel? region,
      DepartementModel? departement,
      SousPrefectureModel? sousPrefecture,
      CommuneModel? commune,
      VillageModel? village});

  @override
  $DistrictModelCopyWith<$Res>? get district;
  @override
  $RegionModelCopyWith<$Res>? get region;
  @override
  $DepartementModelCopyWith<$Res>? get departement;
  @override
  $SousPrefectureModelCopyWith<$Res>? get sousPrefecture;
  @override
  $CommuneModelCopyWith<$Res>? get commune;
  @override
  $VillageModelCopyWith<$Res>? get village;
}

/// @nodoc
class __$$CentreModelImplCopyWithImpl<$Res>
    extends _$CentreModelCopyWithImpl<$Res, _$CentreModelImpl>
    implements _$$CentreModelImplCopyWith<$Res> {
  __$$CentreModelImplCopyWithImpl(
      _$CentreModelImpl _value, $Res Function(_$CentreModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CentreModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? rue = freezed,
    Object? localisation = freezed,
    Object? avenue = freezed,
    Object? quartier = freezed,
    Object? district = freezed,
    Object? region = freezed,
    Object? departement = freezed,
    Object? sousPrefecture = freezed,
    Object? commune = freezed,
    Object? village = freezed,
  }) {
    return _then(_$CentreModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      rue: freezed == rue
          ? _value.rue
          : rue // ignore: cast_nullable_to_non_nullable
              as String?,
      localisation: freezed == localisation
          ? _value.localisation
          : localisation // ignore: cast_nullable_to_non_nullable
              as String?,
      avenue: freezed == avenue
          ? _value.avenue
          : avenue // ignore: cast_nullable_to_non_nullable
              as String?,
      quartier: freezed == quartier
          ? _value.quartier
          : quartier // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as DistrictModel?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as RegionModel?,
      departement: freezed == departement
          ? _value.departement
          : departement // ignore: cast_nullable_to_non_nullable
              as DepartementModel?,
      sousPrefecture: freezed == sousPrefecture
          ? _value.sousPrefecture
          : sousPrefecture // ignore: cast_nullable_to_non_nullable
              as SousPrefectureModel?,
      commune: freezed == commune
          ? _value.commune
          : commune // ignore: cast_nullable_to_non_nullable
              as CommuneModel?,
      village: freezed == village
          ? _value.village
          : village // ignore: cast_nullable_to_non_nullable
              as VillageModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CentreModelImpl implements _CentreModel {
  const _$CentreModelImpl(
      {this.id,
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
      this.village});

  factory _$CentreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CentreModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? rue;
  @override
  final String? localisation;
  @override
  final String? avenue;
  @override
  final String? quartier;
  @override
  final DistrictModel? district;
  @override
  final RegionModel? region;
  @override
  final DepartementModel? departement;
  @override
  final SousPrefectureModel? sousPrefecture;
  @override
  final CommuneModel? commune;
  @override
  final VillageModel? village;

  @override
  String toString() {
    return 'CentreModel(id: $id, name: $name, rue: $rue, localisation: $localisation, avenue: $avenue, quartier: $quartier, district: $district, region: $region, departement: $departement, sousPrefecture: $sousPrefecture, commune: $commune, village: $village)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CentreModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rue, rue) || other.rue == rue) &&
            (identical(other.localisation, localisation) ||
                other.localisation == localisation) &&
            (identical(other.avenue, avenue) || other.avenue == avenue) &&
            (identical(other.quartier, quartier) ||
                other.quartier == quartier) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.departement, departement) ||
                other.departement == departement) &&
            (identical(other.sousPrefecture, sousPrefecture) ||
                other.sousPrefecture == sousPrefecture) &&
            (identical(other.commune, commune) || other.commune == commune) &&
            (identical(other.village, village) || other.village == village));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      rue,
      localisation,
      avenue,
      quartier,
      district,
      region,
      departement,
      sousPrefecture,
      commune,
      village);

  /// Create a copy of CentreModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CentreModelImplCopyWith<_$CentreModelImpl> get copyWith =>
      __$$CentreModelImplCopyWithImpl<_$CentreModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CentreModelImplToJson(
      this,
    );
  }
}

abstract class _CentreModel implements CentreModel {
  const factory _CentreModel(
      {final int? id,
      final String? name,
      final String? rue,
      final String? localisation,
      final String? avenue,
      final String? quartier,
      final DistrictModel? district,
      final RegionModel? region,
      final DepartementModel? departement,
      final SousPrefectureModel? sousPrefecture,
      final CommuneModel? commune,
      final VillageModel? village}) = _$CentreModelImpl;

  factory _CentreModel.fromJson(Map<String, dynamic> json) =
      _$CentreModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get rue;
  @override
  String? get localisation;
  @override
  String? get avenue;
  @override
  String? get quartier;
  @override
  DistrictModel? get district;
  @override
  RegionModel? get region;
  @override
  DepartementModel? get departement;
  @override
  SousPrefectureModel? get sousPrefecture;
  @override
  CommuneModel? get commune;
  @override
  VillageModel? get village;

  /// Create a copy of CentreModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CentreModelImplCopyWith<_$CentreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DistrictModel _$DistrictModelFromJson(Map<String, dynamic> json) {
  return _DistrictModel.fromJson(json);
}

/// @nodoc
mixin _$DistrictModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this DistrictModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DistrictModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DistrictModelCopyWith<DistrictModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistrictModelCopyWith<$Res> {
  factory $DistrictModelCopyWith(
          DistrictModel value, $Res Function(DistrictModel) then) =
      _$DistrictModelCopyWithImpl<$Res, DistrictModel>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$DistrictModelCopyWithImpl<$Res, $Val extends DistrictModel>
    implements $DistrictModelCopyWith<$Res> {
  _$DistrictModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DistrictModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DistrictModelImplCopyWith<$Res>
    implements $DistrictModelCopyWith<$Res> {
  factory _$$DistrictModelImplCopyWith(
          _$DistrictModelImpl value, $Res Function(_$DistrictModelImpl) then) =
      __$$DistrictModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$DistrictModelImplCopyWithImpl<$Res>
    extends _$DistrictModelCopyWithImpl<$Res, _$DistrictModelImpl>
    implements _$$DistrictModelImplCopyWith<$Res> {
  __$$DistrictModelImplCopyWithImpl(
      _$DistrictModelImpl _value, $Res Function(_$DistrictModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DistrictModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$DistrictModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DistrictModelImpl implements _DistrictModel {
  const _$DistrictModelImpl({this.id, this.name});

  factory _$DistrictModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DistrictModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'DistrictModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DistrictModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of DistrictModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DistrictModelImplCopyWith<_$DistrictModelImpl> get copyWith =>
      __$$DistrictModelImplCopyWithImpl<_$DistrictModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DistrictModelImplToJson(
      this,
    );
  }
}

abstract class _DistrictModel implements DistrictModel {
  const factory _DistrictModel({final int? id, final String? name}) =
      _$DistrictModelImpl;

  factory _DistrictModel.fromJson(Map<String, dynamic> json) =
      _$DistrictModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of DistrictModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DistrictModelImplCopyWith<_$DistrictModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RegionModel _$RegionModelFromJson(Map<String, dynamic> json) {
  return _RegionModel.fromJson(json);
}

/// @nodoc
mixin _$RegionModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this RegionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegionModelCopyWith<RegionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegionModelCopyWith<$Res> {
  factory $RegionModelCopyWith(
          RegionModel value, $Res Function(RegionModel) then) =
      _$RegionModelCopyWithImpl<$Res, RegionModel>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$RegionModelCopyWithImpl<$Res, $Val extends RegionModel>
    implements $RegionModelCopyWith<$Res> {
  _$RegionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegionModelImplCopyWith<$Res>
    implements $RegionModelCopyWith<$Res> {
  factory _$$RegionModelImplCopyWith(
          _$RegionModelImpl value, $Res Function(_$RegionModelImpl) then) =
      __$$RegionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$RegionModelImplCopyWithImpl<$Res>
    extends _$RegionModelCopyWithImpl<$Res, _$RegionModelImpl>
    implements _$$RegionModelImplCopyWith<$Res> {
  __$$RegionModelImplCopyWithImpl(
      _$RegionModelImpl _value, $Res Function(_$RegionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$RegionModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegionModelImpl implements _RegionModel {
  const _$RegionModelImpl({this.id, this.name});

  factory _$RegionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegionModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'RegionModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of RegionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegionModelImplCopyWith<_$RegionModelImpl> get copyWith =>
      __$$RegionModelImplCopyWithImpl<_$RegionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegionModelImplToJson(
      this,
    );
  }
}

abstract class _RegionModel implements RegionModel {
  const factory _RegionModel({final int? id, final String? name}) =
      _$RegionModelImpl;

  factory _RegionModel.fromJson(Map<String, dynamic> json) =
      _$RegionModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of RegionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegionModelImplCopyWith<_$RegionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DepartementModel _$DepartementModelFromJson(Map<String, dynamic> json) {
  return _DepartementModel.fromJson(json);
}

/// @nodoc
mixin _$DepartementModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this DepartementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DepartementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DepartementModelCopyWith<DepartementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepartementModelCopyWith<$Res> {
  factory $DepartementModelCopyWith(
          DepartementModel value, $Res Function(DepartementModel) then) =
      _$DepartementModelCopyWithImpl<$Res, DepartementModel>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$DepartementModelCopyWithImpl<$Res, $Val extends DepartementModel>
    implements $DepartementModelCopyWith<$Res> {
  _$DepartementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DepartementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DepartementModelImplCopyWith<$Res>
    implements $DepartementModelCopyWith<$Res> {
  factory _$$DepartementModelImplCopyWith(_$DepartementModelImpl value,
          $Res Function(_$DepartementModelImpl) then) =
      __$$DepartementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$DepartementModelImplCopyWithImpl<$Res>
    extends _$DepartementModelCopyWithImpl<$Res, _$DepartementModelImpl>
    implements _$$DepartementModelImplCopyWith<$Res> {
  __$$DepartementModelImplCopyWithImpl(_$DepartementModelImpl _value,
      $Res Function(_$DepartementModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DepartementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$DepartementModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DepartementModelImpl implements _DepartementModel {
  const _$DepartementModelImpl({this.id, this.name});

  factory _$DepartementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DepartementModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'DepartementModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DepartementModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of DepartementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DepartementModelImplCopyWith<_$DepartementModelImpl> get copyWith =>
      __$$DepartementModelImplCopyWithImpl<_$DepartementModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DepartementModelImplToJson(
      this,
    );
  }
}

abstract class _DepartementModel implements DepartementModel {
  const factory _DepartementModel({final int? id, final String? name}) =
      _$DepartementModelImpl;

  factory _DepartementModel.fromJson(Map<String, dynamic> json) =
      _$DepartementModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of DepartementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DepartementModelImplCopyWith<_$DepartementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SousPrefectureModel _$SousPrefectureModelFromJson(Map<String, dynamic> json) {
  return _SousPrefectureModel.fromJson(json);
}

/// @nodoc
mixin _$SousPrefectureModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this SousPrefectureModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SousPrefectureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SousPrefectureModelCopyWith<SousPrefectureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SousPrefectureModelCopyWith<$Res> {
  factory $SousPrefectureModelCopyWith(
          SousPrefectureModel value, $Res Function(SousPrefectureModel) then) =
      _$SousPrefectureModelCopyWithImpl<$Res, SousPrefectureModel>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$SousPrefectureModelCopyWithImpl<$Res, $Val extends SousPrefectureModel>
    implements $SousPrefectureModelCopyWith<$Res> {
  _$SousPrefectureModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SousPrefectureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SousPrefectureModelImplCopyWith<$Res>
    implements $SousPrefectureModelCopyWith<$Res> {
  factory _$$SousPrefectureModelImplCopyWith(_$SousPrefectureModelImpl value,
          $Res Function(_$SousPrefectureModelImpl) then) =
      __$$SousPrefectureModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$SousPrefectureModelImplCopyWithImpl<$Res>
    extends _$SousPrefectureModelCopyWithImpl<$Res, _$SousPrefectureModelImpl>
    implements _$$SousPrefectureModelImplCopyWith<$Res> {
  __$$SousPrefectureModelImplCopyWithImpl(_$SousPrefectureModelImpl _value,
      $Res Function(_$SousPrefectureModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SousPrefectureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$SousPrefectureModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SousPrefectureModelImpl implements _SousPrefectureModel {
  const _$SousPrefectureModelImpl({this.id, this.name});

  factory _$SousPrefectureModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SousPrefectureModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'SousPrefectureModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SousPrefectureModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of SousPrefectureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SousPrefectureModelImplCopyWith<_$SousPrefectureModelImpl> get copyWith =>
      __$$SousPrefectureModelImplCopyWithImpl<_$SousPrefectureModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SousPrefectureModelImplToJson(
      this,
    );
  }
}

abstract class _SousPrefectureModel implements SousPrefectureModel {
  const factory _SousPrefectureModel({final int? id, final String? name}) =
      _$SousPrefectureModelImpl;

  factory _SousPrefectureModel.fromJson(Map<String, dynamic> json) =
      _$SousPrefectureModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of SousPrefectureModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SousPrefectureModelImplCopyWith<_$SousPrefectureModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CommuneModel _$CommuneModelFromJson(Map<String, dynamic> json) {
  return _CommuneModel.fromJson(json);
}

/// @nodoc
mixin _$CommuneModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this CommuneModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommuneModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommuneModelCopyWith<CommuneModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommuneModelCopyWith<$Res> {
  factory $CommuneModelCopyWith(
          CommuneModel value, $Res Function(CommuneModel) then) =
      _$CommuneModelCopyWithImpl<$Res, CommuneModel>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$CommuneModelCopyWithImpl<$Res, $Val extends CommuneModel>
    implements $CommuneModelCopyWith<$Res> {
  _$CommuneModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommuneModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommuneModelImplCopyWith<$Res>
    implements $CommuneModelCopyWith<$Res> {
  factory _$$CommuneModelImplCopyWith(
          _$CommuneModelImpl value, $Res Function(_$CommuneModelImpl) then) =
      __$$CommuneModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$CommuneModelImplCopyWithImpl<$Res>
    extends _$CommuneModelCopyWithImpl<$Res, _$CommuneModelImpl>
    implements _$$CommuneModelImplCopyWith<$Res> {
  __$$CommuneModelImplCopyWithImpl(
      _$CommuneModelImpl _value, $Res Function(_$CommuneModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommuneModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$CommuneModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommuneModelImpl implements _CommuneModel {
  const _$CommuneModelImpl({this.id, this.name});

  factory _$CommuneModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommuneModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'CommuneModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommuneModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of CommuneModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommuneModelImplCopyWith<_$CommuneModelImpl> get copyWith =>
      __$$CommuneModelImplCopyWithImpl<_$CommuneModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommuneModelImplToJson(
      this,
    );
  }
}

abstract class _CommuneModel implements CommuneModel {
  const factory _CommuneModel({final int? id, final String? name}) =
      _$CommuneModelImpl;

  factory _CommuneModel.fromJson(Map<String, dynamic> json) =
      _$CommuneModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of CommuneModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommuneModelImplCopyWith<_$CommuneModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VillageModel _$VillageModelFromJson(Map<String, dynamic> json) {
  return _VillageModel.fromJson(json);
}

/// @nodoc
mixin _$VillageModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this VillageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VillageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VillageModelCopyWith<VillageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VillageModelCopyWith<$Res> {
  factory $VillageModelCopyWith(
          VillageModel value, $Res Function(VillageModel) then) =
      _$VillageModelCopyWithImpl<$Res, VillageModel>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$VillageModelCopyWithImpl<$Res, $Val extends VillageModel>
    implements $VillageModelCopyWith<$Res> {
  _$VillageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VillageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VillageModelImplCopyWith<$Res>
    implements $VillageModelCopyWith<$Res> {
  factory _$$VillageModelImplCopyWith(
          _$VillageModelImpl value, $Res Function(_$VillageModelImpl) then) =
      __$$VillageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$VillageModelImplCopyWithImpl<$Res>
    extends _$VillageModelCopyWithImpl<$Res, _$VillageModelImpl>
    implements _$$VillageModelImplCopyWith<$Res> {
  __$$VillageModelImplCopyWithImpl(
      _$VillageModelImpl _value, $Res Function(_$VillageModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VillageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$VillageModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VillageModelImpl implements _VillageModel {
  const _$VillageModelImpl({this.id, this.name});

  factory _$VillageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VillageModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'VillageModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VillageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of VillageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VillageModelImplCopyWith<_$VillageModelImpl> get copyWith =>
      __$$VillageModelImplCopyWithImpl<_$VillageModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VillageModelImplToJson(
      this,
    );
  }
}

abstract class _VillageModel implements VillageModel {
  const factory _VillageModel({final int? id, final String? name}) =
      _$VillageModelImpl;

  factory _VillageModel.fromJson(Map<String, dynamic> json) =
      _$VillageModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of VillageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VillageModelImplCopyWith<_$VillageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnneeModel _$AnneeModelFromJson(Map<String, dynamic> json) {
  return _AnneeModel.fromJson(json);
}

/// @nodoc
mixin _$AnneeModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this AnneeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnneeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnneeModelCopyWith<AnneeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnneeModelCopyWith<$Res> {
  factory $AnneeModelCopyWith(
          AnneeModel value, $Res Function(AnneeModel) then) =
      _$AnneeModelCopyWithImpl<$Res, AnneeModel>;
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class _$AnneeModelCopyWithImpl<$Res, $Val extends AnneeModel>
    implements $AnneeModelCopyWith<$Res> {
  _$AnneeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnneeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnneeModelImplCopyWith<$Res>
    implements $AnneeModelCopyWith<$Res> {
  factory _$$AnneeModelImplCopyWith(
          _$AnneeModelImpl value, $Res Function(_$AnneeModelImpl) then) =
      __$$AnneeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name});
}

/// @nodoc
class __$$AnneeModelImplCopyWithImpl<$Res>
    extends _$AnneeModelCopyWithImpl<$Res, _$AnneeModelImpl>
    implements _$$AnneeModelImplCopyWith<$Res> {
  __$$AnneeModelImplCopyWithImpl(
      _$AnneeModelImpl _value, $Res Function(_$AnneeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnneeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$AnneeModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnneeModelImpl implements _AnneeModel {
  const _$AnneeModelImpl({this.id, this.name});

  factory _$AnneeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnneeModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'AnneeModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnneeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of AnneeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnneeModelImplCopyWith<_$AnneeModelImpl> get copyWith =>
      __$$AnneeModelImplCopyWithImpl<_$AnneeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnneeModelImplToJson(
      this,
    );
  }
}

abstract class _AnneeModel implements AnneeModel {
  const factory _AnneeModel({final int? id, final String? name}) =
      _$AnneeModelImpl;

  factory _AnneeModel.fromJson(Map<String, dynamic> json) =
      _$AnneeModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;

  /// Create a copy of AnneeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnneeModelImplCopyWith<_$AnneeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
