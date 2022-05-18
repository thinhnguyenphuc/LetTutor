import 'package:data_tables/data_tables.dart';
import 'package:flutter/material.dart';
import 'package:project/Utils.dart';
import 'package:project/resources/Strings.dart';
import 'package:project/view_models/WalletViewModel.dart';
import 'package:provider/provider.dart';

import '../../models/PaymentInfoModel.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  WalletPageState createState() => WalletPageState();
}

class WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<WalletViewModel>(context, listen: false).fetchWalletHistory();
  }

  @override
  Widget build(BuildContext context) {
    final walletHistoryListOnProvider = Provider.of<WalletViewModel>(context);
    bool isLoaded = walletHistoryListOnProvider.isFetching;
    List<PaymentInfo> paymentHistory =
        walletHistoryListOnProvider.walletHistory;

    List<DataColumn> paymentColumns = [
      const DataColumn(label: Text("No")),
      const DataColumn(label: Text("Tutor")),
      const DataColumn(label: Text("Time")),
      const DataColumn(label: Text("Status")),
      const DataColumn(label: Text("Type")),
    ];

    final paymentHistoryListView = isLoaded
        ? NativeDataTable.builder(
      rowsPerPage: 20,
      columns: paymentColumns,
      itemCount: 20,
      showSelect: false,
      itemBuilder: (position) {
        final PaymentInfo _info = paymentHistory[position];
        bool isBookingSuccess = _info.status == "success";
        bool isCancelled = _info.type == "cancel";
        return DataRow(cells: [
          DataCell(Text((position + 1).toString())),
          DataCell(
              Text(_info.bookingInfo.scheduleDetailInfo!.tutorInfo!.name)),
          DataCell(Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: Colors.blue.shade900),
                color: Colors.lightBlueAccent.shade100),
            child: Text(
              Utils.parseDateToString(_info.createdAt),
              style: TextStyle(
                color: Colors.blue.shade900,
              ),
            ),
          )),
          DataCell(
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: isBookingSuccess
                            ? Colors.green.shade900
                            : Colors.red.shade900),
                    color: isBookingSuccess
                        ? Colors.greenAccent.shade100
                        : Colors.redAccent.shade100),
                child: Text(
                  isBookingSuccess
                      ? Strings.successBookingStatus
                      : Strings.failedBookingStatus,
                  style: TextStyle(
                      color: isBookingSuccess
                          ? Colors.green.shade900
                          : Colors.red.shade900),
                )),
          ),
          DataCell(
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: isCancelled
                            ? Colors.red.shade800
                            : Colors.green.shade900),
                    color: isCancelled
                        ? Colors.redAccent.shade100
                        : Colors.greenAccent.shade100),
                child: Text(
                  isCancelled
                      ? Strings.cancelBookingStatus
                      : Strings.studyBookingStatus,
                  style: TextStyle(
                      color: isCancelled
                          ? Colors.red.shade900
                          : Colors.green.shade900),
                )),
          ),
        ]);
      },
    )
        : const Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const Text("Transactions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          Expanded(
            child: Scrollbar(child: paymentHistoryListView),
          ),
        ],
      ),
    );
  }
}
