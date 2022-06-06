import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../global_widgets/block_button_widget.dart';
import '../../home/views/home_view.dart';
import '../../settings/widgets/text_field.dart';
import 'selection.dart';
import 'otp_verification.dart';

class RegistrationReview extends StatefulWidget {
  const RegistrationReview({Key key}) : super(key: key);

  @override
  State<RegistrationReview> createState() => _RegistrationReviewState();
}

class _RegistrationReviewState extends State<RegistrationReview> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBar = MediaQuery.of(context).padding.top;
    // final double topContainer = 180;
    final double extraHeight = 90;
    final double mainContainer = screenHeight - statusBar - extraHeight;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/images/background.png',
              ),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
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
                  'Registration Complete',
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                ),
                elevation: 10,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Image.asset('assets/images/complete.png', alignment: Alignment.center),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Your Registration has been submitted Successfuly !',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'We will process your registration and you will be informed once it is approved!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Thank you so much, and have a nice day.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 90,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 45,
                      width: Get.width,
                      child: BlockButtonWidget(
                          color: Get.theme.colorScheme.secondary,
                          text: Text(
                            'Done',
                            style: Get.textTheme.headline6.merge(
                              TextStyle(color: Get.theme.primaryColor),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.LOGIN);
                          }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
