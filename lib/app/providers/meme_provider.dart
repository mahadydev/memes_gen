import 'package:flutter/material.dart';

import '../features/meme_home/meme_home_service.dart';
import '../models/meme.dart';

class MemeProvider extends ChangeNotifier {
  List<MemeModel> _memes = [];
  String _searchText = '';

  List<MemeModel> get memes => _memes;
  String get searchText => _searchText;

  set searchText(String value) {
    _searchText = value.toLowerCase();
    notifyListeners();
  }

  Future<void> fetchMemes() async {
    _memes = await MemeService.getMemes();
    notifyListeners();
  }

  List<MemeModel> get filteredMemes => _memes
      .where((meme) => meme.name.toLowerCase().contains(_searchText))
      .toList();
}
