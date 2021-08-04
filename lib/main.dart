import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_video_player/flutter_web_video_player.dart';
import 'package:provider/provider.dart';
import 'package:rpl5/candidate_page.dart';
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
      home: LoginPage(),
    );
  }
}
