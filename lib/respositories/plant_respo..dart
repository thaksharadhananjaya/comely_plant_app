import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plant_app/models/plantModel.dart';

import '../constants.dart';

class PlantRepo {
  Future<List<Plant>> getPlant(bool isFeatued, int page, String search) async {
    try {
      String path = search == null
          ? (!isFeatued
              ? "$url/getPlant.php"
              : "$url/getPlant.php?isFeatured=1")
          : "$url/getPlant.php?search=name LIKE '%$search%' OR City = '$search'";

      final response = await http.post(Uri.parse(path), body: {
        "key": accessKey,
        "page": "$page",
      });
      List<dynamic> list = jsonDecode(response.body);
      List<Plant> postList = [];
      list.map((data) => postList.add(Plant.fromJson(data))).toList();
      print(postList);
      return postList.length == 0 ? null : postList;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
