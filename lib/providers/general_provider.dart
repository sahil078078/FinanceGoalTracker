import '../exported.dart';

class GeneralProvider extends ChangeNotifier {
  ///! default goal is home
  Map<String, dynamic> selectedGoal = userGoal[0];
  void changeGoal(Map<String, dynamic> _) {
    selectedGoal = _;
    notifyListeners();
  }

  ///! Bottom Navigation Bar
  int _index = 0;
  int get bottomNavIndex => _index;
  void changeBottomBarIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
