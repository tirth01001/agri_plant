part of splash;

class SplashController extends GetxController {
  final auth = AuthService();
  final isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    validateUser();
  }

  void validateUser() async {
    print("Hello");
    isLoading.value = false;
      // print(auth.currentUser?.email??"NotFound!!");

    if (auth.isLogin) {
      await auth.reload(); 

      if (auth.isEmailVerified == true) {

        // print(auth.currentUser?.email.toString());
        Get.offNamed(Routes.dashboard);
      } else {
        Get.offNamed(Routes.emailVerification);
      }
    } else {
      Get.offNamed(Routes.signIn);
    }
  }
}
