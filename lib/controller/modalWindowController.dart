import 'package:get/get.dart';

class ModalWindowController extends GetxController {
  RxString tittleTask = ''.obs;
  RxString dueDate = ''.obs;
  RxString comments = ''.obs;
  RxString description = ''.obs;
  RxString tags = ''.obs;
  RxBool hasError = false.obs;
}
