import 'package:rpl5/ApiModel/practical_question_model.dart';
import 'package:rpl5/ViewModel/base_model.dart';
import 'package:rpl5/services/navigation_service.dart';
import 'package:rpl5/services/practical_service.dart';
import '../../locator.dart';

class PracticalPageViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PracticalService _practicalService = locator<PracticalService>();

  List<Practical>? get posts => _practicalService.practical;

  Future getPractical(int resId) async {
    setBusy(false);
    await _practicalService.getPracticalQuestion(resId);
    setBusy(true);
  }
}
