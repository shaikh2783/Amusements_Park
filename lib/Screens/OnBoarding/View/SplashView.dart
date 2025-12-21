
import 'package:flutter/material.dart';
import 'package:iisc_app/Helper/RouteManagement/RouteManagement.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => nextPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/image/splash_bg.png',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );

  }


  nextPage() async {
    await Future.delayed(const Duration(seconds: 1));
    RouteManagement().routeToLogin();
    // final data = await SecureStore().getStringData(SharedPrefKey.authorization)??"";
    // if (data.isEmpty) {
    //   RouteManagement().routeToOnboarding();
    // }else{
    //   final isBiometricEnable = await SecureStore().getBoolData(SharedPrefKey.isBiometricEnable) ?? false;
    //   if(isBiometricEnable==true) {
    //     RouteManagement().routeToBiometricVerificationView();
    //   }else {
    //     RouteManagement().routeToHomeView(isFromSplash: true);
    //   }
    // }
  }


  @override
  void dispose() {
    super.dispose();
  }
}
