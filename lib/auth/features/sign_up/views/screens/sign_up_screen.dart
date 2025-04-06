library sign_up;

import 'package:agriplant/auth/config/routes/app_pages.dart';
import 'package:agriplant/auth/constans/app_constants.dart';
import 'package:agriplant/auth/shared_components/async_button.dart';
import 'package:agriplant/auth/shared_components/header_text.dart';
import 'package:agriplant/auth/utils/mixins/app_mixins.dart';
import 'package:agriplant/auth/utils/services/service.dart';
import 'package:agriplant/auth/utils/ui/ui_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// binding
part '../../bindings/sign_up_binding.dart';

// controller
part '../../controllers/sign_up_controller.dart';

// component
part '../components/button/continue_button.dart';
part '../components/button/sign_in_button.dart';
part '../components/button/term_condition_button.dart';
part '../components/text_field/email_text_field.dart';
part '../components/text_field/password_text_field.dart';
part '../components/text_field/name_text_field.dart';
part '../components/text_field/mobile_text_field.dart';


class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox( 
              height: Get.height,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultSpacing * 2),
                  child: Column(
                    children: [
                      const SizedBox(height: kDefaultSpacing),
                      _buildIllustration(),
                      const SizedBox(height: kDefaultSpacing),
                      _buildTitle(),
                      const SizedBox(height: kDefaultSpacing * 1.5),
                      _NameTextField(controller: controller.name),
                      const SizedBox(height: kDefaultSpacing * 1.5),
                      _MobileTextField(controller: controller.mobile),
                      const SizedBox(height: kDefaultSpacing * 1.5),
                      _EmailTextField(controller: controller.email),
                      const SizedBox(height: kDefaultSpacing),
                      _PasswordTextField(controller: controller.password),
                      const SizedBox(height: kDefaultSpacing * 2),
                      _TermConditionButton(
                        onPressedPrivacyPolicy: () {},
                        onPressedTerms: () {},
                      ),
                      const Spacer(),
                      _buildContinueButton(),
                      const SizedBox(height: kDefaultSpacing),
                      _SignInButton(onPressed: () => controller.goToSignIn()),
                      const SizedBox(height: kDefaultSpacing),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.all(kDefaultSpacing / 2),
              child: BackButton(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    return Image.asset(
      ImageRasterPath.form,
      height: 200,
    );
  }

  Widget _buildTitle() {
    return const Align(
      alignment: Alignment.topLeft,
      child: HeaderText("Sign Up"),
    );
  }

  Widget _buildContinueButton() {
    return Obx(
      () => _ContinueButton(
        isLoading: controller.isLoading.value,
        onPressed: () => controller.signUp(),
      ),
    );
  }
}
