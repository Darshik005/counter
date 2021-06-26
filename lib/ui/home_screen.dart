import 'package:contact_book_bloc/bloc/contact_bloc.dart';
import 'package:contact_book_bloc/model/contact.dart';
import 'package:contact_book_bloc/model/contact_list.dart';
import 'package:contact_book_bloc/ui/add_contact_screen.dart';
import 'package:contact_book_bloc/ui/edit_contact_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Contactbloc _bloc = Contactbloc();

  addContact(
      {required String name,
      required String email,
      required int mobileno,
      required String address}) {
    _bloc.addContact(
        email: email, name: name, mobile: mobileno, address: address);
  }

  @override
  Widget build(BuildContext context) {
    void editContactFn({
      required String name,
      required String email,
      required int mobileno,
      required String address,
      required int oldmobile,
    }) {
      _bloc.editContact(
          email: email,
          name: name,
          mobile: mobileno,
          address: address,
          previousmobile: oldmobile);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("View Contact"),
        actions: [
          GestureDetector(
            child: Icon(Icons.add),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddContact(addfn: addContact),
                ),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<contactAction<Contact_list>>(
          stream: _bloc.outputstream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.actions!) {
                case Actionss.VIEW:
                  if (snapshot.data!.data!.allcontacts.isEmpty) {
                    return Center(
                      child: Text("Contact list is empty Please Start adding"),
                    );
                  } else {
                    List<Contact> contactdata =
                        snapshot.data!.data!.allcontacts;
                    return buildListView(contactdata, editContactFn, snapshot);
                  }
                  break;
                case Actionss.ADD:
                  List<Contact> contactdata = snapshot.data!.data!.allcontacts;
                  return buildListView(contactdata, editContactFn, snapshot);
                  break;
                case Actionss.EDIT:
                  List<Contact> contactdata = snapshot.data!.data!.allcontacts;
                  return buildListView(contactdata, editContactFn, snapshot);
                  break;
                case Actionss.ERROR:
                  return Center(
                    child: Text("Phone num already exists"),
                  );
                  break;
                default:
                  return Text("Something went wrong");
              }
            }
            return Text("Null");
          }),
    );
  }

  ListView buildListView(
      List<Contact> contactdata,
      void editContactFn(
          {required String address,
          required String email,
          required int mobileno,
          required String name,
          required int oldmobile}),
      AsyncSnapshot<contactAction<Contact_list>> snapshot) {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(contactdata[index].name),
                  Text(contactdata[index].email),
                  Text(contactdata[index].mobileNo.toString()),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditContact(
                            oldaddress: contactdata[index].address,
                            oldname: contactdata[index].name,
                            oldemail: contactdata[index].email,
                            oldphone: contactdata[index].mobileNo,
                            editfn: editContactFn,
                          ),
                        ),
                      );
                    },
                    child: Icon(Icons.edit),
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: () {
                      _bloc.deleteContact(contactdata[index]);
                    },
                    child: Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      itemCount: snapshot.data!.data!.allcontacts.length,
    );
  }
}
