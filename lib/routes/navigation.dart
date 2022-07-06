import 'package:elsy_mobile_app/screens/cards/cardsScreen.dart';
import 'package:elsy_mobile_app/screens/cards/controller/cardsBindings.dart';

import '/screens/login/controller/login_binding.dart';
import '/screens/login/loginScreen.dart';
import '/screens/map/controller/mapBinding.dart';
import '/screens/map/mapScreen.dart';
import '/screens/payment_method/controller/paymentMethodBinding.dart';
import '/screens/payment_method/paymentMethodScreen.dart';
import '/screens/profile/controller/profileBinding.dart';
import '/screens/profile/profileScreen.dart';
import '/screens/qrgenerate/controller/qrGenerateBinding.dart';
import '/screens/qrgenerate/qrGenerateScreen.dart';
import '/screens/signup/controller/signUpBinding.dart';
import '/screens/signup/signUpScreen.dart';
import '/screens/splash/controller/splashBinding.dart';
import '/screens/splash/splashScreen.dart';
import 'package:get/get.dart';

class Routes {
  static final String splash = '/splash';
  static final String login = '/login';
  static final String signup = '/signup';
  static final String map = '/map';
  static final String fuel = '/fuel';
  static final String navigation = '/navigation';
  static final String column = '/column';
  static final String profile = '/profile';
  static final String qruser = '/qruser';
  static final String cardPay = '/cardPay';
  static final String cardBonus = '/cardBonus';
}

class RoutePages {
  static final pages = [
    GetPage(
        name: '/splash', page: () => SplashScreen(), binding: SplashBinding()),
    GetPage(name: '/login', page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(
        name: '/signup', page: () => SignUpScreen(), binding: SignUpBinding()),
    GetPage(name: '/map', page: () => MapScreen(), binding: MapBinding()),
    GetPage(
        name: '/profile',
        page: () => ProfileScreen(),
        binding: ProfileBinding()),
    GetPage(
        name: '/qruser',
        page: () => QrCodeScreen(),
        binding: QrGenerateBinding()),
    GetPage(
        name: '/cardPay',
        page: () => PaymentMethodScreen(),
        binding: PaymentMethodBinding()),
    GetPage(name: '/cardBonus',
        page: () => CardScreen(),
        binding: CardsBinding())
  ];
}
