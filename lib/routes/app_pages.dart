import 'package:get/get_navigation/src/routes/get_route.dart';
import '../screen/dashboard/view/dashboard_binding.dart';
import '../screen/dashboard/view/dashboard_screen.dart';
import '../screen/detail/view/detail_binding.dart';
import '../screen/detail/view/detail_screen.dart';
import '../screen/login/screen/login_binding.dart';
import '../screen/login/screen/login_screen.dart';
import '../screen/profile/view/profile_bindings.dart';
import '../screen/profile/view/profile_screen.dart';
import '../screen/registration/view/registration_binding.dart';
import '../screen/registration/view/registration_screen.dart';
import '../screen/splash/splash_screen.dart';
import '../screen/view_all/view_all_binding.dart';
import '../screen/view_all/view_all_screen.dart';
import 'app_routes.dart';

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
    ),
    GetPage(
      name: AppRoutes.view,
      page: () => const ViewAllScreen(),
      binding: ViewAllBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
      binding: ProfileBindings(),
    )
  ];
}
