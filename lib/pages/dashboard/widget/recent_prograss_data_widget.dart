import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:rpl5/common/app_colors.dart';
import 'package:rpl5/pages/candidate_mark_check_page.dart';

import '../../image_aadhar.dart';

class RecruitmentDataWidget extends StatefulWidget {
  final String? reqId;
  RecruitmentDataWidget({
    required this.reqId,
  });
  @override
  _RecruitmentDataWidgetState createState() => _RecruitmentDataWidgetState();
}

class _RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Candidates From Batch-ID ${this.widget.reqId}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.black,
                fontSize: 22,
              ),
            ),
          ],
        ),
        Divider(
          thickness: 0.5,
          color: Colors.grey,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('RPL-5')
              .where("batchId", isEqualTo: int.parse(this.widget.reqId!))
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return DataTable(
                columns: <DataColumn>[
                  new DataColumn(
                    label: Text('Candidate ID'),
                    tooltip: 'Candidate ID)',
                  ),
                  new DataColumn(label: Text('Name')),
                  new DataColumn(label: Text('Assessment Date')),
                  new DataColumn(label: Text('Batch ID')),
                  new DataColumn(label: Text('Status')),
                ],
                rows: _createRows(snapshot.requireData),
              );
            }
          },
        ),
      ],
    );
  }

  List<DataRow> _createRows(QuerySnapshot snapshot) {
    List<DataRow> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      Timestamp timestamp = documentSnapshot['UploadDate&Time'];
      String formattedDate =
          DateFormat('dd-MM-yyyy').format(timestamp.toDate());
      return new DataRow(cells: [
        DataCell(Text(documentSnapshot['candidateID'])),
        DataCell(Text(documentSnapshot['candidateName'])),
        DataCell(Text(formattedDate)),
        DataCell(Text(documentSnapshot['batchId'].toString())),
        DataCell(ElevatedButton(
          child: Container(
              width: 80,
              height: 20,
              child: Center(
                  child: Text(documentSnapshot['MarkEntered'] == false
                      ? "Pending"
                      : "Completed"))),
          onPressed: () => documentSnapshot['MarkEntered'] == false
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageAadhar(
                            canid: documentSnapshot['candidateID'],
                            batchId: this.widget.reqId,
                          )))
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CandidateMarkCheck(
                            canId: documentSnapshot['candidateID'],
                            reqId: this.widget.reqId,
                            name: documentSnapshot['candidateName'],
                          ))),
          style: ElevatedButton.styleFrom(
            primary: documentSnapshot['MarkEntered'] == false
                ? Colors.redAccent[700]
                : Colors.greenAccent[700],
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        )),
      ]);
    }).toList();

    return newList;
  }
}
