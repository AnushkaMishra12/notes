import 'package:get/get.dart';
import 'package:notes/screen/view_all/viewall_controller.dart';

class ViewAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewAllController());
  }
}
