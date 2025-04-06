part of dashboard;

class DashboardController extends GetxController {
  final auth = AuthService();
  final isLoading = false.obs;

  // @override
  // void onReady() {
  //   super.onReady();
  //   print("Ready");
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   print("Init");
  // }

  void signOut() async {
    isLoading.value = true; 
    await auth.signOut();
    isLoading.value = false;
    Get.offAllNamed(Routes.splash);
  }
}
 