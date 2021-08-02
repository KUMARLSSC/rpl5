import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_video_player/flutter_web_video_player.dart';
import 'package:provider/provider.dart';
import 'package:rpl5/dialog_service.dart';
import 'package:rpl5/login_page.dart';
import 'package:rpl5/pages/home_page.dart';
import 'package:rpl5/router.dart';

import 'controllers/menu_controller.dart';
import 'dialog_manager.dart';
import 'locator.dart';
import 'navigation_service.dart';

/// Let's start to make responsive website
/// First make app responsive class
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RPL5 Practical Video',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MenuController()),
        ],
        child: LoginPage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('RPL-5PracticalVideo').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("RPL-5PracticalVideo"),
          centerTitle: true,
        ),
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
                      height: documentSnapshot['url'] != null ? null : 60,
                      margin: const EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // If the image is not null load the imageURL
                                documentSnapshot['url'] != null
                                    ? SizedBox(
                                        height: 250,
                                        child: WebVideoPlayer(
                                          src: documentSnapshot['url'],
                                        ))
                                    // If the image is null show nothing
                                    : Container(),
                                Text(documentSnapshot['candidateName']),
                              ],
                            ),
                          )),
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
