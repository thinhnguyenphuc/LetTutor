import 'package:flutter/cupertino.dart';

import '../data_sources/api_services.dart';
import '../models/EBookModel.dart';

class EBookViewModel with ChangeNotifier {
  List<EBook> eBookList = [];

  getEBookList() async {
    eBookList = await ApiServices().fetchEBook();
    notifyListeners();
  }
}
