import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../common/uuid.dart';
import '../services/settings_service.dart';
import 'media_model.dart';
import 'parents/model.dart';
import 'role_model.dart';

class User extends Model {
  String name;
  String phoneVerifyAt;
  String catId;
  String subCatId;
  String serviceName;
  String serviceDesc;
  String priceRole;
  String email;
  String providerId;
  List<Media> images;
  String password;
  Media avatar;
  String apiToken;
  String deviceToken;
  String phoneNumber;
  bool verifiedPhone;
  String verificationId;
  String address;
  String region;
  String city;
  String district;
  String street;
  String buildingNumber;
  String postalCode;
  String additionalNumber;
  String userName;
  String bio;
  List<Role> roles;
  bool auth;

  User(
      {this.name,
      this.images,
      this.catId,
      this.subCatId,
      this.serviceName,
      this.serviceDesc,
      this.priceRole,
      this.email,
      this.phoneVerifyAt,
      this.password,
      this.providerId,
      this.apiToken,
      this.deviceToken,
      this.phoneNumber,
      this.verifiedPhone,
      this.verificationId,
      this.address,
      this.region,
      this.city,
      this.district,
      this.buildingNumber,
      this.postalCode,
      this.userName,
      this.bio,
      this.avatar,
      this.roles});

  User.fromJson(Map<String, dynamic> json) {
    name = stringFromJson(json, 'name');
    images = mediaListFromJson(json, 'additional_service');
    phoneVerifyAt = stringFromJson(json, 'phone_verified_at');
    email = stringFromJson(json, 'email');
    apiToken = stringFromJson(json, 'api_token');
    deviceToken = stringFromJson(json, 'device_token');
    phoneNumber = stringFromJson(json, 'phone_number');
    verifiedPhone = boolFromJson(json, 'phone_verified_at');

    catId = stringFromJson(json, 'service_category_id');
    subCatId = stringFromJson(json, 'service_sub_category_id');
    serviceName = stringFromJson(json, 'service_name');
    serviceDesc = stringFromJson(json, 'service_description');
    priceRole = stringFromJson(json, 'price_role');
    avatar = mediaFromJson(json, 'avatar');
    auth = boolFromJson(json, 'auth');
    roles = listFromJson(json, 'roles', (v) => Role.fromJson(v));
    try {
      address = json['custom_fields']['address']['view'];
    } catch (e) {
      address = stringFromJson(json, 'address');
    }
    try {
      bio = json['custom_fields']['bio']['view'];
    } catch (e) {
      bio = stringFromJson(json, 'bio');
    }
    region = stringFromJson(json, 'region');
    providerId = stringFromJson(json, 'service_provider_id');
    city = stringFromJson(json, 'city');
    district = stringFromJson(json, 'district');
    street = stringFromJson(json, 'street');
    buildingNumber = stringFromJson(json, 'building_number');
    postalCode = stringFromJson(json, 'postal_code');
    additionalNumber = stringFromJson(json, 'additional_number');
    userName = stringFromJson(json, 'user_name');
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;

    data['name'] = this.name;
    data['email'] = this.email;
    if (this.images != null) {
      data['additional_service'] = this
          .images
          .where((element) => Uuid.isUuid(element.id))
          .map((v) => v.id)
          .toList();
    }
    data['phone_verified_at'] = this.phoneVerifyAt;
    if (password != null && password != '') {
      data['password'] = this.password;
    }
    data['api_token'] = this.apiToken;
    if (deviceToken != null) {
      data["device_token"] = deviceToken;
    }
    data["phone_number"] = phoneNumber;
    if (verifiedPhone != null && verifiedPhone) {
      data["phone_verified_at"] = DateTime.now().toLocal().toString();
    }
    data["address"] = address;
    data["region"] = region;
    data['service_provider_id'] = providerId;
    data["city"] = city;
    data["district"] = district;

    data["service_category_id"] = catId;
    data["service_sub_category_id"] = subCatId;
    data['service_name'] = serviceName;
    data["price_role"] = priceRole;
    data["service_description"] = serviceDesc;

    data["street"] = street;
    data["building_number"] = buildingNumber;
    data["postal_code"] = postalCode;
    data["additional_number"] = additionalNumber;
    data["user_name"] = userName;

    data["bio"] = bio;
    if (this.avatar != null && Uuid.isUuid(avatar.id)) {
      data['avatar'] = this.avatar.id;
    }
    if (avatar != null) {
      data["media"] = [avatar.toJson()];
    }
    data['auth'] = this.auth;
    if (roles != null) {
      data['roles'] = this.roles.map((e) => e.toJson()).toList();
    }

    return data;
  }

  String get firstImageUrl => this.images?.first?.url ?? '';

  String get firstImageThumb => this.images?.first?.thumb ?? '';

  String get firstImageIcon => this.images?.first?.icon ?? '';

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["thumb"] = avatar.thumb;
    map["device_token"] = deviceToken;
    return map;
  }

  PhoneNumber getPhoneNumber() {
    if (this.phoneNumber != null && this.phoneNumber.length > 4) {
      this.phoneNumber = this.phoneNumber.replaceAll(' ', '');
      String dialCode1 = this.phoneNumber.substring(1, 2);
      String dialCode2 = this.phoneNumber.substring(1, 3);
      String dialCode3 = this.phoneNumber.substring(1, 4);
      for (int i = 0; i < countries.length; i++) {
        if (countries[i].dialCode == dialCode1) {
          return new PhoneNumber(
              countryISOCode: countries[i].code,
              countryCode: dialCode1,
              number: this.phoneNumber.substring(2));
        } else if (countries[i].dialCode == dialCode2) {
          return new PhoneNumber(
              countryISOCode: countries[i].code,
              countryCode: dialCode2,
              number: this.phoneNumber.substring(3));
        } else if (countries[i].dialCode == dialCode3) {
          return new PhoneNumber(
              countryISOCode: countries[i].code,
              countryCode: dialCode3,
              number: this.phoneNumber.substring(4));
        }
      }
    }
    return new PhoneNumber(
        countryISOCode:
            Get.find<SettingsService>().setting.value.defaultCountryCode,
        countryCode: '1',
        number: '');
  }

  bool get isAdmin =>
      (this.roles?.where((element) => element.name == 'admin')?.length ?? 0) >
      0;

  bool get isProvider =>
      (this
              .roles
              ?.where((element) =>
                  element.name == 'provider' || element.name == 'admin')
              ?.length ??
          0) >
      0;

  bool get isCustomer =>
      (this.roles?.where((element) => element.isdDefault)?.length ?? 0) > 0;

  @override
  bool operator ==(Object other) =>
      super == other &&
      other is User &&
      runtimeType == other.runtimeType &&
      name == other.name &&
      email == other.email &&
      password == other.password &&
      avatar == other.avatar &&
      apiToken == other.apiToken &&
      deviceToken == other.deviceToken &&
      phoneNumber == other.phoneNumber &&
      verifiedPhone == other.verifiedPhone &&
      verificationId == other.verificationId &&
      address == other.address &&
      region == other.region &&
      providerId == other.providerId &&
      city == other.city &&
      street == other.street &&
      district == other.district &&
      buildingNumber == other.buildingNumber &&
      postalCode == other.postalCode &&
      additionalNumber == other.additionalNumber &&
      userName == other.userName &&
      bio == other.bio &&
      roles == other.roles &&
      phoneVerifyAt == other.phoneVerifyAt &&
      auth == other.auth;

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      avatar.hashCode ^
      apiToken.hashCode ^
      deviceToken.hashCode ^
      phoneNumber.hashCode ^
      verifiedPhone.hashCode ^
      verificationId.hashCode ^
      address.hashCode ^
      region.hashCode ^
      bio.hashCode ^
      providerId.hashCode ^
      roles.hashCode ^
      phoneVerifyAt.hashCode ^
      city.hashCode ^
      district.hashCode ^
      street.hashCode ^
      buildingNumber.hashCode ^
      additionalNumber.hashCode ^
      postalCode.hashCode ^
      userName.hashCode ^
      auth.hashCode;
}
