import 'package:flutter/cupertino.dart';

import '../data_sources/api_services.dart';
import '../models/BookingInfoModel.dart';
import '../models/ServiceMessageModel.dart';

class BookingViewModel with ChangeNotifier {
  List<BookingInfo> bookingList = [];

  Future<ServiceMessage> bookAClass(String scheduleDetailId, String  note) async {
    ServiceMessage res =  await ApiServices().bookClass(scheduleDetailId, note);
    return res;
  }

  List<BookingInfo> getCategoryList() {
    return bookingList.where((o) => o.isDeleted).toList();
  }
}

