import 'package:flutter/cupertino.dart';
import 'package:my_app/data/model/state_fetcher.dart';
import 'package:my_app/data/model/user.dart';
import 'package:my_app/data/repository/repository.dart';

class ListUserFetcher with ChangeNotifier {
  List<User>? user;
  String? error;
  StateFetcher stateFetcher = StateFetcher.initial;

  void fetchListUser() async {
    stateFetcher = StateFetcher.loading;
    try {
      user = await Repository().getListUser();
      stateFetcher = StateFetcher.loaded;
    } catch (e) {
      stateFetcher = StateFetcher.error;
      error = e.toString();
    }
    notifyListeners();
  }
}
