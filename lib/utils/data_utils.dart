import 'package:opgg/model/summoner_league_model.dart';
import 'package:opgg/model/summoner_tier.dart';
import 'package:opgg/repository/tier_level.dart';

class DataUtils {
  static SummonerTier getSummonerRank({required String tier, required String value}) {
    return tierLevel.where(
      (league) {
        if (tier == 'Bronze') {
          return league.tier == value;
        } else {
          throw Exception();
        }
      },
    ).last;
  }
}
