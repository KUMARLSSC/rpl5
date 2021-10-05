import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rpl5/ApiModel/practical_question_model.dart';
import 'package:rpl5/services/navigation_service.dart';

import '../locator.dart';

class Api {
  List<dynamic>? canId;
  final NavigationService _navigationService = locator<NavigationService>();
  static const urlpoint =
      'https://webapplication320200218110357.azurewebsites.net';
  var client = new http.Client();

  Future<List<Practical>> getPractical(int resId) async {
    // ignore: deprecated_member_use
    List<Practical> _practical = [];
    // Get user posts for id
    var response = await client.get(Uri.parse(
        'https://webapplication320200218110357.azurewebsites.net/api/PracticalQuestion/$resId'));

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to Post
    for (var candidate in parsed) {
      _practical.add(Practical.fromJson(candidate));
    }

    return _practical;
  }
}
