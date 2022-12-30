import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngobrolapp/app/controllers/auth_controller.dart';

import '../controllers/change_profile_controller.dart';

class ChangeProfileView extends GetView<ChangeProfileController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    controller.emailC.text = authC.user.value.email!;
    controller.nameC.text = authC.user.value.name!;
    controller.statusC.text = authC.user.value.status ?? "";
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
          backgroundColor: Colors.red[700],
          title: Text('Update Profil'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                authC.changeProfile(
                  controller.nameC.text,
                  controller.statusC.text,
                );
              },
              icon: Icon(Icons.save),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              AvatarGlow(
                endRadius: 75,
                glowColor: Colors.black,
                duration: Duration(seconds: 2),
                child: Container(
                  margin: EdgeInsets.all(15),
                  width: 120,
                  height: 120,
                  child: Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: authC.user.value.photoUrl! == "noimage"
                          ? Image.asset(
                              "assets/logo/noimage.png",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              authC.user.value.photoUrl!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: controller.emailC,
                textInputAction: TextInputAction.next,
                readOnly: true,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.nameC,
                textInputAction: TextInputAction.next,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Nama",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.statusC,
                textInputAction: TextInputAction.done,
                onEditingComplete: () {
                  authC.changeProfile(
                    controller.nameC.text,
                    controller.statusC.text,
                  );
                },
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: "Status",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<ChangeProfileController>(
                      builder: (c) => c.pickedImage != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 110,
                                  width: 125,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            image: FileImage(
                                              File(c.pickedImage!.path),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -10,
                                        right: -10,
                                        child: IconButton(
                                          onPressed: () => c.resetImage(),
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red[700],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => c
                                      .uploadImage(authC.user.value.uid!)
                                      .then((photoUrl) {
                                    if (photoUrl != null) {
                                      authC.updatePhotoUrl(photoUrl);
                                    }
                                  }),
                                  child: Text(
                                    "upload",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          : Text("No image"),
                    ),
                    TextButton(
                      onPressed: () => controller.selectImage(),
                      child: Text(
                        "pilih file",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: () {
                    authC.changeProfile(
                      controller.nameC.text,
                      controller.statusC.text,
                    );
                  },
                  child: Text(
                    "UPDATE",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
