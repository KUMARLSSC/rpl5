import 'package:rpl5/ApiModel/practical_question_model.dart';
import '../locator.dart';
import 'api_services.dart';

class PracticalService {
  Api _api = locator<Api>();

  List<Practical>? _practical;
  List<Practical>? get practical => _practical;

  Future getPracticalQuestion(int resId) async {
    _practical = await _api.getPractical(resId);
  }
}
