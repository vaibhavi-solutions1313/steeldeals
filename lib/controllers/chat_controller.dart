import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:services_provider_application/apis/chat_apis.dart';

class ChatController extends GetxController {
  Timer? time;
  var chatMsgs = [].obs;
  var chatLoadStatus = 0.obs;
  var msgSendLoadStatus = 1.obs;
  TextEditingController chatMsgControl = TextEditingController();

  Future<dynamic> getChatLists() async {
    return await ChatApis().getChatList().then((value) {
      var jsonData = jsonDecode(value.responseBody!);
      return jsonData['data'];
    });
  }

  Future<dynamic> getMsgs(String userId) async {
    chatLoadStatus.value = 0;
    chatMsgs.clear();
    await ChatApis().getMsgs(userId).then((value) {
      chatLoadStatus.value = 1;
      var jsonData = jsonDecode(value.responseBody!);
      chatMsgs.value = jsonData['data'];
      Iterable inReverse = chatMsgs.value.reversed;
      chatMsgs.value = inReverse.toList();
      if (chatMsgs.isEmpty) chatLoadStatus.value = 2;
    });

    // NOW LOOP ON EVERY 8SECONDS
    const oneSec = Duration(seconds: 10);
    time = Timer.periodic(oneSec, (Timer t) {
      ChatApis().getMsgs(userId).then((value) {
        var jsonData = jsonDecode(value.responseBody!);
        chatMsgs.value = jsonData['data'];
        Iterable inReverse = chatMsgs.value.reversed;
        chatMsgs.value = inReverse.toList();
      });
    });
  }

  Future<dynamic> sendMsg(String userId, String msg) async {
    msgSendLoadStatus.value = 0;
    await ChatApis().sendMsg(userId, msg).then((value) async {
      msgSendLoadStatus.value = 1;
      chatMsgControl.clear();
      await ChatApis().getMsgs(userId).then((value) {
        var jsonData = jsonDecode(value.responseBody!);
        chatMsgs.value = jsonData['data'];
        Iterable inReverse = chatMsgs.value.reversed;
        chatMsgs.value = inReverse.toList();
        chatLoadStatus.value = 1;
      });
    });
  }

  Future<dynamic> deleteMsg(String msgId) async {
    return await ChatApis().deleteMsg(msgId);
  }
}
