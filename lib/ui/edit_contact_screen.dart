import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {


  String oldname,oldemail,oldaddress;
  int oldphone;

  void Function(
      {required String name,
      required String email,
      required int mobileno,
      required String address,
      required int oldmobile,
      }) editfn;

  EditContact({required this.editfn,required this.oldemail,required this.oldname,required this.oldaddress,required this.oldphone});

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
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
                  initialValue: widget.oldname,
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
                  initialValue: widget.oldemail,
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
                  initialValue: widget.oldphone.toString(),
                  decoration: InputDecoration(
                    labelText: "Enter your mobile number",
                  ),
                  onSaved: (newValue) {
                    mobilenum = int.parse(newValue!);
                  },
                  keyboardType: TextInputType.text,
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
                  initialValue: widget.oldaddress,
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
                widget.editfn(
                  oldmobile: widget.oldphone,
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
    );;
  }
}
