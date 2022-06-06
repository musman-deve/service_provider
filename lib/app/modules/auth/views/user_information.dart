import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/models/role_model.dart';
import 'package:home_services_provider/app/modules/auth/views/user_address.dart';
import 'package:home_services_provider/app/modules/global_widgets/text_field_widget.dart';
import 'package:home_services_provider/app/repositories/user_repository.dart';
import 'package:home_services_provider/app/routes/app_routes.dart';
import 'package:home_services_provider/app/services/settings_service.dart';

import '../../global_widgets/block_button_widget.dart';

import '../controllers/auth_controller.dart';
import 'otp_verification.dart';
import '../../global_widgets/text_field_widget.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key key, this.isFreelancer}) : super(key: key);
  final bool isFreelancer;

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  AuthController controller = AuthController();
  final infoFormKey = new GlobalKey<FormState>();
  UserRepository _userRepository = UserRepository();
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
                  fit: BoxFit.cover,
                ),
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
                (widget.isFreelancer ?? false)
                    ? 'Freelancer Info'
                    : 'Customer Info',
                textAlign: TextAlign.center,
                style: Get.textTheme.headline1,
              ),
            ),
          ),
          Form(
            key: infoFormKey,
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
                          'Full Name',
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
                          hintText: 'Enter your full name',
                          showErrorBorder: false,
                          cursorHeight: 20,
                          initialValue: controller.currentUser?.value?.name,
                          onChanged: (input) =>
                              controller.currentUser.value.name = input,
                          validator: (input) =>
                              input.isEmpty ? "Full name is required".tr : null,
                        ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Text(
                        //   'Last Name',
                        //   style: Get.textTheme.bodyText1,
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextFieldWidget(
                        //   bgColor: Color(0xffF2F2F2),
                        //   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        //   radius: BorderRadius.circular(9),
                        //   style: TextStyle(fontSize: 14),
                        //   cursorHeight: 20,
                        //   initialValue: controller.currentUser?.value?.name,
                        //   onChanged: (input) => controller.currentUser.value.name = input,
                        //   validator: (input) => input.isEmpty ? "Last name is required".tr : null,
                        // ),
                        widget.isFreelancer
                            ? SizedBox(
                                height: 15,
                              )
                            : Container(),
                        widget.isFreelancer
                            ? Text(
                                'Freelancer ID number',
                                style: Get.textTheme.bodyText1,
                              )
                            : Container(),
                        widget.isFreelancer
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.isFreelancer
                            ? TextFieldWidget(
                                bgColor: Color(0xffF2F2F2),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 0),
                                radius: BorderRadius.circular(9),
                                style: TextStyle(fontSize: 14),
                                cursorHeight: 20,
                                hintText: 'Enter Freelancer Id',
                                initialValue:
                                    controller.currentUser?.value?.providerId,
                                onSaved: (input) => controller
                                    .currentUser.value.providerId = input,
                                validator: (input) => input.isEmpty
                                    ? "Freenlancer id is required".tr
                                    : null,
                              )
                            : Container(),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'User Name',
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
                          hintText: 'Choose a short username',
                          showErrorBorder: false,
                          cursorHeight: 20,
                          initialValue: controller.currentUser?.value?.userName,
                          onChanged: (input) =>
                              controller.currentUser.value.userName = input,
                          validator: (input) =>
                              input.isEmpty ? "User name is required".tr : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Phone Number',
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
                          showErrorBorder: false,
                          maxLength: 13,
                          cursorHeight: 20,
                          keyboardType: TextInputType.text,
                          initialValue:
                              controller.currentUser?.value?.phoneNumber,
                          hintText: 'Enter Phone Number',
                          onChanged: (input) {
                            controller.currentUser.value.phoneNumber = input;
                          },
                          validator: (input) => input.isEmpty
                              ? "Phone Number is required".tr
                              : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Email',
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
                          hintText: 'abcd@gmail.com',
                          showErrorBorder: false,
                          cursorHeight: 20,
                          initialValue: controller.currentUser?.value?.email,
                          onChanged: (input) =>
                              controller.currentUser.value.email = input,
                          validator: (input) => !input.contains('@')
                              ? "Enter a valid email address".tr
                              : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Password',
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
                          hintText: 'Enter a strong password',
                          showErrorBorder: false,
                          cursorHeight: 20,
                          obscureText: true,
                          initialValue: controller.currentUser?.value?.password,
                          onChanged: (input) =>
                              controller.currentUser.value.password = input,
                          validator: (input) =>
                              input.length < 6 ? "Min. 6 characters".tr : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Confirm Password',
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
                          hintText: 'Re-enter your password',
                          showErrorBorder: false,
                          cursorHeight: 20,
                          obscureText: true,
                          initialValue: controller.currentUser?.value?.password,
                          onChanged: (input) {
                            controller.currentUser.value.password = input;
                          },
                          validator: (input) =>
                              (controller.currentUser.value.password != input)
                                  ? "Password is not same".tr
                                  : null,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          height: 40,
                          width: Get.width,
                          child: BlockButtonWidget(
                            color: Get.theme.colorScheme.secondary,
                            text: Text(
                              'Submit',
                              style: Get.textTheme.headline6.merge(
                                TextStyle(color: Get.theme.primaryColor),
                              ),
                            ),
                            onPressed: () async {
                              widget.isFreelancer
                                  ? controller.currentUser.value.roles = [
                                      Role.fromJson({
                                        'id': 3,
                                        'name': 'provider',
                                        'default': true
                                      })
                                    ]
                                  : [
                                      Role.fromJson({
                                        'id': 4,
                                        'name': 'customer',
                                        'default': true
                                      })
                                    ];

                              if (infoFormKey.currentState.validate()) {
                                widget.isFreelancer
                                    ? Get.to(() => UserAddress(
                                          isFreelancer: widget.isFreelancer,
                                        ))
                                    : Get.toNamed(Routes.ADDRESS);
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
