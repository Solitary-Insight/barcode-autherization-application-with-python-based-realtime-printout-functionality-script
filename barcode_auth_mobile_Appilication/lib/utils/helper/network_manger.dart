import 'dart:async';

import 'package:barcode_auth/Features/common/widgets/loaders.dart';
import 'package:barcode_auth/utils/constants/app_strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class NetworkManager extends GetxController {
  List<ConnectivityResult> connection = [ConnectivityResult.none];
  late StreamSubscription<List<ConnectivityResult>> connection_subscribtion;
  static NetworkManager get instance=>Get.find();
   RxBool CONNECTED=false.obs;
   final Connectivity _connectivity=Connectivity();
  @override
  void onInit() async {
    connection_subscribtion =
        Connectivity().onConnectivityChanged.listen((result) {
      connection=result;
      CONNECTED.value=result!=ConnectivityResult.none;
    });
    checkForConnection();

    }
  

  // Bind custom event to the network stream  return stream back
  StreamSubscription<List<ConnectivityResult>> bindEvent(
      Future<void> Function() action) {
    return Connectivity().onConnectivityChanged.listen((result) {
      if(result!=ConnectivityResult.none){
        action().catchError((e){
        loader.errorSnackBar(title: "Failed to execute function");
      });
      }else{
        CONNECTED.value=T;
      }
    });
      }
  
  @override
  void onClose() {
    // Close connection subscription

    connection_subscribtion.cancel();
  }

  // Return true if connected the internet
  Future<bool> isConnected()  async{
     try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }
  
  void showNetworkErrorMessage({String ? title, String ? message}) {
    loader.errorSnackBar(
            title: title??AppStrings.CONNECTION_ERROR_TITLE,
            message:message?? AppStrings.CONNECTION_ERROR_MESSAGE);
  }
  
  void checkForConnection() async {
    //  bool status=await isConnected();
    // if( status ){
    //   showNetworkErrorMessage(message: connection.toString());

    // }
  }

      
      
      }