class SummonerLeagueModel {
  final String leagueId;
  final String queueType;
  final String tier;
  final String rank;

  final int leaguePoints;
  final int wins;
  final int losses;

  SummonerLeagueModel({
    required this.leagueId,
    required this.queueType,
    required this.tier,
    required this.rank,
    required this.leaguePoints,
    required this.wins,
    required this.losses,
  });

  SummonerLeagueModel.fromJson({required Map<String, dynamic> json})
      : leagueId = json['leagueId'] ?? '',
        queueType = json['queueType'] ?? '',
        tier = json['tier'] ?? '',
        rank = json['rank'] ?? '',
        leaguePoints = json['leaguePoints'] ?? '',
        wins = json['wins'] ?? '',
        losses = json['losses'] ?? '';
}
