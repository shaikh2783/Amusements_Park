import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iisc_app/Config/Constant/ColorsConstant.dart';
import 'package:iisc_app/Config/Constant/KeyConstant.dart';
import 'package:iisc_app/Helper/RouteManagement/RouteManagement.dart';
import 'package:iisc_app/Screens/OnBoarding/Controller/LoginController.dart';
import 'package:sizing/sizing.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final LoginController controller = Get.put(LoginController());

  bool rememberMe = true;
  bool obscurePassword = true;

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
        id: GetxUpdateKey.login,
        builder: (value) {
          final bottomInset = MediaQuery.of(context).viewPadding.bottom;

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
                    padding: EdgeInsets.fromLTRB(
                      24.ss,
                      118.ss,
                      24.ss,
                      24.ss + bottomInset,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/ic_login_icon.svg',
                          width: 65.ss,
                          height: 64.ss,
                        ),

                        SizedBox(height: 16.ss),
                        Text(
                          'Login Account',
                          style: TextStyle(
                            fontSize: 20.fs,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        SizedBox(height: 4.ss),
                        Text(
                          'Enter your email and password, or\ncontinue with Apple or Google.',
                          style: TextStyle(
                            fontSize: 14.fs,
                            fontWeight: FontWeight.normal,
                            color: ColorsConstant.colorSecondary,
                          ),
                        ),

                        SizedBox(height: 24.ss),

                        _inputField(
                          hint: 'Email',
                          icon: Icons.email_outlined,
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
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                        ),
                        Visibility(
                            visible: controller.errorMsg.isNotEmpty,
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.ss),
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
                        SizedBox(height: 12.ss),

                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  rememberMe = !rememberMe;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 18.ss,
                                    height: 18.ss,
                                    decoration: BoxDecoration(
                                      color: rememberMe
                                          ? ColorsConstant.colorRed
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: rememberMe
                                            ? ColorsConstant.colorRed
                                            : Colors.grey.shade400,
                                      ),
                                    ),
                                    child: rememberMe
                                        ?  Icon(
                                            Icons.check,
                                            size: 14.ss,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                   SizedBox(width: 8.ss),
                                  Text('Remember me',
                                      style: TextStyle(
                                          color: ColorsConstant.colorSecondary,
                                          fontSize: 13.fs,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                RouteManagement().routeToForgotPassword();
                              },
                              child: Text(
                                'Forgot password?',
                                style: TextStyle(
                                    color: ColorsConstant.colorRed,
                                    fontSize: 13.fs,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24.ss),

                        /// Sign In Button
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
                              controller.checkLogin();
                            },
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 14.fs,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        SizedBox(height: 24.ss),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Expanded(
                              child: Divider(color: ColorsConstant.colorDivider),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'Or Login with',
                                style: TextStyle(
                                    color: ColorsConstant.colorSecondary,
                                    fontSize: 14.fs,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: ColorsConstant.colorDivider),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.ss),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(14.ss),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.ss),
                                  border: Border.all(
                                      color: ColorsConstant.colorDivider,
                                      width: 1.ss),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/ic_google.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(width: 10.ss),
                                    Text(
                                      'Google',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.fs,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 12.ss),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(12.ss),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.ss),
                                  border: Border.all(
                                      color: ColorsConstant.colorDivider,
                                      width: 1.ss),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/ic_apple.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(width: 10.ss),
                                    Text(
                                      'Apple',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.fs,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.ss),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.fs,
                                    fontWeight: FontWeight.normal),
                              ),
                              TextButton(
                                onPressed: () {
                                  RouteManagement().routeToSignUpView();
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: ColorsConstant.colorRed,
                                      color: ColorsConstant.colorRed,
                                      fontSize: 14.fs,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

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
        contentPadding: EdgeInsets.symmetric(vertical: 16.ss,horizontal: 16.ss),
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
        if (value.isNotEmpty) {
          controller.errorMsg = "";
          controller.update([GetxUpdateKey.login]);
        }
        if (hint == "Email") {
          controller.email.value = value;
        } else {
          controller.password.value = value;
        }
      },
    );
  }
}
