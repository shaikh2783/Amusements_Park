
enum AppEnv {
  liveMode, /// Used for Production
  devMode, /// User for Development
}

class APIConstant {

  /// api time out
  static const apiTimeOut = 30;

  /// app environment status
  static const AppEnv appEnv = AppEnv.liveMode;

  /// SMS Base url
  static const developmentBaseUrl = "https://testadapp.iisc.ac.in";
  static const productionBaseUrl = "https://mobileapi.iisc.ac.in";


  static const apiBaseUrl = appEnv == AppEnv.devMode ? developmentBaseUrl : productionBaseUrl;

  static const String loginHims = "/hmis/api/Login/PensionerLogin";




}