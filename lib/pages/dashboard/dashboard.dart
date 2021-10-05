import 'package:flutter/material.dart';
import 'package:rpl5/common/app_colors.dart';
import 'package:rpl5/common/app_responsive.dart';

import 'widget/calender_widget.dart';
import 'widget/header_widget.dart';
import 'widget/notification_card_widget.dart';
import 'widget/profile_card_widget.dart';
import 'widget/recent_prograss_data_widget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController batchIdController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 300, right: 300),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Header Part
          TextField(
            controller: batchIdController,
            decoration: InputDecoration(
              hintText: 'Enter Batch ID',
              filled: true,
              fillColor: Colors.blueGrey[50],
              labelStyle: TextStyle(fontSize: 12),
              contentPadding: EdgeInsets.only(left: 30),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: (Colors.black)),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: (Colors.blueGrey[50])!),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          // ignore: deprecated_member_use
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("START"))),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecruitmentDataWidget(
                        reqId: batchIdController.text,
                      )),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent[700],
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
