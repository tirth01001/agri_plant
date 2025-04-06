part of dashboard;

class DashboardBinding extends Bindings {
  

  
  @override
  void dependencies() {

    // final auth = AuthService();
    // FirebaseService.service.initAccount(auth.currentUser?.uid??"");

    Get.lazyPut(() => DashboardController());
  }
}
