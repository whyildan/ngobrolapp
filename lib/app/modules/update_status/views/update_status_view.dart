import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ngobrolapp/app/controllers/auth_controller.dart';

import '../controllers/update_status_controller.dart';

class UpdateStatusView extends GetView<UpdateStatusController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    controller.statusC.text = authC.user.value.status ?? "";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.red[700],
        title: Text('Update Status'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller.statusC,
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                authC.updateStatus(controller.statusC.text);
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
            SizedBox(
              height: 20,
            ),
            Container(
              width: Get.width,
              child: ElevatedButton(
                onPressed: () {
                  authC.updateStatus(controller.statusC.text);
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
      ),
    );
  }
}
