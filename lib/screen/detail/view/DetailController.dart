import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../dashboard/data/ResponseData.dart';

class DetailController extends GetxController {
  static DetailController get to => Get.find();
  final ResponseData? listData = Get.arguments;
  final titleController = TextEditingController(text: '');
  final descriptionController = TextEditingController(text: '');
  final editable = false.obs;

  @override
  void onInit() {
    titleController.text = listData?.title ?? '';
    descriptionController.text = listData?.description ?? '';
    super.onInit();
  }
}
