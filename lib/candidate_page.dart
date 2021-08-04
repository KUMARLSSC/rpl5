import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_video_player/flutter_web_video_player.dart';
import 'package:http/http.dart' as http;
import 'package:rpl5/login_page.dart';
import 'api_data_model.dart';
import 'common/app_colors.dart';

class CandidatePage extends StatefulWidget {
  CandidatePage({
    Key? key,
  }) : super(key: key);

  @override
  _CandidatePageState createState() => _CandidatePageState();
}

class _CandidatePageState extends State<CandidatePage> {
  var client = new http.Client();
  List datas = [];
  bool _isloading = false;
  double? _progress;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('RPL-5PracticalVideo').snapshots();
  }

  Future<List<PracticalResult>?> updateTheory(
      List<PracticalResult> list) async {
    var body = json.encode(list);
    final response = await client.post(
        Uri.parse(
            'https://webapplication320200218110357.azurewebsites.net/api/PracticalResult'),
        body: body,
        headers: {'Content-type': 'application/json; charset=UTF-8'});
    print(response.headers);
    if (response.statusCode == 201) {
      final String responseString = response.body;

      return practicalResultFromJson(responseString);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // ignore: missing_required_param
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('RPL-5PracticalVideo')
              .orderBy('UploadDate&Time', descending: false)
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
                    datas = snapshot.data.docs;
                    List<TextEditingController> markTextEditController =
                        List.generate(
                            datas.length, (i) => TextEditingController());
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${documentSnapshot['slno'].toString()} : ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black,
                                  fontSize: 22,
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
                            ],
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
                            'Max Marks : ${documentSnapshot['MAXMarks']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                              fontSize: 22,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                child: TextField(
                                  controller: markTextEditController[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Marks here',
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelStyle: TextStyle(fontSize: 12),
                                    contentPadding: EdgeInsets.only(left: 30),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                child: Container(
                                    width: 100,
                                    height: 50,
                                    child: Center(child: Text("Submit"))),
                                onPressed: () {
                                  try {
                                    FirebaseFirestore.instance
                                        .collection('RPL-5PracticalMark')
                                        .doc()
                                        .set({
                                      'candidateID': 123,
                                      'candidateName': 'Abc',
                                      'Nos': documentSnapshot['Nos'],
                                      'slno': documentSnapshot['slno'],
                                      'commonQuestion':
                                          documentSnapshot['commonQuestion'],
                                      'Question': documentSnapshot['Question'],
                                      'MAXMarks': documentSnapshot['MAXMarks'],
                                      'GivenMarks':
                                          markTextEditController[index].text,
                                      'UploadDate&Time':
                                          FieldValue.serverTimestamp()
                                    }).whenComplete(() => showDialog(
                                            barrierDismissible: true,
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: Text("Success"),
                                                  actions: <Widget>[
                                                    // ignore: deprecated_member_use
                                                    FlatButton(
                                                      child: Text('Ok'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    )
                                                  ],
                                                )));
                                  } catch (e) {
                                    print(e);
                                  }
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
                          )
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
