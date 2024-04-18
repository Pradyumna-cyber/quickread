import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';


class InternetCheck extends StatelessWidget {
  final ConnectivityController _connectivityController = Get.put(ConnectivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Obx(() {
          if (_connectivityController.isConnected.value) {
            return Image.asset('images/connected.png',width: 200,height: 200,);
          } else {
            return Image.asset('images/disconnected.png');
          }
        }),
      ),
    );
  }
}

class ConnectivityController extends GetxController {
  var isConnected = true.obs; // Assume connected initially

  @override
  void onInit() {
    super.onInit();
    // Listen for connectivity changes
    Connectivity().checkConnectivity().then((result) {
      isConnected.value = (result != ConnectivityResult.none);
    });

    // Listen for connectivity changes in real-time
    Connectivity().onConnectivityChanged.listen((result) {
      isConnected.value = (result != ConnectivityResult.none);
      if (result == ConnectivityResult.none) {
        // Show error message when disconnected
        Get.snackbar(
          'No Internet',
          'Please check your internet connection',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }
}
