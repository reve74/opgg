import 'package:dio/dio.dart';
import 'package:opgg/const/data.dart';
import 'package:opgg/model/summoner_league_model.dart';
import 'package:opgg/model/summoner_model.dart';


class SummonerRepository {
  static Future<SummonerModel> getSummonerInfo({required summonerId}) async {
    final response = await Dio().get(
        'https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerId', // 닉네임 파라미터 값 변경 필요
        queryParameters: {
          'api_key': API_KEY,
        });

    // print(response.data);
    // print(response.data['profileIconId']);
    return SummonerModel.fromJson(json: response.data);
  }

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
}
