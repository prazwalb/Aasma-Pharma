import 'package:flutter/material.dart';

class prescriptionScreen extends StatefulWidget {
  const prescriptionScreen({super.key});

  @override
  State<prescriptionScreen> createState() => _prescriptionScreenState();
}

class _prescriptionScreenState extends State<prescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Prescription')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //camera button // ask for a permission to use camera

              //camera button access garera photo click gareysi ... balla image view ma image aauxa
              //Image view widget
              //  your details : name, phone number, address, gender,
              //Button for submisstion widget. order button
            ],
          ),
        ),
      ),
    );
  }
}
