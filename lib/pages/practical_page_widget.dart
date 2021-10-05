// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// ignore: unused_import
import 'package:flutter_web_video_player/flutter_web_video_player.dart';
import 'package:http/http.dart' as http;
import 'package:rpl5/ApiModel/practical_question_model.dart';
import 'package:rpl5/ApiModel/route_names.dart';
import 'package:rpl5/pages/video_page.dart';
import 'package:rpl5/services/dialog_service.dart';
import 'package:rpl5/services/navigation_service.dart';
import '../ApiModel/practical_result_model.dart';
import '../common/app_colors.dart';
import '../locator.dart';

class PracticalPageWidget extends StatefulWidget {
  final String? batchid;
  final String? canId;
  final List<Practical>? practical;
  final Practical? practical1;
  PracticalPageWidget(
      {Key? key, this.batchid, this.practical, this.practical1, this.canId})
      : super(key: key);

  @override
  _PracticalPageWidgetState createState() => _PracticalPageWidgetState();
}

class _PracticalPageWidgetState extends State<PracticalPageWidget> {
  var client = new http.Client();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  int _currentIndex = 0;
  int? maxMark;
  final Map<int, dynamic> _answers = {};
  List listofmarks = [];
  final TextEditingController textEditingController =
      new TextEditingController();
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _text = 0;
    this
        .widget
        .practical!
        .retainWhere((element) => element.pqLang!.contains('English'));
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height - 30,
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            color: AppColor.bgSideMenu,
            child: Text(
              widget.practical![_currentIndex].pqNos!,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Card(
            color: Colors.grey[700],
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 15.0, left: 16.0, right: 16.0),
              child: Text(
                widget.practical![_currentIndex].pqCommonQuestion! != null
                    ? widget.practical![_currentIndex].pqCommonQuestion!
                    : "No Common Question for this ${widget.practical![_currentIndex].pqNos!} ",
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
                "${_currentIndex + 1}: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 22,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(
                  widget.practical![_currentIndex].pqQuestion!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.black,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width - 1200,
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('RPL-5')
                    .doc(this.widget.canId!)
                    .collection(this.widget.batchid! + this.widget.canId!)
                    .where("slno", isEqualTo: _currentIndex + 1)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];

                          return Container(
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              splashColor: Colors.blue,
                              elevation: 5.0,
                              color: Colors.black,
                              child: Text(
                                "Play",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoPage(
                                              url: data['url'],
                                            )));
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          );
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
          Text(
            "Max Marks:${widget.practical![_currentIndex].pqMarks!.toString()}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.black,
              fontSize: 22,
            ),
          ),
          Container(
            width: 200,
            child: TextField(
              controller: textEditingController,
              keyboardType: TextInputType.number,
              onChanged: (v) => setState(() {
                _text = int.parse(v);
                _answers[_currentIndex] = v;
              }),
              decoration: InputDecoration(
                hintText: _text.toString(),
                filled: true,
                fillColor: Colors.white,
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.only(left: 30),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                splashColor: Colors.blue,
                elevation: 5.0,
                color: _currentIndex ==
                        (widget.practical!.length +
                            1 -
                            widget.practical!.length -
                            1)
                    ? Colors.white30
                    : new Color(0xFFEA4335),
                child: Text(
                  'Previous',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: _currentIndex ==
                              (widget.practical!.length +
                                  1 -
                                  widget.practical!.length -
                                  1)
                          ? Colors.black
                          : Colors.white),
                ),
                onPressed: () {
                  _currentIndex ==
                          (widget.practical!.length +
                              1 -
                              widget.practical!.length -
                              1)
                      // ignore: unnecessary_statements
                      ? null
                      : _previous();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                splashColor: Colors.blue,
                elevation: 5.0,
                color: new Color(0xFF34A853),
                child: Text(
                  _currentIndex == (widget.practical!.length - 1)
                      ? "Submit"
                      : "Next",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  _nextSubmit(mark: textEditingController.text);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(blurRadius: 8, spreadRadius: 3)]),
    ));
  }

  void _nextSubmit({@required String? mark}) async {
    if (_answers[_currentIndex] == null) {
      EasyLoading.show(status: 'Failed...').whenComplete(() => [
            EasyLoading.showError('You must enter a mark to continue'),
            EasyLoading.dismiss(),
          ]);
    }
    if (int.parse(mark!) > widget.practical![_currentIndex].pqMarks!) {
      EasyLoading.show(status: 'Failed...').whenComplete(() => [
            EasyLoading.showError('Input value is greater than Maximum Marks'),
            EasyLoading.dismiss(),
          ]);
      return;
    }

    if (_currentIndex < (widget.practical!.length) - 1) {
      setState(() {
        _currentIndex++;
        listofmarks.add(int.parse(textEditingController.text));
        print(listofmarks);
      });
      setState(() {
        textEditingController.clear();
      });
    } else {
      setState(() {
        listofmarks.add(int.parse(textEditingController.text));
        print(listofmarks);
      });
      FirebaseFirestore.instance
          .collection('RPL-5')
          .doc(this.widget.canId)
          .update({
        'MarkEntered': true,
        'MarkUpdateTimeDate': FieldValue.serverTimestamp()
      });

      var tempManipulatedData = {};
      this._answers.forEach((index, value) {
        var quesObj = this.widget.practical![index];
        String? tqNos = quesObj.pqNos;
        if (tqNos == null) {
          tqNos = "0";
        }
        if (tempManipulatedData[tqNos] == null) {
          tempManipulatedData[tqNos] = PracticalResult.fromJson({
            'prId': 0,
            'prbatchId': int.parse(this.widget.batchid!),
            'prCandidateId': this.widget.canId,
            'prQuestionId': 0,
            'prMarks': 0,
            'prNos': quesObj.pqNos == null ? 'null' : tqNos,
            'prType': false,
          });
        }
        tempManipulatedData[tqNos].prQuestionId =
            tempManipulatedData[tqNos].prQuestionId + quesObj.pqMarks;
        tempManipulatedData[tqNos].prMarks =
            tempManipulatedData[tqNos].prMarks + listofmarks[index];

        FirebaseFirestore.instance
            .collection('RPL-5')
            .doc(this.widget.canId!)
            .collection(this.widget.batchid! + this.widget.canId!)
            .doc('${index + 1}')
            .update({
          'MarksUpload': true,
          'GivenMarks': listofmarks[index],
        });
      });
      print(tempManipulatedData);

      // ignore: deprecated_member_use
      List<PracticalResult> list = [];
      tempManipulatedData.forEach((key, value) {
        if (value.prNos == "0") {
          value['prNos'] = null;
        }
        list.add(value);
      });
      await EasyLoading.show(status: 'Loading...')
          .then((value) => [updateTheory(list)])
          .whenComplete(() => [
                EasyLoading.showSuccess(
                    'Practical exam was completed successfully'),
                _navigationService.navigateTo(HomePageViewRoute),
                EasyLoading.dismiss(),
              ]);
    }
  }

  void _previous() {
    if (_currentIndex <= (widget.practical!.length - 1)) {
      setState(() {
        _currentIndex--;
      });
      setState(() {
        listofmarks.removeAt(_currentIndex);
      });
    }
  }
}
