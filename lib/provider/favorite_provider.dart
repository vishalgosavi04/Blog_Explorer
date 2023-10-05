import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _id = [];
  List<String> get words => _id;
  void toggleFavorite(String word) {
    final isExist = _id.contains(word);
    if (isExist) {
      _id.remove(word);
    } else {
      _id.add(word);
    }
    notifyListeners();
  }

  bool isExist(String word) {
    final isExist = _id.contains(word);
    return isExist;
  }

 
  static FavoriteProvider of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }

}