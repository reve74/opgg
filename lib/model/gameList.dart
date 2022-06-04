import 'package:opgg/model/match_model.dart';

class GameList {
  final MatchModel myDetails;
  final List<MatchModel> othersDetails;

  GameList({
    required this.myDetails,
    required this.othersDetails,
  });
}
