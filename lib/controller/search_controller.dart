import 'package:get/get.dart';
import 'package:opgg/model/summoner_model.dart';
import 'package:opgg/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find();
  String key = 'SearchKey';
  RxList<String> history = RxList<String>.empty(growable: true);
  // Set<String> originHistory = {};
  SharedPreferences? profs;
  // Rx<SummonerModel> summonerModel = SummonerModel().obs;

  @override
  void onInit() async {
    profs = await SharedPreferences.getInstance();
    List<dynamic> initData = (profs!.get(key) ?? []) as List;
    // originHistory.addAll(initData.map((e) => e.toString()).toList());
    history(initData.map<String>((e) => e.toString()).toList());
    super.onInit();
  }

  void search(String summonerId) {
    // history.clear();
    // originHistory.add(search);
    history.addIf(!history.contains(summonerId), summonerId);
    profs!.setStringList(key, history);
    searchSummoner(summonerId);
  }

  void searchSummoner(String summonerId) async {
    SummonerModel summonerModel =
        await SummonerRepository.getSummonerInfo(summonerId: summonerId);
    print(summonerModel.puuid);
  }

  void deleteAllSearchList() {
    history.clear();
  }

  void deleteSearchList(String index) {
    final selected = history.indexOf(index);
    print(selected);
    history.removeAt(selected);
    profs!.setStringList(key, history);
    print(history);
  }
}
