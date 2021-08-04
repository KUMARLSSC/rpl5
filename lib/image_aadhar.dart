import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rpl5/candidate_page.dart';

import 'common/app_colors.dart';

class ImageAadhar extends StatelessWidget {
  const ImageAadhar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('RPL-5Image').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[1];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Image of Candidate :${documentSnapshot['candidateID']}",
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
                        documentSnapshot['url'],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
        Divider(
          indent: 100,
          endIndent: 100,
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('RPL-5AadharCard')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              DocumentSnapshot documentSnapshot = snapshot.data.docs[1];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Aadhar of Candidate :${documentSnapshot['candidateID']}",
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
                        documentSnapshot['url'],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
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
              MaterialPageRoute(builder: (context) => CandidatePage()),
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
}
