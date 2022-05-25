import 'package:flutter/cupertino.dart';

import '../data_sources/api_services.dart';
import '../models/EBookModel.dart';

class EBookViewModel with ChangeNotifier {
  List<EBook> eBookList = [];

  getEBookList() async {
    eBookList = await ApiServices().fetchEBook();
    notifyListeners();
  }

  List<EBook> searchEBookList(String name) {
    List<EBook> res = eBookList.where((book) => book.name.contains(name)).toList();
    return res;
  }
}
