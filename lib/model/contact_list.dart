import 'package:contact_book_bloc/model/contact.dart';

class Contact_list {
  List<Contact> allcontacts;

  Contact_list({
    required this.allcontacts,
  });

  addnewContact(Contact contact) {
    allcontacts.add(contact);
    return allcontacts;
  }

  editContact(Contact contact, int mobile) {
    int index = allcontacts.indexWhere((element) => element.mobileNo == mobile);
    allcontacts.removeAt(index);
    allcontacts.add(contact);
    return allcontacts;
  }

  deletContact(Contact contact){
    allcontacts.remove(contact);
  }

  getContact() {
    return allcontacts;
  }
}
