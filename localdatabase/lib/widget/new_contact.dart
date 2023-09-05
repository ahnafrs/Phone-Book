import 'package:flutter/material.dart';
import 'package:localdatabase/dbhelper/my_db_helper.dart';
import 'package:localdatabase/model/contact.dart';
import 'package:localdatabase/widget/demo.dart';

class NewContacts extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Contacts"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  label: Text("Name"),
                  hintText: "Put your name here",
                  prefixIcon: Icon(Icons.people),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                  label: Text("Phone Number"),
                  hintText: "Put your phone number here",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  Mydbhelper.createContact(Contact(
                      name: _nameController.text,
                      phone: _phoneController.text));
                  // Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => DemoPage(),
                    ),
                  );
                },
                child: Text("Save")),
          ],
        ),
      ),
    );
  }
}
