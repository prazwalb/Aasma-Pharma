import 'package:flutter/material.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Chat with Pharmacist')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //Image view for male and female
              //when user click on image view male or female then show the chatbot screen
              //chatbot screen will have a text field and a button to send message
              //when user send message then show the message in the chatbot screen
              //when user click on fileupload button then show the file permission dialog
              //when user click accept file permission dialog then show the file upload screen.
            ],
          ),
        ),
      ),
    );
  }
}
