import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:home_services_provider/app/modules/auth/views/user_address.dart';
import 'package:home_services_provider/app/modules/global_widgets/block_button_widget.dart';
import 'package:home_services_provider/app/modules/global_widgets/text_field_widget.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/auth_controller.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key key, this.isFreelancer}) : super(key: key);
  final bool isFreelancer;

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  AuthController controller = AuthController();
  String currentText;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBar = MediaQuery.of(context).padding.top;
    // final double topContainer = 180;
    // final double extraHeight = 90;
    final double mainContainer = screenHeight - statusBar;
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
                'OTP Verification',
                style: Get.textTheme.headline1,
              ),
            ),
          ),
          Container(
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
                    children: [
                      //// headerHeight
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: SvgPicture.asset(
                          'assets/images/otp.svg',
                          width: 400,
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                      'An authorization code has been send to your email address',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400)),
                                ),

                                TextFieldWidget(
                                  maxLength: 6,
                                  bgColor: Colors.white,
                                  hintText: "-   -   -   -   -   -".tr,
                                  style: Get.textTheme.headline4
                                      .merge(TextStyle(letterSpacing: 8)),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  onChanged: (input) =>
                                      controller.smsSent.value = input,
                                  // iconData: Icons.add_to_home_screen_outlined,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "I don't recieve code? ",
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.resendOTPCode();
                                      },
                                      child: Text('Resend Code',
                                          style: Get.textTheme.headline6),
                                    )
                                  ],
                                ),
                                // Align(
                                //   alignment: Alignment.center,
                                //   child: Text('01:30 sec left',
                                //       textAlign: TextAlign.center,
                                //       style: const TextStyle(
                                //           fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold)),
                                // ),
                                const SizedBox(height: 100),
                                SizedBox(
                                  height: 45,
                                  width: Get.width,
                                  child: BlockButtonWidget(
                                      color: Get.theme.colorScheme.secondary,
                                      text: Text('Verify',
                                          style: Get.textTheme.headline6.merge(
                                              TextStyle(
                                                  color:
                                                      Get.theme.primaryColor))),
                                      onPressed: () async {
                                        await controller.verifyPhone();
                                        widget.isFreelancer
                                            ? controller.register()
                                            : controller.providerRegister();
                                      }),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
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
