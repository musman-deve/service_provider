import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/modules/global_widgets/block_button_widget.dart';
import 'package:home_services_provider/app/modules/global_widgets/text_field_widget.dart';
import 'package:home_services_provider/app/modules/settings/widgets/text_field.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/auth_controller.dart';
import '../registration_review.dart';

class FreelanceService extends StatefulWidget {
  const FreelanceService({Key key}) : super(key: key);

  @override
  State<FreelanceService> createState() => _FreelanceServiceState();
}

class _FreelanceServiceState extends State<FreelanceService> {
  AuthController controller = AuthController();
  int _groupValue = -1;
  File imageFile;
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(source: ImageSource.gallery, maxWidth: 600, maxHeight: 200);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 500,
      maxWidth: 600,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  List categoties = [
    'Category1',
    'Category2',
    'Category3',
  ];
  List Subcategoties = [
    'Sub-Category1',
    'Sub-Category2',
    'Sub-Category3',
  ];
  String _dropDownValue;
  String _dropDownValue2;
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
          Form(
            key: controller.registerFormKey,
            child: Container(
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
                  'Services You Provide',
                  style: Get.textTheme.headline1,
                ),
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
                  topRight: Radius.circular(25),
                ),
              ),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Services Category',
                        style: Get.textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton(
                            underline: SizedBox(),
                            hint: _dropDownValue == null
                                ? Text('')
                                : Text(
                                    _dropDownValue,
                                    style: TextStyle(color: Colors.black87),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.black87),
                            items: categoties.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  _dropDownValue = val;
                                },
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Services Sub-Category',
                        style: Get.textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Color(0xffF2F2F2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton(
                            underline: SizedBox(),
                            hint: _dropDownValue2 == null
                                ? Text('')
                                : Text(
                                    _dropDownValue2,
                                    style: TextStyle(color: Colors.black87),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(color: Colors.black87),
                            items: Subcategoties.map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  _dropDownValue2 = val;
                                },
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Service Name',
                        style: Get.textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                        bgColor: Color(0xffF2F2F2),
                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        radius: BorderRadius.circular(9),
                        style: TextStyle(fontSize: 14),
                        cursorHeight: 20,
                        initialValue: controller.currentUser?.value?.email,
                        onSaved: (input) => controller.currentUser.value.email = input,
                        validator: (input) => input.isEmpty ? "Service name is required".tr : null,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Price Role',
                        style: Get.textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              value: 0,
                              groupValue: _groupValue,
                              title: Text("Fixed"),
                              onChanged: (newValue) => setState(() => _groupValue = newValue),
                              activeColor: Colors.orange,
                              selected: false,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              value: 1,
                              groupValue: _groupValue,
                              title: Text("Hourly"),
                              onChanged: (newValue) => setState(() => _groupValue = newValue),
                              activeColor: Colors.orange,
                              selected: false,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Service Description',
                        style: Get.textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                        bgColor: Color(0xffF2F2F2),
                        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        radius: BorderRadius.circular(9),
                        style: TextStyle(fontSize: 14),
                        keyboardType: TextInputType.multiline,
                        cursorHeight: 20,
                        initialValue: controller.currentUser?.value?.email,
                        onSaved: (input) => controller.currentUser.value.email = input,
                        validator: (input) => input.length < 150 ? "Min. 150 characters".tr : null,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Additional Service',
                            style: Get.textTheme.bodyText1,
                          ),
                          Text(
                            '(Upload upto 3 images)',
                            style: Get.textTheme.bodyText1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      imageFile == null
                          ? GestureDetector(
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    height: 120,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: const Icon(
                                            Icons.camera_alt,
                                            color: Color(0xffFF8503),
                                          ),
                                          title: Text('Camera',
                                              style: TextStyle(
                                                  fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
                                          onTap: () {
                                            // getImage();
                                            _getFromCamera();
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(
                                            Icons.camera,
                                            color: Color(0xffFF8503),
                                          ),
                                          title: Text('Gallery',
                                              style: TextStyle(
                                                  fontSize: 14, color: Colors.black87, fontWeight: FontWeight.w500)),
                                          onTap: () {
                                            // getImage();
                                            _getFromGallery();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.camera,
                                      color: Colors.grey.shade400,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Select Image',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                width: Get.width,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Color(0xffF2F2F2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            )
                          : Container(
                              width: Get.width,
                              height: 150,
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                              )),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 40,
                        width: Get.width,
                        child: BlockButtonWidget(
                            color: Get.theme.colorScheme.secondary,
                            text: Text('Submit',
                                style: Get.textTheme.headline6.merge(TextStyle(color: Get.theme.primaryColor))),
                            onPressed: () {
                              Get.to(() => RegistrationReview()); //// new screen here
                            }),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
