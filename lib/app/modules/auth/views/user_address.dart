// ignore_for_file: prefer_relative_imports

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/modules/auth/views/otp_verification.dart';
import 'package:home_services_provider/app/modules/auth/views/service_provider/freelance_service.dart';
import 'package:home_services_provider/app/modules/e_services/controllers/e_service_form_controller.dart';

import 'package:home_services_provider/app/modules/global_widgets/block_button_widget.dart';
import 'package:home_services_provider/app/modules/global_widgets/text_field_widget.dart';
import 'package:home_services_provider/app/repositories/user_repository.dart';
import 'package:home_services_provider/app/routes/app_routes.dart';
import 'package:home_services_provider/app/services/settings_service.dart';

import '../controllers/auth_controller.dart';

class UserAddress extends StatefulWidget {
  UserAddress({Key key, this.isFreelancer}) : super(key: key);
  final bool isFreelancer;

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  AuthController controller = AuthController();
  UserRepository _userRepository = UserRepository();
  final addressFormKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBar = MediaQuery.of(context).padding.top;
    // final double topContainer = 180;
    final double extraHeight = 90;
    final double mainContainer = screenHeight - statusBar - extraHeight;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              height: screenHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/background.png',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Container(
            height: 180,
            width: Get.width,
            decoration: BoxDecoration(
              color: Color(0xffFF8503),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                'Address',
                style: Get.textTheme.headline1,
              ),
            ),
          ),
          Form(
            key: addressFormKey,
            child: Container(
              margin: EdgeInsets.only(top: 120),
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: mainContainer,
              width: Get.width,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                ),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'National Address: Region',
                          style: Get.textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          bgColor: Color(0xffF2F2F2),
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          radius: BorderRadius.circular(9),
                          style: TextStyle(fontSize: 14),
                          cursorHeight: 20,
                          initialValue: controller.currentUser?.value?.region,
                          onChanged: (input) =>
                              controller.currentUser.value.region = input,
                          validator: (input) =>
                              input.isEmpty ? "Region is required".tr : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'City',
                          style: Get.textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          bgColor: Color(0xffF2F2F2),
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          radius: BorderRadius.circular(9),
                          style: TextStyle(fontSize: 14),
                          cursorHeight: 20,
                          initialValue: controller.currentUser?.value?.city,
                          onChanged: (input) =>
                              controller.currentUser.value.city = input,
                          validator: (input) =>
                              input.isEmpty ? "City is required".tr : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Postal Code',
                          style: Get.textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          bgColor: Color(0xffF2F2F2),
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          radius: BorderRadius.circular(9),
                          style: TextStyle(fontSize: 14),
                          cursorHeight: 20,
                          keyboardType: TextInputType.number,
                          initialValue:
                              controller.currentUser?.value?.postalCode,
                          onChanged: (input) =>
                              controller.currentUser.value.postalCode = input,
                          validator: (input) => input.isEmpty
                              ? "Postal code is required".tr
                              : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'District',
                          style: Get.textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          bgColor: Color(0xffF2F2F2),
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          radius: BorderRadius.circular(9),
                          style: TextStyle(fontSize: 14),
                          cursorHeight: 20,
                          initialValue: controller.currentUser?.value?.district,
                          onChanged: (input) =>
                              controller.currentUser.value.district = input,
                          validator: (input) =>
                              input.isEmpty ? "District is required".tr : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Street',
                          style: Get.textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          bgColor: Color(0xffF2F2F2),
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          radius: BorderRadius.circular(9),
                          style: TextStyle(fontSize: 14),
                          cursorHeight: 20,
                          initialValue: controller.currentUser?.value?.street,
                          onChanged: (input) =>
                              controller.currentUser.value.street = input,
                          validator: (input) =>
                              input.isEmpty ? "Street is required".tr : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Building Number',
                          style: Get.textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          bgColor: Color(0xffF2F2F2),
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          radius: BorderRadius.circular(9),
                          style: TextStyle(fontSize: 14),
                          cursorHeight: 20,
                          initialValue:
                              controller.currentUser?.value?.buildingNumber,
                          onChanged: (input) => controller
                              .currentUser.value.buildingNumber = input,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'House Number',
                          style: Get.textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFieldWidget(
                          bgColor: Color(0xffF2F2F2),
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          radius: BorderRadius.circular(9),
                          style: TextStyle(fontSize: 14),
                          cursorHeight: 20,
                          initialValue:
                              controller.currentUser?.value?.additionalNumber,
                          onChanged: (input) => controller
                              .currentUser.value.additionalNumber = input,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 40,
                          width: Get.width,
                          child: BlockButtonWidget(
                            color: Get.theme.colorScheme.secondary,
                            text: Text('Submit',
                                style: Get.textTheme.headline6.merge(
                                    TextStyle(color: Get.theme.primaryColor))),
                            onPressed: () async {
                              if (addressFormKey.currentState.validate()) {
                                if (Get.find<SettingsService>()
                                    .setting
                                    .value
                                    .enableOtp) {
                                  await _userRepository.sendCodeToPhone();
                                  if (widget.isFreelancer) {
                                    await Get.put(EServiceFormController());
                                    await Get.toNamed(Routes.BECOME_PROVIDER);
                                  } else {
                                    await Get.toNamed(Routes.OTP_VERIFICATION);
                                  }
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
