import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/models/media_model.dart';
import 'package:home_services_provider/app/models/service_sub_categories_model.dart';
import 'package:home_services_provider/app/modules/e_services/controllers/e_service_form_controller.dart';
import 'package:home_services_provider/app/modules/global_widgets/block_button_widget.dart';
import 'package:home_services_provider/app/modules/global_widgets/images_field_widget.dart';
import 'package:home_services_provider/app/modules/global_widgets/text_field_widget.dart';
import 'package:home_services_provider/app/modules/settings/widgets/text_field.dart';
import 'package:home_services_provider/app/routes/app_routes.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../models/service_categories_model.dart';
import '../../controllers/auth_controller.dart';
import '../registration_review.dart';

class FreelanceService extends StatefulWidget {
  const FreelanceService({Key key}) : super(key: key);

  @override
  State<FreelanceService> createState() => _FreelanceServiceState();
}

class _FreelanceServiceState extends State<FreelanceService> {
  EServiceFormController controller = EServiceFormController();
  AuthController aController = AuthController();
  var selectedCat;
  var selectedSubCat;
  List<Categories> categories = [];
  List<SubServices> subCategories = [];
  List items = [
    'Item 1',
    'Item 2',
  ];

  void initializeMethods() async {
    await getCategories();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeMethods();
  }

  @override
  Widget build(BuildContext context) {
    // print(controller.eService.value);

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
            // key: controller.registerFormKey,
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
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(9)),
                        child: DropdownButton<Categories>(
                          iconSize: 30,
                          iconEnabledColor: Colors.grey.shade500,
                          underline: const SizedBox(),
                          isExpanded: true,
                          value: selectedCat,
                          onChanged: (newValue) async {
                            setState(() {
                              selectedCat = newValue;
                            });

                            await getSubcategories(newValue.id);

                            // pagesController.getBusinessPages(context: context);
                          },
                          items: categories
                              .map(
                                (item) => DropdownMenuItem<Categories>(
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  value: item,
                                ),
                              )
                              .toList(),
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      Text(
                        'Services Sub-category',
                        style: Get.textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400), borderRadius: BorderRadius.circular(9)),
                        child: DropdownButton<SubServices>(
                          iconSize: 30,
                          iconEnabledColor: Colors.grey.shade500,
                          underline: const SizedBox(),
                          isExpanded: true,
                          value: selectedSubCat,
                          onChanged: (newValue) {
                            setState(() {
                              selectedSubCat = newValue;
                            });

                            // pagesController.getBusinessPages(context: context);
                          },
                          items: subCategories
                              .map(
                                (item) => DropdownMenuItem<SubServices>(
                                  child: Text(
                                    item.name,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  value: item,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Text(
                      //         "".tr,
                      //         style: Get.textTheme.bodyText1,
                      //         textAlign: TextAlign.start,
                      //       ),
                      //     ),
                      //     MaterialButton(
                      //       onPressed: () async {
                      //         final selectedValues = await showDialog<Set<Category>>(
                      //           context: context,
                      //           builder: (BuildContext context) {
                      //             return MultiSelectDialog(
                      //               title: "Select Categories".tr,
                      //               submitText: "Submit".tr,
                      //               cancelText: "Cancel".tr,
                      //               items: controller.getMultiSelectCategoriesItems(),
                      //               initialSelectedValues: controller.categories
                      //                   .where(
                      //                     (category) =>
                      //                         controller.eService.value.categories
                      //                             ?.where((element) => element.id == category.id)
                      //                             ?.isNotEmpty ??
                      //                         false,
                      //                   )
                      //                   .toSet(),
                      //             );
                      //           },
                      //         );
                      //         controller.eService.update((val) async {
                      //           val.categories = selectedValues?.toList();
                      //           var res = await getProviders(2);
                      //           print("My Result:$res");
                      //         });
                      //       },
                      //       shape: StadiumBorder(),
                      //       color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                      //       child: Text("Select".tr, style: Get.textTheme.subtitle1),
                      //       elevation: 0,
                      //       hoverElevation: 0,
                      //       focusElevation: 0,
                      //       highlightElevation: 0,
                      //     ),
                      //   ],
                      // ),
                      // Obx(() {
                      //   if (controller.eService.value?.categories?.isEmpty ?? true) {
                      //     return Padding(
                      //       padding: EdgeInsets.symmetric(vertical: 20),
                      //       child: Text(
                      //         " ".tr,
                      //         style: Get.textTheme.caption,
                      //       ),
                      //     );
                      //   } else {
                      //     return buildCategories(controller.eService.value);
                      //   }
                      // }),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Text(
                      //   'Services Sub-Category',
                      //   style: Get.textTheme.bodyText1,
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Obx(() {
                      //   if (controller.eProviders.length > 1)
                      //     return Container(
                      //       padding: EdgeInsets.only(top: 8, bottom: 10, left: 20, right: 20),
                      //       margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                      //       decoration: BoxDecoration(
                      //           color: Get.theme.primaryColor,
                      //           borderRadius: BorderRadius.all(Radius.circular(10)),
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 color: Get.theme.focusColor.withOpacity(0.1),
                      //                 blurRadius: 10,
                      //                 offset: Offset(0, 5)),
                      //           ],
                      //           border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.stretch,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               Expanded(
                      //                 child: Text(
                      //                   "Providers".tr,
                      //                   style: Get.textTheme.bodyText1,
                      //                   textAlign: TextAlign.start,
                      //                 ),
                      //               ),
                      //               MaterialButton(
                      //                 onPressed: () async {
                      //                   final selectedValue = await showDialog<EProvider>(
                      //                     context: context,
                      //                     builder: (BuildContext context) {
                      //                       return SelectDialog(
                      //                         title: "Select Provider".tr,
                      //                         submitText: "Submit".tr,
                      //                         cancelText: "Cancel".tr,
                      //                         items: controller.getSelectProvidersItems(),
                      //                         initialSelectedValue: controller.eProviders.firstWhere(
                      //                           (element) => element.id == controller.eService.value.eProvider?.id,
                      //                           orElse: () => new EProvider(),
                      //                         ),
                      //                       );
                      //                     },
                      //                   );
                      //                   controller.eService.update((val) {
                      //                     val.eProvider = selectedValue;
                      //                   });
                      //                 },
                      //                 shape: StadiumBorder(),
                      //                 color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                      //                 child: Text("Select".tr, style: Get.textTheme.subtitle1),
                      //                 elevation: 0,
                      //                 hoverElevation: 0,
                      //                 focusElevation: 0,
                      //                 highlightElevation: 0,
                      //               ),
                      //             ],
                      //           ),
                      //           Obx(() {
                      //             if (controller.eService.value?.eProvider == null) {
                      //               return Padding(
                      //                 padding: EdgeInsets.symmetric(vertical: 20),
                      //                 child: Text(
                      //                   "Select providers".tr,
                      //                   style: Get.textTheme.caption,
                      //                 ),
                      //               );
                      //             } else {
                      //               return buildProvider(controller.eService.value);
                      //             }
                      //           })
                      //         ],
                      //       ),
                      //     );
                      //   else if (controller.eProviders.length == 1) {
                      //     controller.eService.value.eProvider = controller.eProviders.first;
                      //     return SizedBox();
                      //   } else {
                      //     return SizedBox();
                      //   }
                      // }),

                      SizedBox(
                        height: 15,
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
                        onSaved: (input) => controller.eService.value.name = input,
                        validator: (input) => input.length < 3 ? "Should be more than 3 letters".tr : null,
                        initialValue: controller.eService.value.name,
                        hintText: "Post Party Cleaning".tr,
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
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Color(0xffF2F2F2),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
                            ],
                            border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 10),
                            Obx(() {
                              return ListTileTheme(
                                contentPadding: EdgeInsets.all(0.0),
                                horizontalTitleGap: 0,
                                dense: true,
                                textColor: Get.theme.hintColor,
                                child: ListBody(
                                  children: [
                                    RadioListTile(
                                      value: "hourly",
                                      groupValue: aController.currentUser.value.priceRole,
                                      selected: aController.currentUser.value.priceRole == "hourly",
                                      title: Text("Hourly".tr),
                                      activeColor: Get.theme.colorScheme.secondary,
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      onChanged: (checked) {
                                        aController.currentUser.update((val) {
                                          val.priceRole = "hourly";
                                        });
                                      },
                                    ),
                                    RadioListTile(
                                      value: "fixed",
                                      groupValue: aController.currentUser.value.priceRole,
                                      title: Text("Fixed".tr),
                                      activeColor: Get.theme.colorScheme.secondary,
                                      selected: aController.currentUser.value.priceRole == "fixed",
                                      controlAffinity: ListTileControlAffinity.trailing,
                                      onChanged: (checked) {
                                        aController.currentUser.update((val) {
                                          val.priceRole = "fixed";
                                        });
                                      },
                                    )
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
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
                        initialValue: aController.currentUser?.value?.serviceDesc,
                        onSaved: (input) => aController.currentUser.value.serviceDesc = input,
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
                      Obx(() {
                        return ImagesFieldWidget(
                          color: Color(0xffF2F2F2),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(3),
                          label: "additional_service".tr,
                          field: 'additional_service',
                          tag: aController.currentUser.hashCode.toString(),
                          initialImages: aController.currentUser.value.images,
                          uploadCompleted: (uuid) {
                            aController.currentUser.update((val) {
                              val.images = val.images ?? [];
                              val.images.add(new Media(id: uuid));
                            });
                          },
                          reset: (uuids) {
                            aController.currentUser.update((val) {
                              val.images.clear();
                            });
                          },
                        );
                      }),
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
                            onPressed: () async {
                              await Get.toNamed(Routes.OTP_VERIFICATION); //// new screen here
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

  Future<dynamic> getCategories() async {
    Dio dio = Dio();
    var response = await dio.get('http://192.168.0.10:8000/api/provider/categories');
    if (response.statusCode == 200) {
      var result = ServiceCategoriesModel.fromJson(response.data);
      setState(() {
        categories = result.categories;
      });
      print("Get Data: ${response.data}");
      return response;
    } else {
      print("Response Message : ${response.statusMessage}");
      return response;
    }
  }

  Future<dynamic> getSubcategories(int id) async {
    Dio dio = Dio();
    var response = await dio.get('http://192.168.0.10:8000/api/provider/sub-categories?category_id=$id');
    if (response.statusCode == 200) {
      var result = ServiceSubCategoriesModel.fromJson(response.data);
      setState(() {
        subCategories = result.subServices;
      });
      print("Get Data: ${response.data}");
      return response;
    } else {
      print("Response Message : ${response.statusMessage}");
      return response;
    }
  }
}
