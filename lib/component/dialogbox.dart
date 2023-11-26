import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

final DateFormat format = DateFormat('yyyy-MM-dd');

void showMyDialog(BuildContext context, String _barcode) {
  showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Container(
          height: 200,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: primery),
              color: white),
          child: Card(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 100,
                  width: 300,
                  child: BarcodeWidget(
                      data: _barcode, barcode: Barcode.code128())),
            ),
          )),
        ),
      );
    },
  );
}

void ShowWorkoutinfo(BuildContext context, String enddate, String desc) {
  Duration indays = DateTime.parse(enddate).difference(DateTime.now());

  showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Container(
          height: 350,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: primery),
              color: white),
          child: Card(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 200,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('${indays.inDays.toString()} Days To End',
                          style: TextStyle(
                              color: Dark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 25,
                      ),
                      Text('Description ',
                          style: TextStyle(
                              color: Dark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 260,
                        child: Text(desc,
                            maxLines: 5,
                            style: TextStyle(
                                color: Dark,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )),
            ),
          )),
        ),
      );
    },
  );
}

void EditWeight(BuildContext context) {
  showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Container(
          height: 350,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: primery),
              color: white),
          child: Card(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 250,
                  width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Update Weight,Height',
                          style: TextStyle(
                              color: Dark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          TextField(),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 20,
                            child: Center(child: Text('kg')),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 260,
                        child: Text("desc",
                            maxLines: 5,
                            style: TextStyle(
                                color: Dark,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )),
            ),
          )),
        ),
      );
    },
  );
}


  // Get.defaultDialog(
  //   title: "Dialog Title",
  //   content: Text("This is the dialog content."),
  //   textConfirm: "Confirm",
  //   textCancel: "Cancel",
  //   onConfirm: () {
  //     // Handle confirm button press.
  //     Get.back(); // Close the dialog
  //   },
  //   onCancel: () {
  //     // Handle cancel button press.
  //     Get.back(); // Close the dialog
  //   },
  // );

