import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> chatStreams(String email) {
    return firestore
        .collection('users')
        .doc(email)
        .collection("chats")
        .orderBy("lastTime", descending: true)
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> friendStreams(String email) {
    return firestore.collection('users').doc(email).snapshots();
  }

  void goToChatRoom(String chatId, String email, String friendEmail) async {
    CollectionReference chats = firestore.collection("chats");
    CollectionReference users = firestore.collection("users");

    final updateStatusChat = await chats
        .doc(chatId)
        .collection("chat")
        .where("isRead", isEqualTo: false)
        .where("penerima", isEqualTo: email)
        .get();

    updateStatusChat.docs.forEach((element) async {
      await chats
          .doc(chatId)
          .collection("chat")
          .doc(element.id)
          .update({"isRead": true});
    });

    await users
        .doc(email)
        .collection("chats")
        .doc(chatId)
        .update({"total_unread": 0});

    Get.toNamed(Routes.CHATROOM, arguments: {
      "chat_id": chatId,
      "friendEmail": friendEmail,
    });
  }
}
