import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:opgg/const/data.dart';
import 'package:opgg/model/gameList.dart';
import 'package:opgg/model/match_model.dart';
import 'package:opgg/model/summoner_league_model.dart';
import 'package:opgg/model/summoner_model.dart';

class SummonerRepository {
  // 소환사 닉네임으로 정보 조회
  static Future<SummonerModel> getSummonerInfo({required summonerId}) async {
    final response = await Dio().get(
        'https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerId', // 닉네임 파라미터 값 변경 필요
        queryParameters: {
          'api_key': API_KEY,
        });
    return SummonerModel.fromJson(json: response.data);
  }

  // 소환사 id 값으로 랭크정보 조회
  static Future<SummonerLeagueModel> getSummonerLeagueInfo(
      {required summonerId}) async {
    final response = await Dio().get(
        'https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/$summonerId',
        queryParameters: {
          'api_key': API_KEY,
        });
    // print(response.data[0]['tier']);
    return SummonerLeagueModel.fromJson(json: response.data[0]);
  }

  // 소환사 puuid 값으로 매치 id리스트 조회
  static Future<List> getMatchIdFromSummoner({required puuid}) async {
    print(puuid);
    final response = await Dio().get(
        'https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/$puuid/ids?',
        queryParameters: {
          'start': 0,
          'count': 2,
          'api_key': API_KEY,
        });
    // print(response.data);
    return response.data;
  }

  // 매치id 값으로 게임전적 세부정보 조회
  static Future<List<MatchModel>> getMatch(
      {required matchId, required puuid}) async {
    final response = await Dio().get(
        'https://asia.api.riotgames.com/lol/match/v5/matches/$matchId',
        queryParameters: {
          'api_key': API_KEY,
        });

    // print(response.data['info']['participants']
    //     .map<MatchModel>(
    //       (e) => MatchModel.fromJson(json: e),
    // )
    //     .toList());

    // print(response.data['info']['participants']
    //     .map<MatchModel>((e) => MatchModel.fromJson(json: e))
    //     .toList()
    //     .where<MatchModel>(
    //         (e) => MatchModel.fromJson(json: e.puuid = puuid))
    //     .toList());

    // return response.data['info']['participants']['puuid'].where((e) {
    //   return MatchModel.fromJson(json: e.puuid = puuid);
    // });

    // return response.data['info']['participants'].where<MatchModel>((ele) => ele.puuid == puuid);
    // return response.data['info']['participants'].where<MatchModel>((ele) =>MatchModel.fromJson(json: ele)).toList();

    // return MatchModel.fromJson(json: response.data['info']['participants'][0]);

    return response.data['info']['participants']
        .map<MatchModel>(
          (e) => MatchModel.fromJson(json: e),
        )
        .toList();
  }
}
