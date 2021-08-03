import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageAadhar extends StatelessWidget {
  const ImageAadhar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
