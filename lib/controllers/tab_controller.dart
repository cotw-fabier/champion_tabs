import 'package:flutter/widgets.dart';

class ChampionTabController extends ChangeNotifier {
  int activeTab;
  ChampionTabController({this.activeTab = 0});

  void changeTab(int newTab) {
    activeTab = newTab;
    notifyListeners();
  }
}
