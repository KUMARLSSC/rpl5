import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rpl5/common/app_colors.dart';
import 'package:rpl5/pages/video_page.dart';

class CandidateMarkCheck extends StatefulWidget {
  final String? reqId;
  final String? canId;
  final String? name;
  const CandidateMarkCheck({Key? key, this.reqId, this.canId, this.name})
      : super(key: key);

  @override
  State<CandidateMarkCheck> createState() => _CandidateMarkCheckState();
}

class _CandidateMarkCheckState extends State<CandidateMarkCheck> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Candidates From Batch-ID ${widget.reqId!}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.black,
                fontSize: 22,
              ),
            ),
            Text(
              "Candidates ID - ${widget.canId!}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.black,
                fontSize: 22,
              ),
            ),
            Text(
              "Candidates Name - ${widget.name!}",
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
              .doc(widget.canId)
              .collection(widget.reqId! + widget.canId!)
              .orderBy('slno')
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                height: MediaQuery.of(context).size.height - 50,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                    columns: <DataColumn>[
                      new DataColumn(
                        label: Text('Sl.No'),
                        tooltip: 'Serial Number',
                      ),
                      new DataColumn(label: Text('NOS')),
                      new DataColumn(label: Text('CommonQuestion')),
                      new DataColumn(label: Text('Question')),
                      new DataColumn(label: Text('MAXMarks')),
                      new DataColumn(label: Text('GivenMarks')),
                      new DataColumn(label: Text('Videos'))
                    ],
                    rows: _createRows(snapshot.requireData),
                  ),
                ),
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
      return new DataRow(cells: [
        DataCell(Text(documentSnapshot['slno'].toString())),
        DataCell(Text(documentSnapshot['Nos'])),
        DataCell(Text(documentSnapshot['commonQuestion'])),
        DataCell(Text(documentSnapshot['Question'])),
        DataCell(Text(documentSnapshot['MAXMarks'].toString())),
        DataCell(Text(documentSnapshot['GivenMarks'].toString())),
        DataCell(ElevatedButton(
          child: Container(
              width: 80, height: 20, child: Center(child: Text("Play"))),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VideoPage(
                          url: documentSnapshot['url'],
                        )));
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.greenAccent[700],
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ))
      ]);
    }).toList();

    return newList;
  }
}
