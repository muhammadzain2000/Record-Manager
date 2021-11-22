import 'package:flutter/cupertino.dart';
import 'package:record_keeping/dynamic/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User users;

  //GETTER SETTER
  User get user => users;

  set appoint(User value) {
    users = value;
    notifyListeners();
  }
}
