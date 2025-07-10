import 'package:flutter/material.dart';
import 'package:medilink/pages/add.prescription.view.dart';
import 'package:medilink/pages/my.prescriptions.dart';
import 'package:medilink/pages/profile.page.dart';
import 'package:medilink/widgets/all.items.grid.list.dart';
import 'package:medilink/widgets/pharamacies.horizontal.list.dart';
import 'package:medilink/widgets/welcome.text.dart';

class WelcomeHomePage extends StatelessWidget {
  const WelcomeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Aansa Pharma'),
        title: WelcomeTitle(),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyPrescriptions()));
            },
            icon: const Icon(Icons.medication_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
       scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WelcomeTitle(),
              // SizedBox(
              //   height: 10,
              // ),
              Form(child: TextField(decoration: InputDecoration(prefixIcon:Icon(Icons.search) ),),),
              Divider(),
              Text(
                "Pharmacies",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              PharmaciesHorizontalList(),
              Divider(),
              Text(
                "Items",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              AllItemsGridList()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AddPrescriptionView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
