import 'package:get/get.dart';
import 'package:notes/screen/profile/view/profile_controller.dart';

class ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
