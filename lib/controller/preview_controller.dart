import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:pixelperks/model/preview.dart';

enum Endpoint {
  latest,
  ec,
  trending,
  animal,
  village,
  uhd,
  erotic,
  fantasy,
  mountains,
  flowers,
  lingerie,
  topless,
  ocean,
  photography,
  fields,
  forest,
  architecture,
  street,
  dark,
  rain,
  food,
  hiking,
  river,
  monochrome,
  nature,
  galaxy,
  love,
}

class PreviewController extends GetxController {
  RxMap<Endpoint, List<PreviewImage>> server = <Endpoint, List<PreviewImage>>{
    Endpoint.latest: [],
    Endpoint.ec: [],
    Endpoint.trending: [],
    Endpoint.animal: [],
    Endpoint.village: [],
    Endpoint.uhd: [],
    Endpoint.lingerie: [],
    Endpoint.fantasy: [],
    Endpoint.flowers: [],
    Endpoint.mountains: [],
    Endpoint.topless: [],
    Endpoint.ocean: [],
    Endpoint.erotic: [],
    Endpoint.photography: [],
    Endpoint.fields: [],
    Endpoint.forest: [],
    Endpoint.architecture: [],
    Endpoint.street: [],
    Endpoint.dark: [],
    Endpoint.rain: [],
    Endpoint.food: [],
    Endpoint.hiking: [],
    Endpoint.river: [],
    Endpoint.monochrome: [],
    Endpoint.nature: [],
    Endpoint.galaxy: [],
    Endpoint.love: [],
  }.obs;

  void addSateCache(List<PreviewImage> images, Endpoint e) {
    server.value = {...server, e: images};
  }
}

Future<PreviewImageServer> fetchInitial(String route) async {
  final dio = Dio();

  try {
    final res = await dio.get(
      'https://pixel-perks.vercel.app/$route',
      queryParameters: {"secret": dotenv.env['SECRET']},
    );
    return PreviewImageServer.fromJson(res.data, fromSafeSource: true);
  } catch (e) {
    // print(e);
    throw Exception('error');
  }
}

Future<PreviewImageServer> fetchCategorized(
    {required String category, bool isSafe = true}) async {
  final dio = Dio();

  try {
    final res = await dio.get(
      'https://pixel-perks.vercel.app/categorized',
      queryParameters: {
        "secret": dotenv.env['SECRET'],
        "category": category,
        "isSafe": isSafe,
      },
    );
    return PreviewImageServer.fromJson(res.data, fromSafeSource: isSafe);
  } catch (e) {
    // print(e);
    throw Exception('error');
  }
}
