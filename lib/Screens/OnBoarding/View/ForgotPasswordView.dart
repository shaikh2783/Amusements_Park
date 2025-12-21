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
          return Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(
              fit: StackFit.expand,
              children: [
                MediaQuery.removeViewInsets(
                  context: context,
                  removeBottom: true,
                  child: Image.asset(
                    'assets/image/login_bg.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.ss, 30.ss, 20.ss, 20.ss),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                              onTap: () {
                                controller.handleBackPress();
                              },
                              child: Icon(Icons.arrow_back_sharp, size: 24.ss)),
                          SizedBox(height: 60.ss),
                          SvgPicture.asset(
                            'assets/icons/ic_login_icon.svg',
                            width: 65.ss,
                            height: 65.ss,
                          ),
                          SizedBox(height: 12.ss),
                          Text(
                            controller.getViewTitle(),
                            style: TextStyle(
                              fontSize: 20.fs,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6.ss),
                          Text(
                            controller.getViewSubTitle(),
                            style: TextStyle(
                              fontSize: 14.fs,
                              color: ColorsConstant.colorSecondary,
                            ),
                          ),
                          SizedBox(height: 30.ss),
                          Obx(() {
                            switch (controller.forgotPasswordType.value) {
                              case ForgotPasswordTypes.forgotEmail:
                                return _inputField(
                                  hint: 'Email',
                                  icon: Icons.email_outlined,
                                );

                              case ForgotPasswordTypes.forgotOTP:
                                return _otpInputView();

                              case ForgotPasswordTypes.forgotResetPassword:
                                return Column(
                                  children: [
                                    _inputField(
                                      hint: 'New Password',
                                      icon: Icons.lock_outline,
                                      obscureText: obscurePassword,
                                      suffix: IconButton(
                                        icon: Icon(
                                          obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            obscurePassword = !obscurePassword;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 16.ss),
                                    _inputField(
                                      hint: 'Confirm Password',
                                      icon: Icons.lock_outline,
                                      obscureText: obscureConfirmPassword,
                                      suffix: IconButton(
                                        icon: Icon(
                                          obscureConfirmPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            obscureConfirmPassword =
                                                !obscureConfirmPassword;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                );
                            }
                          }),
                          Visibility(
                              visible: controller.errorMsg.isNotEmpty,
                              child: Padding(
                                padding:  EdgeInsets.only(top: 8.ss),
                                child: Row(
                                  children: [
                                    Icon(Icons.error_outline_sharp,
                                        size: 16.ss,
                                        color: ColorsConstant.colorRed),
                                    SizedBox(width: 4.ss),
                                    Text(controller.errorMsg,
                                        style: TextStyle(
                                            fontSize: 13.fs,
                                            color: ColorsConstant.colorRed,
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              )),
                          SizedBox(height: 16.ss),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _actionButton(),
          );
        });
  }

  Widget _actionButton() {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      color: Colors.white, // solid background
      padding: EdgeInsets.only(
        left: 20.ss,
        right: 20.ss,
        top: 10.ss,
        bottom: bottomInset > 0 ? bottomInset + 12.ss : 20.ss,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 50.ss,
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (controller.forgotPasswordType.value ==
                ForgotPasswordTypes.forgotEmail)
              Padding(
                padding: EdgeInsets.only(top: 16.ss),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 14.fs),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sign Up",
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
      width: 48.ss,
      height: 52.ss,
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
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme.copyDecorationWith(
            border: Border.all(
              color: ColorsConstant.colorRed,
              width: 1.5,
            ),
          ),
          submittedPinTheme: defaultPinTheme.copyDecorationWith(
            border: Border.all(color: Colors.green),
          ),
          onChanged: (value)
          {
            if(value.isNotEmpty) {
              controller.errorMsg="";
              controller.update([GetxUpdateKey.forgotPassword]);
            }
          },
          // onCompleted: controller.verifyOtp,
        ),
      ],
    );
  }

  /// Reusable input field
  Widget _inputField({
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffix,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontSize: 14.fs, color: ColorsConstant.colorText),
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16.ss),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.ss),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.ss),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      onChanged: (value) {
        if(value.isNotEmpty) {
          controller.errorMsg="";
          controller.update([GetxUpdateKey.forgotPassword]);
        }
        if(controller.forgotPasswordType.value==ForgotPasswordTypes.forgotEmail){
          controller.email.value=value;
        }else if(controller.forgotPasswordType.value==ForgotPasswordTypes.forgotOTP){
          controller.otpController.text=value;
        }else if(controller.forgotPasswordType.value==ForgotPasswordTypes.forgotResetPassword) {
          if(hint=="Confirm Password"){
            controller.confirmPassword.value=value;
          }else{
            controller.password.value=value;
          }
        }
      },
    );
  }
}
