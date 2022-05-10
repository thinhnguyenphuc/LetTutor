import 'package:flutter/material.dart';
import 'package:project/data_sources/api_services.dart';

import '../models/PaymentInfoModel.dart';

class WalletViewModel with ChangeNotifier {
  bool isFetching = false;
  List<PaymentInfo> walletHistory = [];

  fetchWalletHistory() async {
    await ApiServices().fetchPaymentHistory().then((value) => walletHistory = value.message);
    isFetching = true;
    notifyListeners();
  }
}