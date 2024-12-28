import 'package:barcode_auth/Features/BarCodeHistory/Screen/barcode_history.dart';
import 'package:barcode_auth/Features/Barcode_Authentication/Screen/Scan_Barcode.dart';
import 'package:barcode_auth/Features/Barcode_Creation/Screen/create_barcode.dart';
import 'package:barcode_auth/Features/Barcode_Creation/Screen/progress_page.dart';
import 'package:barcode_auth/utils/constants/app_resources.dart';
import 'package:barcode_auth/utils/helper/network_manger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomeController  extends GetxController{
  static HomeController get instance=> Get.find();
  RxInt current_page_index = 0.obs;

  List<Widget> pages=[
    const CreateBarCode(),
    ScanBarcode(),
    BarcodeHistory()
  ];


  
  Rx<Widget> progress_overlay=ProgressPage(heading: "Processing", bottom: "Please wait", animation: AppResources.SAVING_ANIMATION).obs;
 
   RxBool full_screen_loading=false.obs;
   
  // Method to update the widget
  void updatepage(int n) {
    current_page_index.value = n;
  }
  void setFullScreenLoading(String heading, String animation, String bottom){
    full_screen_loading.value=true;
    progress_overlay.value=ProgressPage(heading:heading,animation:animation,bottom:bottom);
  }
  void offFullScreenLoading(){
    full_screen_loading.value=false;
  }

  
@override
  void onInit()async {
    bool status=await  NetworkManager.instance.isConnected();
   if(status){
    NetworkManager.instance.showNetworkErrorMessage();
   }
  }


 

}