import 'package:chemlab_flutter_project/Repository/Authentication_Reppo.dart';
import 'package:chemlab_flutter_project/screens/SignUpPage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class OtpController extends GetxController {
  static OtpController get instance => Get.find();

  void verifyOTP(String otp) async {
    try {
      var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);

      if (isVerified) {
        Get.offAll(SignUpPage()); // Proceed to SignUpPage if verified
      } else {
        Get.snackbar(
          'Verification Failed', 
          'Invalid OTP. Please try again.', 
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error', 
        'Something went wrong. Please try again later.', 
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
