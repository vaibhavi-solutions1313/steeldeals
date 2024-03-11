import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:services_provider_application/main.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

import 'chat_view.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({Key? key}) : super(key: key);

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleAppBar("Chat List"),
          Expanded(
            child: FutureBuilder<dynamic>(
                future: chatControl.getChatLists(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    if (snapshot.data.isNotEmpty) {
                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data.length,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.grey.shade200,
                          );
                        },
                        itemBuilder: (context, index) {
                          final DateTime now = DateTime.parse(snapshot.data[index]['created_at'].toString());
                          final DateFormat formatter = DateFormat('dd-MM-yyyy');
                          final String formatted = formatter.format(now);
                          return ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 25),
                            onTap: () {
                              Get.to(
                                  ChatView(
                                      user_id: snapshot.data[index]['user_id'].toString(),
                                      senderId: snapshot.data[index]['sender_id'].toString(),
                                      title: snapshot.data[index]['name'].toString()),
                                  transition: Transition.rightToLeft);
                            },
                            title: Text(
                              snapshot.data[index]['name'],
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              snapshot.data[index]['message'],
                              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.black54),
                            ),
                            trailing: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(formatted),
                                // IconButton(
                                //     onPressed: () {
                                //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Coming Soon.")));
                                //       // chatControl.deleteMsg("PENDING").then((value) {
                                //       //   setState(() {
                                //       //
                                //       //   });
                                //       // });
                                //     },
                                //     icon: Icon(
                                //       Icons.delete,
                                //       color: Color(0xFFF5951D),
                                //     ))
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text("No Chat Found!"));
                    }
                  } else {
                    return Center(child: Text("No Chat Found!"));
                  }
                }),
          )
        ],
      ),
    );
  }
}
