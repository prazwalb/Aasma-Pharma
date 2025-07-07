import 'package:flutter/material.dart';

class notificationHandler extends StatefulWidget {
  const notificationHandler({super.key});

  @override
  State<notificationHandler> createState() => _notificationHandlerState();
}

class _notificationHandlerState extends State<notificationHandler> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Notification')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //user alarm package for notification.
            ],
          ),
        ),
      ),
    );
  }
}
