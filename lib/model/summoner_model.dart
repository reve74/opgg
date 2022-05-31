class SummonerModel {
  final String id;
  final String accountId;
  final String puuid;
  final String name;
  final int profileIconId;
  final int revisionDate;
  final int summonerLevel;

  SummonerModel({
    required this.id,
    required this.accountId,
    required this.puuid,
    required this.name,
    required this.profileIconId,
    required this.revisionDate,
    required this.summonerLevel,
  });

  SummonerModel.fromJson({required Map<String, dynamic> json})
      :
        profileIconId = json['profileIconId'] ??'', // String -> double
        revisionDate =  json['revisionDate'] ?? '',
        summonerLevel = json['summonerLevel'] ??'',
        id = json['id'] ?? '',
        accountId = json['accountId'] ?? '',
        puuid = json['puuid'] ?? '',
        name = json['name'] ?? '';

        // profileIconId = int.parse(json['profileIconId'] ?? 0), // String -> double
        // revisionDate =  int.parse(json['revisionDate'] ?? 0),
        // summonerLevel = int.parse(json['summonerLevel'] ?? 0);

  // profileIconId = double.parse(json['profileIconId'] ?? ''), // String -> double
  //       revisionDate = double.parse(json['revisionDate'] ?? ''),
  //       summonerLevel = double.parse(json['summonerLevel'] ?? '');


}
