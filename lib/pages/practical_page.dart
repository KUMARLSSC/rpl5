import 'package:flutter/material.dart';
import 'package:rpl5/ApiModel/practical_question_model.dart';
import 'package:rpl5/ViewModel/practical_page_viewmodel.dart';
import 'package:rpl5/pages/practical_page_widget.dart';
import 'package:stacked/stacked.dart';

class PracticalPage extends StatefulWidget {
  final Practical? practical;
  final String? batchid;
  final String? canId;
  PracticalPage({this.practical, this.batchid, this.canId});
  @override
  _PracticalPageState createState() => _PracticalPageState();
}

class _PracticalPageState extends State<PracticalPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PracticalPageViewModel>.reactive(
      onModelReady: (model) =>
          model.getPractical(int.parse(this.widget.batchid!)),
      viewModelBuilder: () => PracticalPageViewModel(),
      builder: (context, model, child) => model.busy == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PracticalPageWidget(
              batchid: this.widget.batchid!,
              canId: this.widget.canId!,
              practical: model.posts,
              practical1: widget.practical,
            ),
    );
  }
}
