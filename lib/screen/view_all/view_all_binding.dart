import 'package:get/get.dart';
import 'package:notes/screen/view_all/view_all_controller.dart';

class ViewAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewAllController());
  }
}
