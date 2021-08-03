import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_video_player/flutter_web_video_player.dart';

import 'common/app_colors.dart';

class CandidatePage extends StatefulWidget {
  CandidatePage({
    Key? key,
  }) : super(key: key);

  @override
  _CandidatePageState createState() => _CandidatePageState();
}

class _CandidatePageState extends State<CandidatePage> {
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('RPL-5PracticalVideo').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // ignore: missing_required_param
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('RPL-5PracticalVideo')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data.docs[index];
                    return Container(
                      height: 500,
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            color: AppColor.bgSideMenu,
                            child: Center(
                              child: Text(
                                documentSnapshot['Nos'],
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Card(
                            color: Colors.grey[700],
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0,
                                  bottom: 15.0,
                                  left: 16.0,
                                  right: 16.0),
                              child: Text(
                                documentSnapshot['commonQuestion'] == null
                                    ? 'No Common Question for this ${documentSnapshot['Nos']}'
                                    : documentSnapshot['commonQuestion'],
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Text(
                            documentSnapshot['Question'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                              fontSize: 22,
                            ),
                          ),
                          // If the image is not null load the imageURL
                          documentSnapshot['url'] != null
                              ? SizedBox(
                                  height: 250,
                                  child: WebVideoPlayer(
                                    src: documentSnapshot['url'],
                                  ))
                              // If the image is null show nothing
                              : Container(),
                          Text(
                            'Max Marks : 10',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                              fontSize: 22,
                            ),
                          ),
                          Container(
                            width: 200,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Enter Marks here',
                                filled: true,
                                fillColor: Colors.blueGrey[100],
                                labelStyle: TextStyle(fontSize: 12),
                                contentPadding: EdgeInsets.only(left: 30),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: (Colors.blueGrey[50])!),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: (Colors.blueGrey[50])!),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(blurRadius: 8, spreadRadius: 3)
                          ]),
                    );
                  });
            }
          },
        ));
  }
}
