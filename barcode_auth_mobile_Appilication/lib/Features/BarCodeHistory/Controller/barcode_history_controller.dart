import 'dart:async';

import 'package:barcode_auth/Features/Barcode_Creation/User_model.dart';
import 'package:barcode_auth/Features/Common/Home/Controller/home_controller.dart';
import 'package:barcode_auth/Features/common/widgets/loaders.dart';
import 'package:barcode_auth/utils/constants/app_colors.dart';
import 'package:barcode_auth/utils/constants/app_resources.dart';
import 'package:barcode_auth/utils/constants/app_strings.dart';
import 'package:barcode_auth/utils/helper/network_manger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

class BarcodeHistoryController extends GetxController {
  BarcodeHistoryController();

  final DatabaseReference _dbRef = FirebaseDatabase.instance
      .ref()
      .child(AppStrings.AUTHERIZED_USER_PARENT_NODE);
  static BarcodeHistoryController get instance => Get.find();
  String? lastKey;

  RxList<String> keys = <String>[].obs;
  RxList<UserModel> users = <UserModel>[].obs;

  RxString are_user_loading = "NO".obs;
  late StreamSubscription<List<ConnectivityResult>>? network_stream;

  @override
  void onInit() async {
    // super.onInit();
    bool status = await NetworkManager.instance.isConnected();
    if (!status) {
      NetworkManager.instance.showNetworkErrorMessage();
      network_stream = NetworkManager.instance.bindEvent(fetchUsers);
      are_user_loading.value = "QUEUED";
    } else {
      loadUsers();
    }
  }

  Future<void> fetchUsers() async {
    await loadUsers();
    network_stream?.cancel();
  }

  List<UserModel> _processSnapshot(DataSnapshot snapshot) {
    // Processing the snapshot
    return snapshot.children.map((childSnapshot) {
      Map<String, dynamic> data =
          Map<String, dynamic>.from(childSnapshot.value as Map);
      String key = childSnapshot.key ?? "";
      return UserModel.fromSnapshot(data, key);
    }).toList();
  }


// Handle new child added in real-time
  void _handleChildAdded(DatabaseEvent event) {
    DataSnapshot childSnapshot = event.snapshot;
    Map<String, dynamic> data =
        Map<String, dynamic>.from(childSnapshot.value as Map);
    String key = childSnapshot.key ?? "";

    // Create new user model from the snapshot
    UserModel newUser = UserModel.fromSnapshot(data, key);

    // Add the new user to the users list
    users.add(newUser);
    // print("User added: $newUser");
  }

// Handle child removed in real-time
  void _handleChildRemoved(DatabaseEvent event) {
    DataSnapshot childSnapshot = event.snapshot;
    String key = childSnapshot.key ?? "";

    // Find and remove the user from the users list by key
    users.removeWhere((user) => user.key == key);
    // Get ("User removed: $key");
  }

  Future<void> loadUsers() async {
    try {
      are_user_loading.value = "YES";

      // Optionally set loading message
      // HomeController.instance.setFullScreenLoading("Loading user data",
      //    AppResources.SAVING_ANIMATION, "Wait until users are loaded...");

      // Fetch the data from Firebase
      DataSnapshot snapshot = await _dbRef.get();

      // Process the fetched data and add to users
      users.addAll(_processSnapshot(snapshot));
      _dbRef.onChildAdded.listen((event) {
        _handleChildAdded(event);
      });

      _dbRef.onChildRemoved.listen((event) {
        _handleChildRemoved(event);
      });
    } catch (e) {
      // Handle error and show appropriate message or logs
      Get.snackbar("Error loading users", "$e",
          backgroundColor: AppColors.error);

      // You can also display a custom error message or dialog to the user
      // HomeController.instance.showError("Failed to load users");
    } finally {
      // Ensure loading is set to false regardless of success or error
      are_user_loading.value = "DONE";
    }
  }

  deleteUserRecord(String userKey) async {
    try {
      // Simulate a failure condition (e.g., userKey is empty)
      if (userKey.isEmpty) {
        throw Exception("User key cannot be empty!");
      }
      _dbRef.child(userKey).remove();
    
      // Code to delete the user record from the database
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
