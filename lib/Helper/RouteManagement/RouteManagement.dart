import 'package:get/get.dart';
import 'package:iisc_app/Screens/OnBoarding/View/ForgotPasswordView.dart';
import 'package:iisc_app/Screens/OnBoarding/View/LoginView.dart';

class RouteManagement {

  // Future routeToOnboarding({bool isFromSplash = false}) async {
  //   const route = OnboardingView(selectedState: 0); //TODO LoginOptionSelectView();
  //   Get.offAll(() => route);
  // }
  // Future routeToHomeView({bool isFromSplash = false}) async {
  //   final isForPensioner =  await SecureStore().getBoolData(SharedPrefKey.isPensionerLogin) ?? true;
  //   if (isFromSplash) {
  //     await Future.delayed(const Duration(seconds: 1));
  //   }
  //   final route = HomeView(selectedState: 0, isPensionerLogin: isForPensioner);
  //   Get.offAll(() => route);
  // }
  // logOut() async {
  //    await SecureStore().removeAllData();
  //   await HiveStore().clearHiveBox();
  //   routeToOnboarding();
  // }
  Future routeToLogin() async {
    const route =  LoginView();
    Get.off(() => route);
  }
  Future routeToForgotPassword() async {
    const route =  ForgotPasswordView();
    Get.to(() => route);
  }

}
