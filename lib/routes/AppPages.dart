import 'package:get/get_navigation/src/routes/get_route.dart';
import '../screen/dashboard/view/DashBoardBinding.dart';
import '../screen/dashboard/view/DashBoardScreen.dart';
import '../screen/detail/view/DetailBinding.dart';
import '../screen/detail/view/DetailScreen.dart';
import '../screen/login/screen/LoginBinding.dart';
import '../screen/login/screen/LoginScreen.dart';
import '../screen/registration/view/RegistrationBinding.dart';
import '../screen/registration/view/RegistrationScreen.dart';
import '../screen/splash/SplashScreen.dart';
import 'AppRoutes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.registration,
      page: () => const RegistrationScreen(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashBoardScreen(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => const DetailScreen(),
      binding: DetailBinding(),
    )
  ];
}
