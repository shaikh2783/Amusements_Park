import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iisc_app/Config/Constant/KeyConstant.dart';
import 'package:iisc_app/Utils/Utility.dart';

enum SignUpTypes{
  signup,
  selectLocation,
}
class LoginController extends GetxController{
  var signupType = SignUpTypes.signup.obs;
  var email = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;
  var errorMsg="";


void checkLogin(){
  if(GetUtils.isEmail(email.value) && password.value.isNotEmpty) {

  }else{
    errorMsg="Please enter valid email & password";
    update([GetxUpdateKey.login]);
  }
}


  void checkSignUp() {
    if (!GetUtils.isEmail(email.value)) {
      errorMsg = "Email is not correct";
      update([GetxUpdateKey.signup]);
      return;
    }else {
      update([GetxUpdateKey.signup]);
      signupType.value = SignUpTypes.selectLocation;
    }
  }

  String getViewTitle(){
      switch(signupType.value){
        case SignUpTypes.signup:
          return "Create Your Account";
        case SignUpTypes.selectLocation:
          return "Select Location";
      }
  }
  String getErrorText(){
      switch(signupType.value){
        case SignUpTypes.signup:
          return "Please enter valid details";
        case SignUpTypes.selectLocation:
          return "Please select location";
      }
  }
  String getActionButtonText(){
      switch(signupType.value){
        case SignUpTypes.signup:
          return "Sign Up";
        case SignUpTypes.selectLocation:
          return "Continue";
      }
  }
  String getViewSubTitle(){
      switch(signupType.value){
        case SignUpTypes.signup:
          return "Enter your email and password to create your account.";
        case SignUpTypes.selectLocation:
          return "Choose your nearest Heritage Amusements Park to continue.";
      }
  }



}
