import 'package:flutter/material.dart';
import 'package:services_provider_application/widgets/simple_app_bar.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleAppBar("Notification"),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No Notification Received.")
              ],
            ),
          )
        ],
      ),
    );
  }
}
