class MatchModel {
  final int kills;
  final int deaths;
  final int assists;
  final int champLevel;
  final String championName;
  final int item0;
  final int item1;
  final int item2;
  final int item3;
  final int item4;
  final int item5;
  final int item6;
  final bool win;
  final String summonerName;
  final String puuid;

  MatchModel({
    required this.kills,
    required this.deaths,
    required this.assists,
    required this.champLevel,
    required this.championName,
    required this.item0,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
    required this.item5,
    required this.item6,
    required this.win,
    required this.summonerName,
    required this.puuid,
  });

  MatchModel.fromJson({required Map<String, dynamic> json})
      : kills = json['kills'] ?? '',
        deaths = json['deaths'] ?? '',
        assists = json['assists'] ?? '',
        champLevel = json['champLevel'] ?? '',
        championName = json['championName'] ?? '',
        item0 = json['item0'] ?? '',
        item1 = json['item1'] ?? '',
        item2 = json['item2'] ?? '',
        item3 = json['item3'] ?? '',
        item4 = json['item4'] ?? '',
        item5 = json['item5'] ?? '',
        item6 = json['item6'] ?? '',
        win = json['win'] ?? '',
        summonerName = json['summonerName'] ?? '',
        puuid = json['puuid'] ?? '';
}
