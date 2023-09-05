import 'package:flutter/material.dart';
import 'package:localdatabase/dbhelper/my_db_helper.dart';
import 'package:localdatabase/model/contact.dart';
import 'package:localdatabase/widget/new_contact.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PhoneBook"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Mydbhelper.readContact(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Loading......")
                ],
              ),
            );
          }
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('No Data'),
                )
              : ListView(
                  children: snapshot.data!.map((e) {
                    return Center(
                      child: ListTile(
                        title: Text(e.name),
                        subtitle: Text(e.phone),
                        trailing: IconButton(
                            onPressed: () async {
                              await Mydbhelper.deleteContact(e.id);
                              setState(() {});
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewContacts()));
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
