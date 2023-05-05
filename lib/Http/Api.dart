import 'dart:convert';

import 'package:go2tv/Modal/CategoryModal.dart';
import 'package:go2tv/Modal/SubCategoryModal.dart';
import 'package:http/http.dart' as http;
import 'package:go2tv/Const/constant.dart';
import 'package:go2tv/Modal/MatchModal.dart';
import 'package:go2tv/Modal/QualityModal.dart';

class Api {
  static Future<List<CategoryModal>> getCategory() async {
    List<CategoryModal> list = [];
    var request = http.MultipartRequest('POST', Uri.parse(categoryUrl));
    request.fields.addAll(
        {'id': '1iw_Y_0Kp_nbVPXXiLHvsxdFl_l28CP9vvgY2uB57_rk', 'gid': '0'});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsons = await response.stream.bytesToString();
      var decode = jsonDecode(jsons);
      List listy = decode as List;
      list = listy.map((e) => CategoryModal.from(e)).toList();
      return list;
    } else {
      print(response.reasonPhrase);
    }

    return list;
  }

  static Future<List<SubCategoryModal>> getSubCategory(String url) async {
    List<SubCategoryModal> list = [];
    var request = http.MultipartRequest('POST', Uri.parse(subcategoryUrl));
    request.fields.addAll({'url': url});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsons = await response.stream.bytesToString();
      var decode = jsonDecode(jsons);
      List listy = decode as List;
      list = listy.map((e) => SubCategoryModal.fromJson(e)).toList();
    } else {
      print(response.reasonPhrase);
    }

    return list;
  }
  static Future<List<MatchModal>> getAllMatchs() async {
    List<MatchModal> lists = [];

    await http.get(Uri.parse(livematch)).then((value) {
      var decode = json.decode(value.body);
      List list = decode as List;

      List<MatchModal> listy = list.map((e) => MatchModal.from(e)).toList();
      lists = listy;
      return listy;
    }).catchError((e) => print(e));
    return lists;
  }
  static Future<List<QualityModal>> getLink(String id) async {
    List<QualityModal> lists = [];
    await http.get(Uri.parse(live + id)).then((value) {
      // print(value.body);
      var decode = json.decode(value.body);
      List list = decode as List;
      List<QualityModal> listy = list.map((e) => QualityModal.from(e)).toList();
      lists = listy;
      return listy;
    }).catchError((e) => print(e));
    return lists;
  }
}
