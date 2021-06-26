import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  AddContact({required this.addfn});

  Function(
      {required String name,
      required String email,
      required int mobileno,
      required String address}) addfn;

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  var formkey = GlobalKey<FormState>();
  late String name, email, address;
  late int mobilenum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter your name",
                  ),
                  onSaved: (newValue) {
                    name = newValue!;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "name cannot be null";
                    } else if (value.isEmpty) {
                      return "name cannot be empty";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter your email",
                  ),
                  onSaved: (newValue) {
                    email = newValue!;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "email cannot be null";
                    } else if (value.isEmpty) {
                      return "email cannot be empty";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter your mobile number",
                  ),
                  onSaved: (newValue) {
                    mobilenum = int.parse(newValue!);
                  },
                  validator: (value) {
                    if (value == null) {
                      return "mobile number cannot be null";
                    } else if (value.isEmpty) {
                      return "mobile number cannot be empty";
                    } else if (int.tryParse(value!).runtimeType != int) {
                      return "must be number";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Address",
                  ),
                  onSaved: (newValue) {
                    address = newValue!;
                  },
                  validator: (value) {
                    if (value == null) {
                      return "address cannot be null";
                    } else if (value.isEmpty) {
                      return "address cannot be empty";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Text("pressed");
                formkey.currentState?.validate();
                formkey.currentState?.save();
                widget.addfn(
                    name: name,
                    address: address,
                    mobileno: mobilenum,
                    email: email);
                Navigator.of(context).pop();
              },
              child: Text("Submit"),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
