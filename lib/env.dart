enum devMode { development, production }

class Env{
  static bool isRTL = false;

  static String appName="QR Admin";

  static const dummyProfilePic = "";

  //Route names
  static const mainPage = "/";
  static const authPage = "/authPage";
  static const homePage = "/homePage";
  static const verifyPage = "/verifyPage";

  static int databaseVersion=1;

//todo:please Set API Base Route
  static String _localUrl = 'http://192.168.1.20/joovlly/qr-laravel/public/api';
  static String _productionUrl = 'http://amr.amrnrd.com/api';
  static devMode mode = devMode.production;

  static String get baseUrl {
  if (mode == devMode.development)
  return _localUrl;
  else
  return _productionUrl;
  }










}