import 'dart:async';

import 'package:contact_book_bloc/model/contact.dart';
import 'package:contact_book_bloc/model/contact_list.dart';

class Contactbloc {
  Contact_list? contact_list = Contact_list(allcontacts: []);
  late StreamController<contactAction<Contact_list>> contactController =
      StreamController<contactAction<Contact_list>>();

  StreamSink<contactAction<Contact_list>> get inputsink =>
      contactController.sink;

  Stream<contactAction<Contact_list>> get outputstream =>
      contactController.stream;

  Contactbloc() {
    fetchAllContact();
  }

  fetchAllContact() {
    inputsink.add(contactAction.view(contact_list));
  }

  addContact(
      {required String email,
      required String name,
      required int mobile,
      required String address}) {
    List<Contact> olddata = contact_list?.getContact();
    int index = -1;
    index = olddata.indexWhere((element) => element.mobileNo == mobile);

    if (index >= 0) {
      inputsink.add(contactAction.error("Already exists mobile"));
    } else {
      contact_list?.addnewContact(Contact(
          name: name, email: email, address: address, mobileNo: mobile));
      inputsink.add(contactAction.add(contact_list));
    }
  }

  editContact({
    required String email,
    required String name,
    required int mobile,
    required String address,
    required int previousmobile,
  }) {
    contact_list?.editContact(
        Contact(name: name, email: email, address: address, mobileNo: mobile),
        previousmobile);
    inputsink.add(contactAction.edit(contact_list));
  }

  dispose() {
    contactController.close();
  }
}

class contactAction<T> {
  T? data;
  Actionss actions;
  String? msg;

  contactAction.view(this.data) : actions = Actionss.VIEW;

  contactAction.add(this.data) : actions = Actionss.ADD;

  contactAction.edit(this.data) : actions = Actionss.EDIT;

  contactAction.error(this.msg) : actions = Actionss.ERROR;
}

enum Actionss { ADD, EDIT, VIEW, ERROR }
