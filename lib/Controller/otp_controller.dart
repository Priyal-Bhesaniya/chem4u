import 'package:chemlab_flutter_project/Repository/Authentication_Reppo.dart';
import 'package:chemlab_flutter_project/screens/SignUpPage.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


class OtpController extends  GetxController{
  static OtpController get instance =>Get.find();


  void verifyOTP(String otp) async{
    var isVerified = await AuthenticationRepository.instance.varifyOTP(otp);
    isVerified ? Get.offAll( SignUpPage()) :Get.back();
  }
}