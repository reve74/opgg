import 'package:get/get.dart';
import 'package:opgg/controller/patchnote_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => PatchNoteController());
  }
}
