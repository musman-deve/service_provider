import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/services/settings_service.dart';

import '../../../../common/ui.dart';
import '../../../models/user_model.dart';
import '../../../repositories/user_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/firebase_messaging_service.dart';
import '../views/user_information.dart';

class AuthController extends GetxController {
  final Rx<User> currentUser = Get.find<AuthService>().user;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<FormState> registerFormKey;
  GlobalKey<FormState> forgotPasswordFormKey;
  final hidePassword = true.obs;
  final loading = false.obs;
  final smsSent = ''.obs;
  UserRepository _userRepository;

  AuthController() {
    _userRepository = UserRepository();
  }

  void login() async {
    Get.focusScope.unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      loading.value = true;
      try {
        await Get.find<FireBaseMessagingService>().setDeviceToken();
        currentUser.value = await _userRepository.login(currentUser.value);
        await _userRepository.signInWithEmailAndPassword(
            currentUser.value.email, currentUser.value.apiToken);
        loading.value = false;
        await Get.toNamed(Routes.ROOT, arguments: 0);
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }

  void register() async {
    Get.focusScope.unfocus();
    // if (registerFormKey.currentState.validate()) {
    //   registerFormKey.currentState.save();
    loading.value = true;
    try {
      //   await Get.toNamed(Routes.OTP_VERIFICATION);
      // } else {
      await Get.find<FireBaseMessagingService>().setDeviceToken();
      currentUser.value = await _userRepository.register(currentUser.value);

      await _userRepository.signUpWithEmailAndPassword(
          currentUser.value.email, currentUser.value.apiToken);
      loading.value = false;
      await Get.offAllNamed(Routes.E_PROVIDERS);
      // }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
    // }
  }

  void providerRegister() async {
    Get.focusScope.unfocus();

    loading.value = true;
    try {
      await Get.find<FireBaseMessagingService>().setDeviceToken();
      currentUser.value =
          await _userRepository.freenlancerRegister(currentUser.value);

      await _userRepository.signUpWithEmailAndPassword(
          currentUser.value.email, currentUser.value.apiToken);
      loading.value = false;
      await Get.offAllNamed(Routes.E_PROVIDERS);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }

  Future<void> verifyPhone() async {
    try {
      loading.value = true;
      await _userRepository.verifyPhone(smsSent.value);
      await Get.find<FireBaseMessagingService>().setDeviceToken();
      currentUser.value = await _userRepository.register(currentUser.value);
      await _userRepository.signUpWithEmailAndPassword(
          currentUser.value.email, currentUser.value.apiToken);
      loading.value = false;
      await Get.offAllNamed(
        Routes.REGISTRATION_REVIEW,
      );
    } catch (e) {
      loading.value = false;
      Get.to(() => UserInformation());
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      loading.value = false;
    }
  }

  Future<void> resendOTPCode() async {
    await _userRepository.sendCodeToPhone();
  }

  void sendResetLink() async {
    Get.focusScope.unfocus();
    if (forgotPasswordFormKey.currentState.validate()) {
      forgotPasswordFormKey.currentState.save();
      loading.value = true;
      try {
        await _userRepository.sendResetLinkEmail(currentUser.value);
        loading.value = false;
        Get.showSnackbar(Ui.SuccessSnackBar(
            message:
                "The Password reset link has been sent to your email: ".tr +
                    currentUser.value.email));
        Timer(Duration(seconds: 5), () {
          Get.offAndToNamed(Routes.LOGIN);
        });
      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}
