import 'package:flutter/material.dart';

class RankCard extends StatelessWidget {
  final String imagePath;
  final String tier;
  final String rank;
  final int wins;
  final int loses;
  final int leaguePoints;

  const RankCard({
    required this.imagePath,
    required this.tier,
    required this.rank,
    required this.wins,
    required this.loses,
    required this.leaguePoints,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 300,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Image.asset(
                   imagePath,
                    width: 70,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: Text(
                              '개인/2인 랭크',
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 12.0),
                            ),
                          ),
                          Text(
                            '$tier $rank',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            '$leaguePoints LP',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            '$wins승 $loses패 (52%)',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    'asset/img/next.png',
                    width: 28,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 300,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Image.asset(
                    imagePath,
                    width: 70,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: Text(
                              '개인/2인 랭크',
                              style: TextStyle(
                                  color: Colors.blueAccent, fontSize: 12.0),
                            ),
                          ),
                          Text(
                            '$tier 2',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            '10 LP',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            '33승 0패 (100%)',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    'asset/img/next.png',
                    width: 28,
                    color: Colors.grey[500],
                  ),
                  const SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
