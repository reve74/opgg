import 'package:get/get.dart';
import 'package:opgg/model/match_model.dart';
import 'package:opgg/model/summoner_league_model.dart';
import 'package:opgg/repository/repository.dart';

class SummonerController extends GetxController {
  static SummonerController get to => Get.find();


  Future<SummonerLeagueModel> getSummonerLeagueInfo(
      {required summonerId}) async {
    final response =
    await SummonerRepository.getSummonerLeagueInfo(summonerId: summonerId);

    return response;
  }

  Future<List> getMatchIdFromSummoner({required puuid}) async {
    final response =
    await SummonerRepository.getMatchIdFromSummoner(puuid: puuid);
    // List matchList = [];
    // matchList.addAll(response);
    return response;
  }

  Future<List<MatchModel>> getMatch({required matchId, required puuid}) async {
    // Map<, MatchModel> matches = {};
    final response =
    await SummonerRepository.getMatch(matchId: matchId, puuid: puuid);

    // List<Future> futures = [];
    // final results = await Future.wait(futures);
    //
    // for(int i =0; i<matchList.length; i++) {
    //   final key = matchList.elementAt(i);
    //   final value = results[i];
    // }

    // print(response);
    return response;
  }


}