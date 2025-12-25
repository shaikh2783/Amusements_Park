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
  var firstName = "".obs;
  var lastName = "".obs;
  var email = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;
  var agreeTerms = false.obs;
  final RxString errorMsg = "".obs;


  var selectedLocation = "".obs;
  var searchQuery = "".obs;

  final locations = [
    "Heritage Park - Mumbai",
    "Heritage Park - Delhi",
    "Heritage Park - Bangalore",
    "Heritage Park - Hyderabad",
    "Heritage Park - Chennai",
  ];
  List<String> get filteredLocations {
    if (searchQuery.value.isEmpty) {
      return locations;
    }
    return locations
        .where((l) =>
        l.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  void setError(String msg) {
    errorMsg.value = msg;
    update([GetxUpdateKey.signup]);
  }
  void clearError() {
    if (errorMsg.value.isNotEmpty) {
      errorMsg.value = "";
      update([GetxUpdateKey.signup]);
    }
  }

  void clearErrorOnTyping(String v) {
    if (v.isNotEmpty) clearError();
  }
  void selectLocation(String value) {
    selectedLocation.value = value;
    searchQuery.value = "";
    update([GetxUpdateKey.signup]);
  }

  void continueAfterLocation() {
    if (selectedLocation.value.isEmpty) {
      setError("Please select a location");
      update([GetxUpdateKey.signup]);
      return;
    }

    // ✅ Final signup success
    // API call / navigation
  }
void checkLogin(){
  if(GetUtils.isEmail(email.value) && password.value.isNotEmpty) {

  }else{
    setError("Please enter valid email & password");
    update([GetxUpdateKey.login]);
  }
}


  void checkSignUp() {
    if (firstName.value.isEmpty || lastName.value.isEmpty) {
      setError("Please enter your name");
    } else if (!GetUtils.isEmail(email.value)) {
      setError("Invalid email address");
    } else if (password.value.length < 6) {
      setError("Password must be at least 6 characters");
    } else if (password.value != confirmPassword.value) {
      setError("Passwords do not match");
    } else if (!agreeTerms.value) {
      setError("Please accept Terms & Conditions");
    } else {
      clearError();
      signupType.value = SignUpTypes.selectLocation;
    }
    update([GetxUpdateKey.signup]);
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
