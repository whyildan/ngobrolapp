import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController nameC;
  late TextEditingController statusC;
  late ImagePicker imagePicker;

  XFile? pickedImage = null;

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadImage(String uid) async {
    Reference storageRef = storage.ref("$uid.png");
    File file = File(pickedImage!.path);

    try {
      final dataUpload = await storageRef.putFile(file);

      final photoUrl = await storageRef.getDownloadURL();
      resetImage();
      return photoUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void selectImage() async {
    try {
      final dataImage =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (dataImage != null) {
        print(dataImage.name);
        pickedImage = dataImage;
      }

      update();
    } catch (e) {
      print(e);
      pickedImage = null;
      update();
    }
  }

  void resetImage() {
    pickedImage = null;
    update();
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    nameC = TextEditingController();
    statusC = TextEditingController();
    imagePicker = ImagePicker();
    super.onInit();
  }

  @override
  void onClose() {
    emailC.dispose();
    nameC.dispose();
    statusC.dispose();
    super.onClose();
  }
}
