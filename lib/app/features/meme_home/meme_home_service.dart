import 'dart:convert';

import '../../models/meme.dart';
import 'package:http/http.dart' as http;

class MemeService {
  static Future<List<MemeModel>> getMemes() async {
    final response =
        await http.get(Uri.parse('https://api.imgflip.com/get_memes'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data']['memes'];
      return (data as List)
          .map((memeJson) => MemeModel.fromJson(memeJson))
          .toList();
    } else {
      throw Exception('Failed to load memes');
    }
  }
}
