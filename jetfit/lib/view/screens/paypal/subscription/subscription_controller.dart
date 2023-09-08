import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  static SubscriptionController get to => Get.find();
  String selectedDuration = '';
  double? price;
  String? duration;
}
