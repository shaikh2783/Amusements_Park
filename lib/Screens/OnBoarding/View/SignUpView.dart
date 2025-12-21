import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iisc_app/Config/Constant/ColorsConstant.dart';
import 'package:iisc_app/Config/Constant/KeyConstant.dart';
import 'package:iisc_app/Screens/OnBoarding/Controller/ForgotPasswordController.dart';
import 'package:iisc_app/Screens/OnBoarding/Controller/LoginController.dart';
import 'package:pinput/pinput.dart';
import 'package:sizing/sizing.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => SignUpViewState();
}

class SignUpViewState extends State<SignUpView> {
  final LoginController controller = Get.put(LoginController());

  bool rememberMe = true;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<LoginController>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        id: GetxUpdateKey.signup,
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
                          Visibility(
                            visible: controller.signupType.value ==
                                SignUpTypes.selectLocation,
                            child: GestureDetector(
                                onTap: () {
                                  controller.signupType.value = SignUpTypes.signup;
                                  controller.update([GetxUpdateKey.signup]);
                                },
                                child:
                                    Icon(Icons.arrow_back_sharp, size: 24.ss)),
                          ),
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
                            switch (controller.signupType.value) {
                              case SignUpTypes.signup:
                                return Column(
                                  children: [
                                    _inputField(
                                      hint: 'First Name',
                                      icon: Icons.person_outline,
                                      onChanged: (v) =>
                                          controller.firstName.value = v,
                                    ),
                                    SizedBox(height: 12.ss),
                                    _inputField(
                                      hint: 'Last Name',
                                      icon: Icons.person_outline,
                                      onChanged: (v) =>
                                          controller.lastName.value = v,
                                    ),
                                    SizedBox(height: 12.ss),
                                    _inputField(
                                      hint: 'Email',
                                      icon: Icons.email_outlined,
                                      onChanged: (v) =>
                                          controller.email.value = v,
                                    ),
                                    SizedBox(height: 12.ss),
                                    _inputField(
                                      hint: 'Password',
                                      icon: Icons.lock_outline,
                                      obscureText: obscurePassword,
                                      suffix: IconButton(
                                        icon: Icon(
                                          obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() => obscurePassword =
                                              !obscurePassword);
                                        },
                                      ),
                                      onChanged: (v) =>
                                          controller.password.value = v,
                                    ),
                                    SizedBox(height: 12.ss),
                                    _inputField(
                                      hint: 'Confirm Password',
                                      icon: Icons.lock_outline,
                                      obscureText: obscureConfirmPassword,
                                      suffix: IconButton(
                                        icon: Icon(
                                          obscureConfirmPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() =>
                                              obscureConfirmPassword =
                                                  !obscureConfirmPassword);
                                        },
                                      ),
                                      onChanged: (v) =>
                                          controller.confirmPassword.value = v,
                                    ),
                                    SizedBox(height: 14.ss),
                                  ],
                                );

                              case SignUpTypes.selectLocation:
                                return _locationField();

                            }
                          }),
                          Visibility(
                              visible: controller.errorMsg.isNotEmpty,
                              child: Padding(
                                padding: EdgeInsets.only(top: 4.ss),
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

                          Visibility(
                              visible: controller.signupType.value ==
                                  SignUpTypes.signup,
                              child: Padding(
                                padding:  EdgeInsets.only(top: 4.ss,bottom: 12.ss),
                                child: Obx(() => GestureDetector(
                                  onTap: () {
                                    controller.agreeTerms.toggle();
                                    controller.update([GetxUpdateKey.signup]);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20.ss,
                                        height: 20.ss,
                                        decoration: BoxDecoration(
                                          color: controller.agreeTerms.value
                                              ? ColorsConstant.colorRed
                                              : Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          border: Border.all(
                                            color: controller.agreeTerms.value
                                                ? ColorsConstant.colorRed
                                                : Colors.grey.shade400,
                                          ),
                                        ),
                                        child: controller.agreeTerms.value
                                            ? Icon(Icons.check,
                                            size: 14.ss,
                                            color: Colors.white)
                                            : null,
                                      ),
                                      SizedBox(width: 8.ss),
                                      Expanded(
                                        child: Text(
                                          "I agree to the Terms and Conditions",
                                          style: TextStyle(fontSize: 13.fs),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
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
        bottom: bottomInset > 0 ? bottomInset + 12.ss : 12.ss,
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
                  if (controller.signupType.value == SignUpTypes.signup) {
                    controller.checkSignUp();
                  } else if (controller.signupType.value ==
                      SignUpTypes.selectLocation) {
                    controller.continueAfterLocation();
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
            if (controller.signupType.value == SignUpTypes.signup)
              Padding(
                padding: EdgeInsets.only(top: 16.ss),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 14.fs),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
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

  Widget _locationField() {
    return GestureDetector(
      onTap: _openLocationBottomSheet,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.ss, vertical: 16.ss),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.ss),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(Icons.location_on_outlined,
                color: Colors.grey.shade600),
            SizedBox(width: 8.ss),
            Expanded(
              child: Obx(() => Text(
                controller.selectedLocation.value.isEmpty
                    ? "Select Location"
                    : controller.selectedLocation.value,
                style: TextStyle(
                  fontSize: 14.fs,
                  color: controller.selectedLocation.value.isEmpty
                      ? Colors.grey
                      : Colors.black,
                ),
              )),
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }


  /// Reusable input field
  Widget _inputField({
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffix,
    ValueChanged<String>? onChanged,
  }) {
    return TextField(
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.ss),
        ),
      ),
    );
  }

  void _openLocationBottomSheet() {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: EdgeInsets.all(16.ss),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.ss),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: EdgeInsets.only(bottom: 16.ss),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Text(
                "Select Location",
                style: TextStyle(
                  fontSize: 18.fs,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.ss),

              // 🔍 Search
              TextField(
                onChanged: (v) {
                  controller.searchQuery.value = v;
                },
                decoration: InputDecoration(
                  hintText: "Search location",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.ss),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 12.ss),

              // 📍 Location list
              Expanded(
                child: Obx(() {
                  final items = controller.filteredLocations;

                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        "No locations found",
                        style: TextStyle(fontSize: 14.fs),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, __) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final location = items[index];
                      return ListTile(
                        leading:
                        const Icon(Icons.location_on_outlined),
                        title: Text(location),
                        onTap: () {
                          controller.selectLocation(location);
                          Get.back();
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

}
