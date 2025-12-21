import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iisc_app/Config/Constant/KeyConstant.dart';

enum ForgotPasswordTypes{
  forgotEmail,
  forgotOTP,
  forgotResetPassword,
}
class ForgotPasswordController extends GetxController{
  late final TextEditingController otpController;

  var forgotPasswordType = ForgotPasswordTypes.forgotEmail.obs;
  var email = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;
  var errorMsg="";

  void checkEmailId() {
    if (!GetUtils.isEmail(email.value)) {
      errorMsg = "Email is not correct";
      update([GetxUpdateKey.forgotPassword]);
      return;
    }else {
      update([GetxUpdateKey.forgotPassword]);
      forgotPasswordType.value = ForgotPasswordTypes.forgotOTP;
    }
  }
  void verifyOtp(String otp) {
    if(otp.length==6) {
      update([GetxUpdateKey.forgotPassword]);
      forgotPasswordType.value = ForgotPasswordTypes.forgotResetPassword;
    }else{
      errorMsg = "OTP is not correct";
      update([GetxUpdateKey.forgotPassword]);
    }
  }
  void checkPassword() {
    if(password.value.length>6 && password.value==confirmPassword.value){
      update([GetxUpdateKey.forgotPassword]);
      forgotPasswordType.value = ForgotPasswordTypes.forgotEmail;
    }else {
      errorMsg = "Please enter valid password ";
      update([GetxUpdateKey.forgotPassword]);
    }
  }
  void handleBackPress(){
    if(forgotPasswordType.value==ForgotPasswordTypes.forgotResetPassword){
      forgotPasswordType.value=ForgotPasswordTypes.forgotOTP;
    }else if(forgotPasswordType.value==ForgotPasswordTypes.forgotOTP){
      forgotPasswordType.value=ForgotPasswordTypes.forgotEmail;
    }else{
      Get.back();
    }
    update([GetxUpdateKey.forgotPassword]);
  }
  String getViewTitle(){
      switch(forgotPasswordType.value){
        case ForgotPasswordTypes.forgotEmail:
          return "Forgot Password";
        case ForgotPasswordTypes.forgotOTP:
          return "OTP Verification";
        case ForgotPasswordTypes.forgotResetPassword:
          return "Reset Password";
      }
  }
  String getErrorText(){
      switch(forgotPasswordType.value){
        case ForgotPasswordTypes.forgotEmail:
          return "Forgot Password";
        case ForgotPasswordTypes.forgotOTP:
          return "OTP Verification";
        case ForgotPasswordTypes.forgotResetPassword:
          return "Reset Password";
      }
  }
  String getActionButtonText(){
      switch(forgotPasswordType.value){
        case ForgotPasswordTypes.forgotEmail:
          return "Send OTP";
        case ForgotPasswordTypes.forgotOTP:
          return "Verify";
        case ForgotPasswordTypes.forgotResetPassword:
          return "Save";
      }
  }
  String getViewSubTitle(){
      switch(forgotPasswordType.value){
        case ForgotPasswordTypes.forgotEmail:
          return "Enter your registered email. We will send you an OTP to reset your password.";
        case ForgotPasswordTypes.forgotOTP:
          return "We have sent a 6-digit OTP to $email";
        case ForgotPasswordTypes.forgotResetPassword:
          return "Enter and confirm your new password below.";
      }
  }



}
