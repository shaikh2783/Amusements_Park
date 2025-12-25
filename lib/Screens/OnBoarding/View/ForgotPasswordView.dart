import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iisc_app/Config/Constant/ColorsConstant.dart';
import 'package:iisc_app/Config/Constant/KeyConstant.dart';
import 'package:iisc_app/Screens/OnBoarding/Controller/ForgotPasswordController.dart';
import 'package:pinput/pinput.dart';
import 'package:sizing/sizing.dart';

import '../../../Helper/AppInputField.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _LoginViewState();
}

class _LoginViewState extends State<ForgotPasswordView> {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());

  bool rememberMe = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void initState() {
    controller.otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<ForgotPasswordController>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
        id: GetxUpdateKey.forgotPassword,
        builder: (value) {
          return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/login_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  bottom: false,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24.ss, 16.ss, 24.ss, 24.ss),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                controller.handleBackPress();
                              },
                              child:SvgPicture.asset('assets/icons/ic_back.svg',height: 23.ss,width: 24.ss,)),
                          SizedBox(height: 72.ss),
                          SvgPicture.asset(
                            'assets/icons/ic_login_icon.svg',
                            width: 65.ss,
                            height: 64.ss,
                          ),
                          SizedBox(height: 16.ss),
                          Text(
                            controller.getViewTitle(),
                            style: TextStyle(
                              fontSize: 20.fs,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 4.ss),
                          Text(
                            controller.getViewSubTitle(),
                            style: TextStyle(
                              fontSize: 14.fs,
                              color: ColorsConstant.colorSecondary,
                            ),
                          ),
                          SizedBox(height: 24.ss),
                          Obx(() {
                            switch (controller.forgotPasswordType.value) {
                              case ForgotPasswordTypes.forgotEmail:
                                return AppInputField(
                                    hint: "Email",
                                    iconPath: "assets/icons/ic_message.svg",
                                    onChanged: (v) {
                                      controller.clearErrorOnTyping(v);
                                      controller.email.value = v;
                                    });

                              case ForgotPasswordTypes.forgotOTP:
                                return _otpInputView();

                              case ForgotPasswordTypes.forgotResetPassword:
                                return Column(
                                  children: [
                                    AppInputField(
                                      hint: "New Password",
                                      iconPath: "assets/icons/ic_password.svg",
                                      onChanged: (v) {
                                        controller.clearErrorOnTyping(v);
                                        controller.password.value = v;
                                      },
                                      obscureText: obscurePassword,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(
                                                  () => obscurePassword = !obscurePassword);
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 12.ss),
                                    AppInputField(
                                      hint: "Confirm Password",
                                      iconPath: "assets/icons/ic_password.svg",
                                      onChanged: (v) {
                                        controller.clearErrorOnTyping(v);
                                        controller.confirmPassword.value = v;
                                      },
                                      obscureText: obscureConfirmPassword,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          obscureConfirmPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(
                                                  () => obscureConfirmPassword = !obscureConfirmPassword);
                                        },
                                      ),
                                    ),

                                  ],
                                );
                            }
                          }),
                          Obx(() => Visibility(
                            visible: controller.errorMsg.value.isNotEmpty,
                            child: Padding(
                              padding: EdgeInsets.only(top: 4.ss),
                              child: Row(
                                children: [
                                  Icon(Icons.error_outline_sharp, size: 16.ss, color: ColorsConstant.colorRed),
                                  SizedBox(width: 4.ss),
                                  Text(
                                    controller.errorMsg.value,
                                    style: TextStyle(fontSize: 13.fs, color: ColorsConstant.colorRed),
                                  ),
                                ],
                              ),
                            ),
                          )),
                          SizedBox(height: 16.ss),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: _actionButton(),
              ));
        });
  }

  Widget _actionButton() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      color: Colors.white, // solid background
      padding: EdgeInsets.only(
        left: 24.ss,
        right: 24.ss,
        bottom: bottomInset > 0 ? bottomInset + 12.ss : 24.ss,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 49.ss,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsConstant.colorRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  if (controller.forgotPasswordType.value ==
                      ForgotPasswordTypes.forgotEmail) {
                    controller.checkEmailId();
                  } else if (controller.forgotPasswordType.value ==
                      ForgotPasswordTypes.forgotOTP) {
                    controller.verifyOtp(controller.otpController.text);
                  } else if (controller.forgotPasswordType.value ==
                      ForgotPasswordTypes.forgotResetPassword) {
                    controller.checkPassword();
                  }
                },
                child: Text(
                  controller.getActionButtonText(),
                  style: TextStyle(
                    fontSize: 14.fs,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (controller.forgotPasswordType.value ==
                ForgotPasswordTypes.forgotEmail)
              Padding(
                padding: EdgeInsets.only(top: 24.ss),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remember Password?",
                      style: TextStyle(fontSize: 14.fs),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: ColorsConstant.colorRed,
                          fontSize: 14.fs,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _otpInputView() {
    final defaultPinTheme = PinTheme(
      width: 56.ss,
      height: 56.ss,
      textStyle: TextStyle(
        fontSize: 18.fs,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.ss),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Pinput(
          length: 6,
          controller: controller.otpController,
          keyboardType: TextInputType.number,
          autofocus: true,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          defaultPinTheme: PinTheme(
            width: 56.ss,
            height: 56.ss,
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 22.fss,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.ss),
              border: Border.all(
                  color: controller.errorMsg.isNotEmpty
                      ? Colors.red
                      : Colors.grey),
            ),
          ),
          focusedPinTheme: defaultPinTheme.copyDecorationWith(
            border: Border.all(
              color: ColorsConstant.colorRed,
              width: 1.5,
            ),
          ),
          submittedPinTheme: PinTheme(
            width: 56.ss,
            height: 56.ss,
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 22.fss,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.ss),
              border: Border.all(
                  color: controller.errorMsg.isNotEmpty
                      ? Colors.red
                      : ColorsConstant.colorPrimary,
                  width: 2.ss),
            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              controller.setError("");
              controller.otpController.text = value;
              controller.update([GetxUpdateKey.forgotPassword]);
            }
          },
          // onCompleted: controller.verifyOtp,
        ),
        SizedBox(height: 24.ss),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Resend?",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
                fontSize: 14.fs,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Second Left",
                style: TextStyle(
                  color: ColorsConstant.colorText,
                  fontSize: 14.fs,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
