import 'package:rsm/consts/consts.dart';

class HomeScreenController extends ChangeNotifier {
  int selectedScreenIndex = 0;

  set updateScreen(int val) {
    selectedScreenIndex = val;
    notifyListeners();
  }
}
