import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/main.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

class ChatView extends StatefulWidget {
  final String user_id;
  final String senderId;
  final String? title;
  const ChatView({Key? key, required this.user_id, this.title, required this.senderId}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool isReceiver = false;

  @override
  void initState() {
    chatControl.msgSendLoadStatus.value = 1;
    chatControl.getMsgs(widget.user_id);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    chatControl.chatMsgControl.clear();
    chatControl.time!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleAppBar(widget.title ?? "NIL"),
          Expanded(
            child: Obx(() => chatControl.chatLoadStatus.value == 1
                ? ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 18.sp),
                    shrinkWrap: true,
                    itemCount: chatControl.chatMsgs.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      if(chatControl.chatMsgs[index]['receiver_id'] == int.parse(widget.user_id)) {
                        isReceiver = true;
                      } else {
                        isReceiver = false;
                      }
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          crossAxisAlignment: isReceiver == true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: isReceiver == true ? const Color(0xff424F63) : Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.sp)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Text(
                                  chatControl.chatMsgs[index]['message'].toString(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: isReceiver == true ? const Color(0xffF7FBFF) : const Color(0xff213241),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                : chatControl.chatLoadStatus.value == 0
                    ? Center(child: CircularProgressIndicator())
                    : Text("No Messages Found!")),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.sp,vertical: 12.sp),
          color: Colors.grey.shade300,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: chatControl.chatMsgControl,
                  decoration: InputDecoration(hintText: "Type message...", border: InputBorder.none),
                ),
              ),
              Obx(
                () => chatControl.msgSendLoadStatus == 0
                    ? SizedBox(width: 15.sp, height: 15.sp, child: CircularProgressIndicator())
                    : IconButton(
                        onPressed: () {
                          if (chatControl.chatMsgControl.text.isNotEmpty) {
                            chatControl.sendMsg(widget.user_id, chatControl.chatMsgControl.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please write something before sending."),
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.send_rounded,
                          size: 18.sp,
                          color: Color(0xFF213C63),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
