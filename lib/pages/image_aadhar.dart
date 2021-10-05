import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import 'practical_page.dart';

class ImageAadhar extends StatelessWidget {
  final String? canid;
  final String? batchId;
  const ImageAadhar({Key? key, this.canid, this.batchId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('RPL-5').doc(canid).snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          DocumentSnapshot documentSnapshot = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Image of Candidate :${documentSnapshot['candidateName']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 22,
                ),
              ),
              Container(
                height: 200,
                width: 200,
                child: ClipRRect(
                  child: Image.network(
                    documentSnapshot['Imageurl'],
                  ),
                ),
              ),
              Divider(
                indent: 100,
                endIndent: 100,
              ),
              Text(
                "Aadhar of Candidate :${documentSnapshot['candidateName']}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 22,
                ),
              ),
              Container(
                height: 200,
                width: 200,
                child: ClipRRect(
                  child: Image.network(
                    documentSnapshot['AadharCardurl'],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: Container(
                    width: 100, height: 50, child: Center(child: Text("Next"))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PracticalPage(
                              canId: canid!,
                              batchid: batchId!,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.greenAccent[700],
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
